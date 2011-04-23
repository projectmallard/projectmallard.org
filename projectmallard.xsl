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

<xsl:param name="theme.color.yellow_border" select="'#fcaf3e'"/>

<xsl:template name="html.css.custom">
<xsl:text>
body {
  background-color: #ffffff;
  padding: 0 20px 0 20px;
  font-family: sans;
}
p { max-width: 60em; text-align: justify; }
a img { border: none; }
div.example { margin-left: 12px; }

div.header {
  padding: 20px 20px 0 20px;
  max-width: 760px;
  margin: 0 auto;
}
img.header-icon {
  margin-bottom: 20px;
  width: 380px;
  height: 100px;
}
div.linktrail {
  padding-left: 0;
}

div.footer {
  max-width: 800px;
  padding-bottom: 1em;
  margin: 0 auto;
}
div.addthis_right {
  float: right;
  height: 20px;
}
div.addthis_left {
  height: 20px;
}
div.footer-badge {
  margin: 2em 0 0 0;
  text-align: center;
  color: #3f3f3f;
  clear: both;
}
div.footer-badge img {
  vertical-align: middle;
}

div.body {
  border-top: solid 4px </xsl:text>
    <xsl:value-of select="$color.yellow_border"/><xsl:text>;
  -moz-border-radius: 0px;
  -webkit-border-radius: 0px;
  margin: 0 auto;
  padding: 1em 19px 1em 19px;
  max-width: 760px;
}
body.pmo-source div.body {
  border-top: solid 4px #d3d7cf;
}
body.pmo-source div.header {
  border-bottom: solid 1px #d3d7cf;
}

div.header {
  color: #3465a4;
  border-bottom: solid 1px </xsl:text>
    <xsl:value-of select="$color.yellow_border"/><xsl:text>;
}
h1, h2, h3, h4, h5, h6, h8 { color: #3465a4; }

.threecolumns h2 { font-size: 1em; }
.threecolumns li { margin-left: 1.44em; }
.threecolumnsone {
  padding: 0;
  vertical-align: top;
  width: 240px;
  border-right: solid 20px #ffffff;
}
.threecolumnstwo {
  padding: 0;
  vertical-align: top;
  width: 240px;
  border-right: solid 20px #ffffff;
}
.threecolumnsthree {
  padding: 0;
  vertical-align: top;
  width: 240px;
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

<xsl:template match="mal:page[@style='3column']/mal:section">
  <xsl:param name="bypass" select="false()"/>
  <xsl:choose>
    <xsl:when test="not(preceding-sibling::mal:section)">
      <table class="threecolumns">
        <tr>
          <td class="threecolumnsone">
            <xsl:apply-imports/>
          </td>
          <td class="threecolumnstwo">
            <xsl:apply-templates select="following-sibling::mal:section[1]">
              <xsl:with-param name="bypass" select="true()"/>
            </xsl:apply-templates>
          </td>
          <td class="threecolumnsthree">
            <xsl:apply-templates select="following-sibling::mal:section[2]">
              <xsl:with-param name="bypass" select="true()"/>
            </xsl:apply-templates>
          </td>
        </tr>
      </table>
    </xsl:when>
    <xsl:when test="$bypass">
      <xsl:apply-imports/>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template name="html.head.custom">
  <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=shaunm"/>
  <script type="text/javascript">
<xsl:text>
var addthis_config = {
  data_track_clickback: true,
  ui_508_compliant: true
}
var addthis_share = {
  description: "</xsl:text>
<xsl:for-each select="str:split(normalize-space(/mal:page/mal:info/mal:desc), '&quot;')">
  <xsl:if test="position() != 1">
    <xsl:text>\"</xsl:text>
  </xsl:if>
  <xsl:value-of select="."/>
</xsl:for-each><xsl:text>"
}
</xsl:text>
  </script>
</xsl:template>

<xsl:template mode="html.body.attr.mode" match="mal:page">
  <xsl:if test="string(@style) = 'pmo-source'">
    <xsl:attribute name="class">
      <xsl:text>pmo-source</xsl:text>
    </xsl:attribute>
  </xsl:if>
</xsl:template>

<xsl:template mode="html.header.mode" match="mal:page">
  <a href="{$mal.site.root_noslash}/index.html">
    <img class="header-icon">
      <xsl:attribute name="src">
        <xsl:value-of select="$mal.site.root_noslash"/>
        <xsl:text>/mallard-header.png</xsl:text>
      </xsl:attribute>
    </img>
  </a>
  <div style="clear:both">
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
  </div>
</xsl:template>

<xsl:template mode="html.footer.mode" match="mal:page">
  <div class="addthis_toolbox addthis_default_style addthis_right">
    <a class="addthis_button_delicious"></a>
    <a class="addthis_button_digg"></a>
    <a class="addthis_button_identica"></a>
    <a class="addthis_button_reddit"></a>
    <a class="addthis_button_stumbleupon"></a>
    <a class="addthis_button_more"></a>
  </div>
  <div class="addthis_toolbox addthis_default_style addthis_left">
    <a class="addthis_button_w3validator"></a>
  </div>
  <div class="footer-badge">
    <div>Powered by</div>
    <a href="{$mal.site.root_noslash}/index.html">
      <img alt="Mallard" width="80" height="15">
        <xsl:attribute name="src">
          <xsl:value-of select="$mal.site.root_noslash"/>
          <xsl:text>/mallard-badge.png</xsl:text>
        </xsl:attribute>
      </img>
    </a>
  </div>
</xsl:template>

<xsl:template mode="mal2html.block.mode" match="mal:note[@style='pmo-source']">
  <div class="pmo-source">
    <xsl:apply-templates mode="mal2html.block.mode" select="mal:title"/>
    <xsl:for-each select="mal:*[not(self::mal:title)
                          and ($mal2html.editor_mode or not(self::mal:comment)
                          or processing-instruction('mal2html.show_comment'))]">
      <xsl:apply-templates mode="mal2html.block.mode" select=".">
        <xsl:with-param name="first_child" select="position() = 1"/>
      </xsl:apply-templates>
    </xsl:for-each>
  </div>
</xsl:template>

</xsl:stylesheet>
