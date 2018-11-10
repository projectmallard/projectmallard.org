<?xml version='1.0' encoding='UTF-8'?><!-- -*- indent-tabs-mode: nil -*- -->
<!--
This program is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
details.

You should have received a copy of the GNU Lesser General Public License
along with this program; see the file COPYING.LGPL.  If not, write to the
Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                xmlns:mal="http://projectmallard.org/1.0/"
                xmlns="http://www.w3.org/1999/xhtml"
                extension-element-prefixes="exsl"
                exclude-result-prefixes="mal str"
                version="1.0">

<xsl:param name="theme.icons.size.note" select="24"/>

<xsl:param name="color.yellow_border" select="'#fcaf3e'"/>
<xsl:param name="color.text_light" select="'#555753'"/>
<xsl:param name="color.blue_border" select="'#3465a4'"/>

<xsl:param name="color.yellow" select="'#fcaf3e'"/>
<xsl:param name="color.fg.dark" select="'#555753'"/>
<xsl:param name="color.blue" select="'#3465a4'"/>

<xsl:template name="html.head.custom">
  <link href="http://fonts.googleapis.com/css?family=Cantarell:400,400i,700,700i" rel="stylesheet" type="text/css"/>
  <link href="http://fonts.googleapis.com/css?family=Bitter:400,700" rel="stylesheet" type="text/css"/>
  <link href="http://fonts.googleapis.com/css?family=Special+Elite" rel="stylesheet" type="text/css"/>
  <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
</xsl:template>

<xsl:template name="html.css.custom">
<xsl:text>
body {
  font-family: 'Cantarell', sans-serif;
  font-size: 18px;
}
div.top {
  width: 100%;
  margin: 0;
  padding-top: 20px;
  background: #2e3436 url(noise.png);
  color: #eeeeec;
}
div.top > div.contents {
  max-width: 960px;
  margin: 0 auto 0 auto;
  padding: 0 0 10px 0;
  border-bottom: solid 6px #fcaf3e;
}
div.top img {
  float: left;
  margin: 4px 10px 0 10px;
}
div.top-mallard {
  font-family: Bitter;
  font-weight: bold;
  font-size: 74px;
  line-height: 0.83em;
  margin: 0;
  padding-left: 100px;
}
div.top-tagline {
  font-family: 'Special Elite';
  font-weight: normal;
  margin: 8px 0 0 0;
  font-size: 22px;
  line-height: 1em;
  padding-left: 100px;
}
div.top a {
  text-decoration: none;
  border: none;
  color: #eeeeec;
  text-shadow: 2px 2px 0 #1c1f20;
}
@media only screen and (max-width: 480px) {
  div.top img { display: none; }
  div.top-mallard, div.top-tagline { padding-left: 10px; }
}
div.editongithub {
  float: right;
  margin: -1.5em 0 0 0;
}
div.editongithub a {
  display: inline-block;
  padding: 0.2em 0.5em;
  border-radius: 2px;
  color: #eeeeec;
  color: #d3d7cf;
  text-shadow: 1px 1px 0 #1c1f20;
}
div.editongithub a:hover {
  border: none;
  background: #3465a4 url(noiseblue.png);
  color: white;
}
@media only screen and (max-width: 600px) {
  div.editongithub { display: none; }
}
div.trails {
  font-size: 16px;
  padding-top: 8px;
  padding-bottom: 8px;
}
div.pmo-jump {
  max-width: 300px;
  margin: 1em 20px 0 0;
  padding: 0;
  vertical-align: top;
  float: left;
}
div.pmo-jump-right {
  margin-right: 0;
}
@media only screen and (max-width: 960px) {
  div.pmo-jump {
    float: none;
    max-width: 620px;
    margin: 1em 0 0 0;
  }
  div.pmo-jump-right {
    margin-top: 0;
  }
}
div.pmo-jump li {
  margin: 1em 0 2em 0;
  padding: 0;
  list-style: none;
  min-height: 4em;
}
div.pmo-jump-top {
  margin: 2em 0 0 0;
  max-width: 620px;
  float: none;
}
div.pmo-jump-top ul {
  max-width: 300px;
  margin: 0 auto;
}
div.pmo-jump-top li {
  min-height: none;
  margin: 0;
}
div.pmo-jump li a {
  border-bottom: none;
  vertical-align: top;
  display: block;
  color: #3465a4;
font-size: 20px;
  line-height: 1em;
}
div.pmo-jump li a > span {
  color: #888a85;
  display: block;
  margin-top: 4px;
  padding-left: 48px;
  font-size: 0.83em;
  font-size: 16px;
  text-align: left;
}
div.pmo-jump li a > span.em {
  color: #3465a4;
  margin-top: 0;
  font-size: 1em;
}
div.pmo-jump li a:hover > span {
  color: #729fcf;
}
div.pmo-jump li a:hover > span.em {
  color: #3465a4;
}
div.pmo-jump li a:before {
  font-family: FontAwesome;
  font-size: 40px;
  width: 40px;
  text-align: center;
  margin-top: 8px;
  margin-right: 8px;
  vertical-align: top;
  float: left;
}
li.pmo-jump-event a:before {
  content: "&#xf073;";
}
li.pmo-jump-about a:before {
  content: "&#xf05a;";
}
li.pmo-jump-learn a:before {
  content: "&#xf1cd;";
}
li.pmo-jump-download a:before {
  content: "&#xf019;";
}
li.pmo-jump-contact a:before {
  content: "&#xf086;";
}
li.pmo-jump-mep a:before {
  content: "&#xf0c3;";
}
li.pmo-jump-issues a:before {
  content: "&#xf188;";
}

