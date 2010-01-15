#!/bin/awk
# -*- indent-tabs-mode: nil; c-basic-offset: 2 -*-
# rnc2rng.awk - Convert RELAX NG Compact Syntax to XML Syntax
# Copyright (C) 2007 Shaun McCance <shaunm@gnome.org>
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your
# option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

# This program is free software, but that doesn't mean you should use it.
# I wanted to write and maintain the Mallard schema in RNC in code blocks
# within the specification, but I needed to distribute the schema in RNG.
# Since xmllint (libxml2) does not currently support RNC, and since I'm
# not willing to introduce more dependencies, awk was my only option.
#
# This awk script is *NOT* a complete implementation, and probably never
# will be.  Its sole purpose is to handle the Mallard schema, and it is
# sufficient for that task.
#
# You are, of course, free to use any of this.  If you do proliferate this
# hack, it is requested (though not required, that would be non-free) that
# you atone for your actions.  A good atonement would be contributing to
# free software.

function parse_pattern (line) {
  sub(/^ */, "", line)
  if (length(line) == 0) return;
  c = substr(line, 1, 1);
  if (c == "(" || c == "{") {
    stack[++stack_i] = substr(line, 1, 1);
    paren[++paren_i] = stack_i;
    if (length(line) >= 2)
      parse_pattern(substr(line, 2));
  }
  else if (c == ")" || c == "}") {
    open = stack[paren[paren_i]];
    oc = substr(open, 1, 1) c;
    if (oc != "()" && oc != "{}") {
      print "Mismatched parentheses on line " FNR | "cat 1>&2";
      error = 1;
      exit 1
    }

    tag = "";
    if (length(open) > 1 && substr(open, 2, 1) == "&") {
      tag = "interleave";
    }
    else if (length(open) > 1 && substr(open, 2, 1) == "|") {
      tag = "choice";
    }
    else if (oc == "()") {
      tag = "group";
    }

    tmp = "";
    if (tag != "") {
      tmp = "<" tag ">";
    }
    for (i = paren[paren_i] + 1; i <= stack_i; i++) {
      tmp = tmp stack[i] "\n";
    }
    if (tag != "") {
      tmp = tmp "</" tag ">";
    }
    stack_i = paren[paren_i];
    stack[stack_i] = tmp;
    paren_i--;

    if (oc == "{}") {
      if (match(stack[stack_i - 1], "^<element")) {
        tmp = stack[stack_i - 1] "\n";
        if (stack[stack_i] != "") {
          tmp = tmp stack[stack_i] "\n";
        } else {
          tmp = tmp "<empty/>\n";
        }
        tmp = tmp "</element>";
        stack[--stack_i] = tmp;
      }
      else if (match(stack[stack_i - 1], "^<attribute")) {
        tmp = stack[stack_i - 1] "\n";
        if (stack[stack_i] != "") {
          tmp = tmp stack[stack_i] "\n";
        } else {
          tmp = tmp "<empty/>\n";
        }
        tmp = tmp "</attribute>";
        stack[--stack_i] = tmp;
      }
      else if (stack[stack_i - 1] == "<list>") {
        tmp = stack[stack_i - 1] "\n";
        tmp = tmp stack[stack_i] "\n";
        tmp = tmp "</list>";
        stack[--stack_i] = tmp;
      }
      else if (stack[stack_i - 1] == "<mixed>") {
        tmp = stack[stack_i - 1] "\n";
        tmp = tmp stack[stack_i] "\n";
        tmp = tmp "</mixed>";
        stack[--stack_i] = tmp;
      }
    }
    if (paren_i == 0) {
      mode = "grammar";
    }
    if (length(line) >= 2)
      parse_pattern(substr(line, 2));
  }
  else if (c == "|" || c == "&" || c == ",") {
    if (length(stack[paren[paren_i]]) == 1) {
      stack[paren[paren_i]] = stack[paren[paren_i]] c;
    }
    else if (length(stack[paren[paren_i]]) < 2 || substr(stack[paren[paren_i]], 2) != c) {
      print "Mismatched infix operators on line " FNR | "cat 1>&2";
      error = 1;
      exit 1
    }
    if (length(line) >= 2)
      parse_pattern(substr(line, 2));
  }
  else if (c == "?") {
    stack[stack_i] = "<optional>" stack[stack_i] "</optional>"
    if (length(line) >= 2)
      parse_pattern(substr(line, 2));
  }
  else if (c == "*") {
    stack[stack_i] = "<zeroOrMore>" stack[stack_i] "</zeroOrMore>"
    if (length(line) >= 2)
      parse_pattern(substr(line, 2));
  }
  else if (c == "+") {
    stack[stack_i] = "<oneOrMore>" stack[stack_i] "</oneOrMore>"
    if (length(line) >= 2)
      parse_pattern(substr(line, 2));
  }
  else if (c == "\"") {
    txt = substr(line, 2);
    sub(/".*/, "", txt)
    stack[++stack_i] = "<value>" txt "</value>";
    if (length(line) >= length(txt) + 3)
      parse_pattern(substr(line, length(txt) + 3));
  }
  else if (match(line, "^element ")) {
    aft = substr(line, 8);
    sub(/^ */, "", aft);
    name = aft;
    stack[++stack_i] = "<element";
    mode = "name_class";
    name_class_i = stack_i;
    parse_name_class(name);
  }
  else if (match(line, "^attribute ")) {
    aft = substr(line, 10);
    sub(/^ */, "", aft);
    name = aft;
    stack[++stack_i] = "<attribute";
    mode = "name_class";
    name_class_i = stack_i;
    parse_name_class(name);
  }
  else if (match(line, "^list ")) {
    aft = substr(line, 5);
    sub(/^ */, "", aft);
    stack[++stack_i] = "<list>";
    if (aft != "") { parse_pattern(aft); }
  }
  else if (match(line, "^mixed ")) {
    aft = substr(line, 6);
    sub(/^ */, "", aft);
    stack[++stack_i] = "<mixed>";
    if (aft != "") { parse_pattern(aft); }
  }
  else if (match(line, /^text[^A-Za-z]/) || match(line, /^text$/)) {
    stack[++stack_i] = "<text/>";
    aft = substr(line, 5);
    sub(/^ */, "", aft);
    if (aft != "") { parse_pattern(aft); }
  }
  else if (match(line, "^default namespace ")) {
    print "default namespace appeared out of context on line " FNR | "cat 1>&2";
    error = 1;
    exit 1
  }
  else if (match(line, "^namespace ")) {
    print "namespace appeared out of context on line " FNR | "cat 1>&2";
    error = 1;
    exit 1
  }
  else if (match(line, "^start ")) {
    print "start appeared out of context on line " FNR | "cat 1>&2";
    error = 1;
    exit 1
  }
  else if (match(line, /^xsd:[A-Za-z_]/)) {
    name = substr(line, 1);
    sub(/^xsd:/, "", name);
    sub(/[^A-Za-z_]+.*/, "", name);
    stack[++stack_i] = sprintf("<data type='%s' datatypeLibrary='http://www.w3.org/2001/XMLSchema-datatypes'/>",
                               name);
    if (length(line) >= length(name) + 5) {
      aft = substr(line, length(name) + 5);
      parse_pattern(aft);
    }
  }
  else if (match(line, /^[A-Za-z_]/)) {
    name = substr(line, 1);
    sub(/[^A-Za-z_]+.*/, "", name);
    stack[++stack_i] = sprintf("<ref name='%s'/>", name);
    if (length(line) >= length(name) + 1) {
      aft = substr(line, length(name) + 1);
      parse_pattern(aft);
    }
  }
}

function parse_name_class (line) {
  sub(/^ */, "", line)
  if (length(line) == 0) return;
  c = substr(line, 1, 1);
  if (c == "{") {
    if (stack_i != name_class_i) {
      tmp = "";
      for (i = stack_i; i >= name_class_i; i--) {
        if (stack[i] == "<except>") {
          tmp = "<except>" tmp "</except>";
        }
        else if (stack[i] == "<anyName>") {
          tmp = "<anyName>" tmp "</anyName>";
        }
        else {
          tmp = stack[i] tmp
        }
      }
      stack[name_class_i] = tmp;
      stack_i = name_class_i;
    }
    mode = "pattern";
    parse_pattern(line);
  }
  else if (c == "*") {
    if (stack[stack_i] == "<element" || stack[stack_i] == "<attribute") {
      stack[stack_i] = stack[stack_i] ">";
    }
    stack[++stack_i] = "<anyName>";
    parse_name_class(substr(line, 2));
  }
  else if (c == "-") {
    stack[++stack_i] = "<except>"
    parse_name_class(substr(line, 2));
  }
  else if (c == "|") {
    if (length(stack[paren[paren_i]]) == 1) {
      stack[paren[paren_i]] = stack[paren[paren_i]] c;
    }
    else if (substr(stack[paren[paren_i]], 2) != "|") {
      print "Mismatched infix operators on line " FNR | "cat 1>&2";
      error = 1;
      exit 1
    }
    parse_name_class(substr(line, 2));
  }
  else if (c == "(") {
    stack[++stack_i] = "(";
    paren[++paren_i] = stack_i;
    parse_name_class(substr(line, 2));
  }
  else if (c == ")") {
    open = stack[paren[paren_i]];
    if (substr(open, 1, 1) != "(") {
      print "Mismatched parentheses on line " FNR | "cat 1>&2";
      error = 1;
      exit 1
    }
    if (length(open) == 1 || substr(open, 2, 1) != "|") {
      print "Unknown name class pattern on line " FNR | "cat 1>&2";
      error = 1;
      exit 1
    }
    tmp = ""
    for (i = paren[paren_i] + 1; i <= stack_i; i++) {
      tmp = tmp stack[i] "\n";
    }
    stack_i = paren[paren_i];
    stack[stack_i] = tmp;
    paren_i--;
    parse_name_class(substr(line, 2));
  }
  else if (match(line, /^[A-Za-z_]/)) {
    name = substr(line, 1);
    sub(/[^A-Za-z_]+.*/, "", name);
    if (length(line) >= length(name) + 1)
      aft = substr(line, length(name) + 1);
    else
      aft = "";
    if (length(aft) >= 2 && substr(aft, 1, 2) == ":*") {
      for (i = 1; i <= namespaces_i; i++) {
        if (nsnames[i] == name) {
          stack[++stack_i] = sprintf("<nsName ns='%s'/>", namespaces[i])
          break;
        }
      }
      if (length(aft) >= 3)
        aft = substr(aft, 3);
      else
        aft = "";
    }
    else if (stack[stack_i] == "<element" || stack[stack_i] == "<attribute") {
      stack[stack_i] = stack[stack_i] sprintf(" name='%s'>", name);
    }
    else {
      stack[++stack_i] = sprintf("<name>%s</name>", name);
    }
    parse_name_class(aft);
  }
}

function printstack () {
  pos = 1;
  while (pos <= stack_i) {
    printstackone();
  }
}
function printstackone () {
  if (substr(stack[pos], 1, 6) == "<start") {
    print stack[pos];
    pos++;
    printstackone();
    print "</start>"
  }
  else if (substr(stack[pos], 1, 7) == "<define") {
    print stack[pos];
    pos++;
    printstackone();
    print "</define>"
  }
  else {
    print stack[pos];
    pos++;
  }
}

BEGIN {
  mode = "grammar";
  stack_i = 0;
  paren_i = 0;
  namespaces_i = 0;
  error = 0;
}

END {
  if (!error) {
    print "<grammar xmlns='http://relaxng.org/ns/structure/1.0'";
    pos = 1;
    while (pos <= namespaces_i) {
      if (namespaces[pos] != "") {
        printf " xmlns:%s='%s'", nsnames[pos], namespaces[pos];
      }
      pos++;
    }
    printf " ns='%s'>\n", default_namespace;
    printstack()
    print "</grammar>"
  }
}

mode == "pattern" && paren_i == 0 && /.*=/ { mode = "grammar"; }
mode == "grammar" && /.*=/ {
  if (match($0, "^default namespace ")) {
    namespace = substr($0, index($0, "=") + 1);
    nsname = substr($0, 19, index($0, "=") - 19);
    sub(/^ */, "", nsname);
    sub(/ *$/, "", nsname);
    sub(/^ *"/, "", namespace);
    sub(/" *$/, "", namespace);
    if (nsname != "") {
      nsnames[++namespaces_i] = nsname;
      namespaces[namespaces_i] = namespace;
    }
    default_namespace = namespace
  }
  else if (match($0, "^namespace ")) {
    namespace = substr($0, index($0, "=") + 1);
    nsname = substr($0, 11, index($0, "=") - 11);
    sub(/^ */, "", nsname);
    sub(/ *$/, "", nsname);
    sub(/^ *"/, "", namespace);
    sub(/" *$/, "", namespace);
    if (nsname != "") {
      nsnames[++namespaces_i] = nsname;
      namespaces[namespaces_i] = namespace;
    }
  }
  else {
    nameix = index($0, "=");
    if (nameix < 1) next;
    name = substr($0, 1, nameix - 1);
    sub(/ /, "", name);
    if (name == "start")
      stack[++stack_i] = "<start>"
    else
      stack[++stack_i] = sprintf("<define name='%s'>", name);
    mode = "pattern";
    if (length($0) >= nameix + 1)
      parse_pattern(substr($0, nameix + 1))
  }
  next;
}
mode == "pattern" {
  parse_pattern($0);
  next;
}
mode == "name_class" {
  parse_name_class($0);
  next;
}
