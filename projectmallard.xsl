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

<xsl:param name="mal.link.extension" select="''"/>

<xsl:param name="theme.icons.size.note" select="24"/>

<xsl:param name="color.yellow_border" select="'#fcaf3e'"/>
<xsl:param name="color.text_light" select="'#555753'"/>
<xsl:param name="color.blue_border" select="'#3465a4'"/>

<xsl:template name="html.head.custom">
  <link href="http://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet" type="text/css"/>
  <link href="http://fonts.googleapis.com/css?family=Bitter:400,700" rel="stylesheet" type="text/css"/>
  <link href="http://fonts.googleapis.com/css?family=Special+Elite" rel="stylesheet" type="text/css"/>
</xsl:template>

<xsl:template name="html.css.custom">
<xsl:text>
body {
  font-family: 'Lato', sans;
  font-size: 14px;
}
div.top {
  width: 100%;
  margin: 0;
  padding-top: 20px;
  background: #2e3436 url(noise.png);
  color: #eeeeec;
}
div.top > div.content {
  max-width: 800px;
  margin: 0 auto 0 auto;
  padding: 0 0 10px 0;
  border-bottom: solid 6px #fcaf3e;
}
div.top img {
  float: left;
  margin: 4px 10px 0 0;
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
@media only screen and (max-width: 400px) {
  div.top-mallard, div.top-tagline {
    margin-left: 6px;
  }
}
@media only screen and (max-width: 500px) {
  div.top img {
    display: none;
  }
}      
div.page {
  background-color: #ffffff;
  border: none;
  margin: 0;
  width: 100%;
  max-width: 100%;
}
div.header {
  margin: 0 auto 0 auto;
  max-width: 800px;
}
div.trails {
  color: #3465a4;
  padding: 0.5em 22px 0.5em 22px;
  background-color: #eeeeec;
  font-family: Bitter;
}
@media only screen and (max-width: 400px) {
  div.trails {
    padding: 0.5em 6px 0.5em 6px;
  }
}
div.body {
  max-width: 760px;
  margin: 0 auto 0 auto;
  padding-top: 20px;
  padding-bottom: 40px;
}
div.body > div.hgroup {
  margin-top: 0;
}
h1, h2, h3, h4, h5, h6, h7 { font-family: Bitter; }
h1.title { font-size: 3em; }
h2.title { font-size: 1.73em; }
p { max-width: 62em; text-align: justify; }
a img { border: none; }
@media only screen and (max-width: 400px) {
  h1.title { font-size: 2em; }
  h2.title { font-size: 1.44em; }
  p { text-align: left; }
}

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
div.bottom div.content {
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
div.bottom-badge div { margin: 0; }
div.bottom-badge p {
  text-align: center;
}
div.bottom-badge div.hgroup {
  color: #d3d7cf;
  cursor: pointer;
}
div.bottom-badge div.contents {
  display: inline-block;
  max-width: 400px;
  margin-top: 6px;
  padding: 6px;
  border-radius: 4px;
  background-color: #babdb6;
  background-color: rgba(255, 255, 255, 0.3);
  color: #555753;
  text-shadow: none;
  box-shadow: inset 1px 1px 1px #555753;
  -webkit-box-shadow: inset 1px 1px 1px #555753;
}
div.bottom-badge div.contents p {
  line-height: 1.2em;
}
div.bottom-badge div.contents a {
  color: </xsl:text><xsl:value-of select="$color.link"/><xsl:text>;
  border: none;
}

div.pmo-what, div.pmo-why {
  display: inline-block;
  margin-top: 0;
  padding: 0;
  vertical-align: top;
  width: 366px;
}
div.pmo-what {
  margin-right: 20px;
  margin-bottom: 20px;
}
div.pmo-specs div.list {
  margin-top: 0;
  margin-bottom: 16px;
}
div.pmo-specs li.list {
  display: inline-block;
  background: #3465a4 url(noiseblue.png);
  border-radius: 4px;
  margin: 0 10px 10px 0;
  padding: 0;
}
div.pmo-specs li a {
  background: url(duckbg.png) repeat-y;
  display: block;
  width: 216px;
  border: none;
  padding: 4px 12px;
  color: #eeeeec;
  text-shadow: 1px 1px 0 #3465a4;
  font-family: Bitter;
  font-weight: bold;
}
div.pmo-specs li a:hover {
  color: white;
}
div.pmo-specs span.em {
  font-style: normal;
  font-family: 'Special Elite';
  font-weight: normal;
  padding-left: 6px;
}


div.pmo-what > div.inner > div.hgroup,
div.pmo-why > div.inner > div.hgroup {
  border-bottom: none;
}
div.pmo-index h2 { font-size: 18px; font-weight: bold; }
div.pmo-index p { text-align: left; }
div.pmo-index li { margin-left: 1.44em; }
div.pmo-index div.title { margin-top: 0; font-size: 14px; }

td.pmo-mep-history td:first-child { padding-left: 0; }
td.pmo-mep-history div.title {
  font-weight: normal;
  color: </xsl:text><xsl:value-of select="$color.link"/><xsl:text>;
}

@media only screen and (max-width: 400px) {
  div.pmo-index {
    margin: 0 0 20px 0;
    width: 100%;
    border: none;
    box-shadow: none;
    -moz-box-shadow: none;
  }
  .pmo-index > div.region {
    margin-left: 0;
    margin-right: 0;
  }
  div.pmo-index > div.inner > div.hgroup {
    padding: 0;
    border-bottom: none;
  }
  div.pmo-index > div.inner > div.region {
    padding: 0;
  }
  div.pmo-specs div.list {
    display: block;
    width: 100%;
  }
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

<xsl:template mode="html.class.attr.mode" match="mal:section">
  <xsl:if test="@style='pmo-what' or @style ='pmo-why' or @style='pmo-specs'">
    <xsl:text>pmo-index </xsl:text>
    <xsl:value-of select="@style"/>
  </xsl:if>
</xsl:template>

<xsl:template mode="html.body.attr.mode" match="mal:page">
  <xsl:if test="string(@style) = 'pmo-source'">
    <xsl:attribute name="class">
      <xsl:text>pmo-source</xsl:text>
    </xsl:attribute>
  </xsl:if>
</xsl:template>

<xsl:template name="html.top.custom">
  <xsl:variable name="rootlink">
    <xsl:if test="$mal.link.extension != ''">
      <xsl:text>index</xsl:text>
      <xsl:value-of select="$mal.link.extension"/>
    </xsl:if>
  </xsl:variable>
  <div class="top"><div class="content">
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
  <div class="bottom"><div class="content">
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
      <div class="hgroup">
        <xsl:choose>
          <xsl:when test="$license/@href = 'http://creativecommons.org/licenses/by-sa/3.0/us/'">
            <xsl:text>cc-by-sa 3.0 (us)</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>License</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </div>
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
  <div class="bottom-badge">
    <xsl:text>Hosted by </xsl:text>
    <a href="http://syllogist.net/">Syllogist</a>
  </div>
  </div></div>
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

<xsl:template name="mep.info">
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
    <div class="note"><div class="inner"><div class="region"><div class="contents">
      <p>This proposal is still under consideration. Revisions may
      still be made based on your input. Discuss this proposal on
      <a href="{$mal.site.root}about/contact{$mal.link.extension}">mallard-list</a>.</p>
    </div></div></div></div>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