h1, h2, h3, h4, h5, h6, h7 { font-family: 'Cantarell', sans-serif; font-weight: normal; }
h1.title { font-size: 48px; }
h2.title { font-size: 36px; }
h3.title { font-size: 24px; }
p { max-width: 62em; text-align: justify; }
a img { border: none; }
@media only screen and (max-width: 400px) {
  h1.title { font-size: 36px; }
  h2.title { font-size: 30px; }
  h3.title { font-size: 24px; }
  p { text-align: left; }
}
div.code {
  background-color: #fafaf8;
  background-size: 30px 30px;
  background-image:
  linear-gradient(
    rgba(136, 138, 133, .05), rgba(136, 138, 133, .05) 1px,
    transparent 1px, transparent),
  linear-gradient(90deg,
    rgba(136, 138, 133, .05), rgba(136, 138, 133, .05) 1px,
    transparent 1px, transparent),
  linear-gradient(
    transparent, transparent 15px,
    rgba(136, 138, 133, .1) 15px, rgba(136, 138, 133, .1) 16px,
    transparent 16px, transparent),
  linear-gradient(90deg,
    transparent, transparent 15px,
    rgba(136, 138, 133, .1) 15px, rgba(136, 138, 133, .1) 16px,
    transparent 16px, transparent);
}
span.hi { background: </xsl:text>
<xsl:call-template name="color.blend">
  <xsl:with-param name="bg" select="$color.yellow"/>
  <xsl:with-param name="fg" select="$color.bg.yellow"/>
  <xsl:with-param name="mix" select="0.8"/>
</xsl:call-template><xsl:text>; }
div.bottom {
  background: #2e3436 url(noise.png);
  color: #d3d7cf;
  text-shadow: 1px 1px 0 #1c1f20;
  padding: 0;
}
div.bottom a {
  color: #d3d7cf;
}
div.bottom a:hover {
  color: #eeeeec;
  border-bottom: none;
}
div.bottom > div.contents {
  background: url(duckbg.png) repeat-y;
  background-position: center 6px;
  max-width: 760px;
  margin: 0 auto 0 auto;
  padding: 1px 0 10px 0;
}
div.bottom-badge {
  margin: 1em;
  text-align: center;
  clear: both;
}
div.bottom-badge div.contents {
  display: inline-block;
  max-width: 400px;
  margin-top: 6px;
  padding: 6px;
  border-radius: 4px;
  background-color: rgba(255, 255, 255, 0.4);
  color: #555753;
  text-shadow: none;
  box-shadow: inset 1px 1px 1px #555753;
  -webkit-box-shadow: inset 1px 1px 1px #555753;
}
div.bottom-badge div.contents a {
  color: </xsl:text><xsl:value-of select="$color.link"/><xsl:text>;
  border: none;
}
div.bottom-badge p {
  text-align: center;
}
div.bottom-badge.ui-expander > div.inner > div.title {
  color: #d3d7cf;
  font-weight: normal;
}
div.bottom-badge.ui-expander > div.inner > div.title:hover {
  color: #eeeeec;
}
div.bottom-badge.ui-expander > div.inner > div.title > span.title:before {
  color: inherit;
}
div.pmo-twitter {
  float: right;
  margin: 0 0 0 20px;
  width: 300px;
  padding: 0;
  height: 420px;
}
@media only screen and (max-width: 600px) {
  div.pmo-twitter { display: none; }
}
div.pmo-twitter > a {
  display: none;
}
div.pmo-twitter + p {
  margin: 0;
}

