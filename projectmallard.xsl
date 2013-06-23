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

<!-- We shouldn't depend on mal.site.root_noslash; it's not public -->

<xsl:param name="theme.icons.size.note" select="24"/>

<xsl:param name="color.yellow_border" select="'#fcaf3e'"/>
<xsl:param name="color.text_light" select="'#555753'"/>
<xsl:param name="color.blue_border" select="'#3465a4'"/>

<xsl:template name="html.css.custom">
<xsl:text>
body {
  font-family: sans;
  background: #888a85 url(duckbg.png) repeat-y;
  background-position: center 0;
}
div.top {
  width: 100%;
  margin: 0;
  padding-top: 20px;
  background-color: #ffffff;
  font-family: 'Lato';
  font-weight: bold;
}
div.top > div.content {
  height: 120px;
  max-width: 800px;
  margin: 0 auto 0 auto;
  background: url(swoop.png) no-repeat;
  background-position: 40px 0;
}
div.top-mallard {
  margin: 0 0 0 20px;
  font-size: 76px;
}
div.top-tagline {
  margin: -10px 0 0 20px;
  font-size: 19px;
}
div.top-mallard a {
  text-decoration: none;
  border: none;
  color: #555753;
}
div.top-tagline a {
  text-decoration: none;
  border: none;
  color: #888a85;
}
div.top img {
  float: right;
  margin: 20px 20px 0 20px;
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
  border-top: solid 6px </xsl:text>
    <xsl:value-of select="$color.yellow_border"/><xsl:text>;
  margin: 0 auto 0 auto;
  max-width: 800px;
}
div.trails {
  color: #3465a4;
  padding: 0.5em 22px 0.5em 22px;
  background-color: #eeeeec;
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
h1.title { font-family: 'Lato'; font-size: 3em; }
h2.title { font-size: 1.73em; }
p { max-width: 62em; text-align: justify; }
a img { border: none; }
@media only screen and (max-width: 400px) {
  h1.title { font-size: 2em; }
  h2.title { font-size: 1.44em; }
  p { text-align: left; }
}

div.bottom {
  color: #d3d7cf;
  text-shadow: 1px 1px 0 </xsl:text><xsl:value-of select="$color.text_light"/><xsl:text>;
}
div.bottom a {
  color: #d3d7cf;
}
div.bottom a:hover {
  color: #eeeeec;
  border-bottom: none;
}
div.bottom div.content {
  max-width: 760px;
  margin: 0 auto 0 auto;
  padding: 0 0 10px 0;
}
div.bottom-badge {
  margin: 1em;
  text-align: center;
  clear: both;
}
div.bottom-badge div { margin: 0; }

.threecolumns h2 {
  font-family: 'Lato';
  font-size: 18px;
}
.threecolumns div.title {
  margin-top: 2em;
  font-family: 'Lato';
  font-size: 14px;
}
.threecolumns li { margin-left: 1.44em; }
.threecolumnsone {
  display: inline-block;
  margin: 0 20px 20px 0;
  padding: 0;
  vertical-align: top;
  width: 238px;
}
.threecolumnstwo {
  display: inline-block;
  margin: 0 20px 20px 0;
  padding: 0;
  vertical-align: top;
  width: 238px;
}
.threecolumnsthree {
  display: inline-block;
  margin: 0 0 20px 0;
  padding: 0;
  vertical-align: top;
  width: 236px;
}
@media only screen and (max-width: 400px) {
  .threecolumnsone, .threecolumnstwo, .threecolumnsthree {
    margin-right: 0;
    width: 100%;
  }
  .threecolumnsone > div.hgroup > *,
  .threecolumnstwo > div.hgroup > *,
  .threecolumnsthree > div.hgroup > * {
    margin-left: 6px;
    margin-right: 6px;
  }
  .threecolumnsone > div.region,
  .threecolumnstwo > div.region,
  .threecolumnsthree > div.region {
    margin-left: 6px;
    margin-right: 6px;
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

<xsl:template mode="mal2html.title.mode" match="mal:page[@style='3column']/mal:title"/>

<xsl:template match="mal:page[@style='3column']/mal:section">
  <xsl:param name="bypass" select="false()"/>
  <xsl:choose>
    <xsl:when test="not(preceding-sibling::mal:section)">
      <div class="threecolumns">
        <div class="threecolumnsone">
          <xsl:apply-imports/>
        </div>
        <div class="threecolumnstwo">
          <xsl:apply-templates select="following-sibling::mal:section[1]">
            <xsl:with-param name="bypass" select="true()"/>
          </xsl:apply-templates>
        </div>
        <div class="threecolumnsthree">
          <xsl:apply-templates select="following-sibling::mal:section[2]">
            <xsl:with-param name="bypass" select="true()"/>
          </xsl:apply-templates>
        </div>
      </div>
    </xsl:when>
    <xsl:when test="$bypass">
      <xsl:apply-imports/>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template name="html.head.custom">
  <link href='http://fonts.googleapis.com/css?family=Lato:900' rel='stylesheet' type='text/css'/>
</xsl:template>

<xsl:template mode="html.body.attr.mode" match="mal:page">
  <xsl:if test="string(@style) = 'pmo-source'">
    <xsl:attribute name="class">
      <xsl:text>pmo-source</xsl:text>
    </xsl:attribute>
  </xsl:if>
</xsl:template>

<xsl:template name="html.top.custom">
  <div class="top"><div class="content">
    <a href="{$mal.site.root_noslash}/index.html">
      <img class="header-icon" width="80" height="80">
        <xsl:attribute name="src">
          <xsl:value-of select="$mal.site.root_noslash"/>
          <xsl:text>/mallard-logo-80.png</xsl:text>
        </xsl:attribute>
      </img>
    </a>
    <div class="top-mallard"><a href="{$mal.site.root_noslash}/index.html">Mallard</a></div>
    <div class="top-tagline"><a href="{$mal.site.root_noslash}/index.html">Better Help for Better Software</a></div>
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
  <div class="bottom-badge">
    <div>Powered by </div>
    <a href="http://projectmallard.org">
      <img alt="Mallard" width="80" height="15">
        <xsl:attribute name="src">
          <xsl:value-of select="$mal.site.root_noslash"/>
          <xsl:text>/mallard-badge.png</xsl:text>
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

</xsl:stylesheet>