body.pmo-splash p {
  font-size: 18px;
}
body.pmo-splash article > div.region > section > div.inner > div.hgroup {
  border-bottom: none;
  text-align: center;
}
body.pmo-splash section#happy {
  border-top: solid 1px #204a87;
  border-bottom: solid 1px #204a87;
  background-size: 30px 30px;
  background-color: #3465a4;
  background-image:
  linear-gradient(
    rgba(255, 255, 255, .05), rgba(255, 255, 255, .05) 1px,
    transparent 1px, transparent),
  linear-gradient(90deg,
    rgba(255, 255, 255, .05), rgba(255, 255, 255, .05) 1px,
    transparent 1px, transparent),
  linear-gradient(
    transparent, transparent 15px,
    rgba(255, 255, 255, .1) 15px, rgba(255, 255, 255, .1) 16px,
    transparent 16px, transparent),
  linear-gradient(90deg,
    transparent, transparent 15px,
    rgba(255, 255, 255, .1) 15px, rgba(255, 255, 255, .1) 16px,
    transparent 16px, transparent);
  color: white;
  text-shadow: 1px 1px 0 #204a87;
}
body.pmo-splash section#happy > div.inner {
  padding: 20px 0 40px 0;
  background-image: linear-gradient(90deg,
    transparent, rgba(255, 255, 255, 0.1) 30%, rgba(255, 255, 255, 0.1) 70%, transparent);
}
body.pmo-splash section#happy h2 {
  font-family: Bitter;
  font-weight: bold;
  color: white;
}
body.pmo-splash section#happy li {
  margin-left: 1em;
}
body.pmo-splash section#happy a {
  color: #b2d8ff;
  border-bottom: none;
  transition: text-shadow 1s;
}
body.pmo-splash section#happy a:hover {
  text-shadow: 1px 1px 0 #204a87, 0 0 4px #204a87, 0 0 12px white;
}
body.pmo-splash section#specs div.list {
  margin-top: 0;
  margin-bottom: 16px;
}
body.pmo-splash section#specs ul.list {
  display: flex;
  flex-flow: row wrap;
  align-items: stretch;
  justify-content: flex-start;
  margin: 0 -10px;
}
body.pmo-splash section#specs li.list {
  display: block;
  margin: 0 10px 20px 10px;
  padding: 0;
}
body.pmo-splash section#specs li a {
  background: #3465a4 url(noiseblue.png);
  border-radius: 4px;
  display: block;
  width: 276px;
  border: none;
  padding: 4px 12px;
  color: #eeeeec;
  text-shadow: 1px 1px 0 #3465a4;
  font-family: Bitter;
  font-weight: bold;
}
body.pmo-splash section#specs li a:hover {
  color: white;
}
body.pmo-splash section#specs span.em {
  font-style: normal;
  font-family: 'Special Elite';
  font-weight: normal;
  padding-left: 6px;
}
@media only screen and (max-width: 400px) {
  body.pmo-splash section#specs div.list {
    display: block;
    width: 100%;
  }
}

div.mep-info ul, div.mep-info li { list-style-type: none; margin: 0; }
div.mep-info li + li { margin-top: 0.2em; }
span.mep-status {
  font-weight: normal;
  display: inline-block;
  padding: 0 4px 0 4px;
  margin: 0 8px;
  background: </xsl:text><xsl:value-of select="$color.yellow_background"/><xsl:text>;
  border-left: solid 2px </xsl:text><xsl:value-of select="$color.yellow_border"/><xsl:text>;
  color: </xsl:text><xsl:value-of select="$color.fg.gray"/><xsl:text>;
}
span.mep-status-implemented {
  background: </xsl:text><xsl:value-of select="$color.gray_background"/><xsl:text>;
  border-color: </xsl:text><xsl:value-of select="$color.gray_border"/><xsl:text>;
}

td.pmo-mep-history td:first-child { padding-left: 0; }
td.pmo-mep-history div.title {
  font-weight: normal;
  color: </xsl:text><xsl:value-of select="$color.link"/><xsl:text>;
}
body.pmo-source div.header {
  border-top: solid 4px #d3d7cf;
}
div.pmo-source {
  width: 240px;
  float: right;
  margin: 0 0 0 2em;
  padding: 0.5em 6px 0.5em 6px;
  border: solid 1px </xsl:text>
    <xsl:value-of select="$color.yellow_border"/><xsl:text>;
  background-color: </xsl:text>
    <xsl:value-of select="$color.yellow_background"/><xsl:text>;
}
@media only screen and (max-width: 480px) {
  div.pmo-source {
    width: auto;
    float: none;
    margin: 0;
  }
}
</xsl:text>
</xsl:template>

<xsl:template name="html.js.content.custom">
<xsl:text>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-57788613-1', 'auto');
  ga('send', 'pageview');
</xsl:text>
</xsl:template>

<xsl:template mode="mal2html.title.mode" match="mal:title[@style = 'pmo-hidden']"/>

<xsl:template mode="html.class.attr.mode"
              match="mal:list[starts-with(@style, 'pmo-')]">
  <xsl:value-of select="@style"/>
</xsl:template>

<xsl:template mode="html.class.attr.mode"
              match="mal:item[starts-with(@style, 'pmo-')]">
  <xsl:value-of select="@style"/>
</xsl:template>

<xsl:template mode="html.body.attr.mode" match="mal:page">
  <xsl:if test="string(@style) = 'pmo-source'">
    <xsl:attribute name="class">
      <xsl:text>pmo-source</xsl:text>
    </xsl:attribute>
  </xsl:if>
  <xsl:if test="contains(concat(' ', @style, ' '), ' pmo-splash ')">
    <xsl:attribute name="class">
      <xsl:text>pmo-splash</xsl:text>
    </xsl:attribute>
  </xsl:if>
</xsl:template>

<xsl:template name="html.top.custom">
  <xsl:param name="node" select="."/>
  <xsl:variable name="rootlink">
    <xsl:if test="$mal.link.extension != ''">
      <xsl:text>index</xsl:text>
      <xsl:value-of select="$mal.link.extension"/>
    </xsl:if>
  </xsl:variable>
  <div class="top"><div class="contents">
    <a href="{$mal.site.root}{$rootlink}">
      <img class="header-icon" width="80" height="80">
        <xsl:attribute name="src">
          <xsl:value-of select="$mal.site.root"/>
          <xsl:text>mallard-logo-border-80.png</xsl:text>
        </xsl:attribute>
      </img>
    </a>
    <div class="top-mallard"><a href="{$mal.site.root}{$rootlink}">Mallard</a></div>
    <div class="top-tagline"><a href="{$mal.site.root}{$rootlink}">We built the help system.</a></div>
    <div class="editongithub">
      <a>
        <xsl:attribute name="href">
          <xsl:text>https://github.com/projectmallard/projectmallard.org/edit/master</xsl:text>
          <xsl:value-of select="$mal.site.dir"/>
          <xsl:value-of select="$pintail.source.file"/>
        </xsl:attribute>
        <i class="fa fa-github"></i>
        <xsl:text> Edit on GitHub</xsl:text>
      </a>
    </div>
  </div></div>
</xsl:template>

<xsl:template mode="html.header.mode" match="mal:page">
  <xsl:choose>
    <xsl:when test="string(@style) = 'pmo-source'">
      <xsl:for-each select="$mal.cache">
        <xsl:variable name="srclink" select="mal:p[1]/mal:link[1]"/>
        <xsl:variable name="srckey">
          <xsl:call-template name="mal.link.xref.linkid">
            <xsl:with-param name="node" select="$srclink"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="srcnode" select="key('mal.cache.key', $srckey)"/>
        <xsl:call-template name="mal2html.page.linktrails">
          <xsl:with-param name="node" select="$srcnode"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="mal2html.page.linktrails">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template mode="html.footer.mode" match="mal:page"/>

<xsl:template name="html.bottom.custom">
  <div class="bottom"><div class="contents">
  <div class="bottom-badge">
    <xsl:for-each select="/mal:page/mal:info/mal:credit[mal:years]">
      <div>
        <xsl:text>© </xsl:text>
        <xsl:value-of select="mal:years[1]"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="mal:name[1]"/>
      </div>
    </xsl:for-each>
  </div>
  <xsl:variable name="license" select="/mal:page/mal:info/mal:license[1]"/>
  <xsl:if test="$license">
    <div class="bottom-badge ui-expander">
      <div class="yelp-data yelp-data-ui-expander" data-yelp-expanded="false"/>
      <div class="inner">
      <div class="title"><span class="title">
        <xsl:choose>
          <xsl:when test="$license/@href = 'http://creativecommons.org/licenses/by-sa/3.0/us/'">
            <xsl:text>cc-by-sa 3.0 (us)</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>License</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </span></div>
      <div class="region">
        <div class="contents">
          <xsl:apply-templates mode="mal2html.block.mode" select="$license/*"/>
        </div>
      </div>
    </div>
    </div>
  </xsl:if>
  <div class="bottom-badge">
    <div>Powered by </div>
    <a href="http://projectmallard.org">
      <img alt="Mallard" width="80" height="15">
        <xsl:attribute name="src">
          <xsl:value-of select="$mal.site.root"/>
          <xsl:text>mallard-badge.png</xsl:text>
        </xsl:attribute>
      </img>
    </a>
  </div>
  </div></div>
</xsl:template>

<xsl:template mode="mal2html.block.mode"
              match="mal:media[@type='application'][@mime='application/html']">
  <xsl:copy-of select="*"/>
</xsl:template>

<xsl:template mode="mal2html.block.mode" match="mal:note[@style='pmo-source']">
  <div class="pmo-source">
    <xsl:apply-templates mode="mal2html.block.mode" select="mal:title"/>
    <xsl:for-each select="mal:*[not(self::mal:title)
                          and ($mal2html.editor_mode or not(self::mal:comment)
                          or processing-instruction('mal2html.show_comment'))]">
      <xsl:apply-templates mode="mal2html.block.mode" select="."/>
    </xsl:for-each>
  </div>
</xsl:template>

<xsl:template match="/mal:page/mal:links[@type = 'section']">
  <xsl:if test="contains(concat(' ', /mal:page/@style, ' '), ' mep ')">
    <xsl:call-template name="mep.info"/>
  </xsl:if>
  <xsl:call-template name="mal2html.links.section"/>
</xsl:template>

<!--
We're not using normal editor mode badges anywhere on the site anyway, so
this is a convenient override to stick in badges for MEP status. Yelp needs
to grow the ability to provide custom tags/badges on links.
-->
<xsl:template name="mal2html.editor.badge">
  <xsl:param name="target"/>
  <xsl:if test="$target/@style = 'mep'">
    <xsl:variable name="status" select="$target/mal:info/mal:revision[last()]/@status"/>
    <xsl:text> </xsl:text>
    <span class="mep-status mep-status-{$status}">
      <xsl:value-of select="$status"/>
    </span>
  </xsl:if>
</xsl:template>

<xsl:template name="mep.info">
  <xsl:variable name="id" select="/mal:page/@id"/>
  <div class="mep-info">
    <table>
      <tr>
        <th>Authors:</th>
        <td>
          <xsl:for-each select="/mal:page/mal:info/mal:credit[contains(concat(' ', @type, ' '), ' author ')]">
            <xsl:if test="position() != 1">
              <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:value-of select="mal:name"/>
          </xsl:for-each>
        </td>
      </tr>
      <tr>
        <th>Created:</th>
        <td>
          <xsl:for-each select="/mal:page/mal:info/mal:revision[@date]">
            <xsl:sort select="@date"/>
            <xsl:if test="position() = 1">
              <xsl:value-of select="@date"/>
            </xsl:if>
          </xsl:for-each>
        </td>
      </tr>
      <tr>
        <th>Status:</th>
        <td>
          <xsl:for-each select="/mal:page/mal:info/mal:revision[@date]">
            <xsl:sort select="@date"/>
            <xsl:if test="position() = last()">
              <xsl:value-of select="concat(@status, ' (', @date, ')')"/>
            </xsl:if>
          </xsl:for-each>
        </td>
      </tr>
      <xsl:variable name="target">
        <xsl:for-each select="/mal:page/mal:info/mal:revision[@date]">
          <xsl:sort select="@date"/>
          <xsl:if test="position() = last()">
            <xsl:value-of select="@docversion"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:variable>
      <xsl:if test="$target != ''">
        <tr>
          <th>Target:</th>
          <td class="pmo-mep-target">
            <xsl:choose>
              <xsl:when test="$mal.cache/mal:page[@id=concat('/', $target, '/index')]">
                <a>
                  <xsl:attribute name="href">
                    <xsl:call-template name="mal.link.target">
                      <xsl:with-param name="xref" select="concat('/', $target, '/index')"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:attribute name="title">
                    <xsl:call-template name="mal.link.tooltip">
                      <xsl:with-param name="xref" select="concat('/', $target, '/index')"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:value-of select="$target"/>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <span>
                  <xsl:value-of select="$target"/>
                </span>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </xsl:if>
      <xsl:variable name="depends" select="/mal:page/mal:info/mal:link[@type='mep:depends']"/>
      <xsl:if test="$depends">
        <tr>
          <th>Depends:</th>
          <td>
            <ul>
              <xsl:for-each select="$depends">
                <xsl:call-template name="mal2html.links.ul.li">
                  <xsl:with-param name="xref" select="concat('/mep/', @xref)"/>
                  <xsl:with-param name="nodesc" select="true()"/>
                </xsl:call-template>
              </xsl:for-each>
            </ul>
          </td>
        </tr>
      </xsl:if>
      <xsl:variable name="blocks" select="$mal.cache/mal:page/mal:info/mal:link
                                          [@type='mep:depends'][@xref=concat('/mep/', $id)]"/>
      <xsl:if test="$blocks">
        <tr>
          <th>Blocks:</th>
          <td>
            <ul>
              <xsl:for-each select="$blocks">
                <xsl:call-template name="mal2html.links.ul.li">
                  <xsl:with-param name="xref" select="ancestor::mal:page/@id"/>
                  <xsl:with-param name="nodesc" select="true()"/>
                </xsl:call-template>
              </xsl:for-each>
            </ul>
          </td>
        </tr>
      </xsl:if>
      <xsl:variable name="issue" select="/mal:page/mal:info/mal:link[@type='mep:issue'][@href][1]"/>
      <xsl:if test="$issue">
        <tr>
          <th>Issue:</th>
          <td>
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="$issue/@href"/>
              </xsl:attribute>
              <xsl:value-of select="$issue/@href"/>
            </a>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <th>History:</th>
        <td class="pmo-mep-history">
          <div class="table ui-expander">
            <div class="yelp-data yelp-data-ui-expander" data-yelp-expanded="false">
              <div class="yelp-title-collapsed">show history</div>
              <div class="yelp-title-expanded">hide history</div>
            </div>
            <div class="inner">
              <div class="title"><span class="title">history</span></div>
              <div class="region">
                <div class="contents">
                  <table>
                    <xsl:for-each select="/mal:page/mal:info/mal:revision[@date and @status]">
                      <tr>
                        <td>
                          <xsl:value-of select="@date"/>
                        </td>
                        <td>
                          <xsl:value-of select="@docversion"/>
                        </td>
                        <td>
                          <xsl:value-of select="@status"/>
                        </td>
                        <td>
                          <xsl:apply-templates mode="mal2html.inline.mode" select="mal:desc/node()"/>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </td>
      </tr>
    </table>
  </div>
  <xsl:variable name="status">
    <xsl:for-each select="/mal:page/mal:info/mal:revision[@date]">
      <xsl:sort select="@date"/>
      <xsl:if test="position() = last()">
        <xsl:value-of select="@status"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
  <xsl:if test="$status != 'final' and $status != 'rejected' and
                $status != 'replaced' and $status != 'withdrawn'">
    <xsl:for-each select="document('common.xml')/*/mal:note[@xml:id = 'mep-draft']">
      <xsl:apply-templates mode="mal2html.block.mode" select="."/>
    </xsl:for-each>
  </xsl:if>
</xsl:template>

<xsl:template mode="html.content.pre.mode"
              match="mal:section[ancestor::mal:page[contains(concat(' ', @style, ' '), ' mep ')]]">
  <xsl:if test="count(*) = count(mal:title | mal:info)">
    <xsl:for-each select="document('common.xml')/*/mal:note[@xml:id = 'mep-section-stub']">
      <xsl:apply-templates mode="mal2html.block.mode" select="."/>
    </xsl:for-each>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
