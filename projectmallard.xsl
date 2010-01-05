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
                xmlns:mal="http://projectmallard.org/1.0/"
                xmlns="http://www.w3.org/1999/xhtml"
                extension-element-prefixes="exsl"
                version="1.0">

<!-- We shouldn't depend on mal.site.root_noslash; it's not public -->

<xsl:template name="mal2html.css">
  <link rel="stylesheet" type="text/css">
    <xsl:attribute name="href">
      <xsl:value-of select="$mal.site.root_noslash"/>
      <xsl:text>/mallard.css</xsl:text>
    </xsl:attribute>
  </link>
  <link rel="stylesheet" type="text/css">
    <xsl:attribute name="href">
      <xsl:value-of select="$mal.site.root_noslash"/>
      <xsl:text>/projectmallard.css</xsl:text>
    </xsl:attribute>
  </link>
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

<xsl:template name="mal2html.page.headbar">
  <xsl:param name="node" select="."/>
  <div class="headbar">
    <a href="{$mal.site.root_noslash}/index.html">
      <img class="headbar-icon">
        <xsl:attribute name="src">
          <xsl:value-of select="$mal.site.root_noslash"/>
          <xsl:text>/mallard-logo-120.png</xsl:text>
        </xsl:attribute>
      </img>
    </a>
    <div class="headbar-title">Mallard</div>
    <div class="headbar-subtitle">Better Help for Better Software</div>
    <div style="clear:both">
      <xsl:choose>
        <xsl:when test="string($node/@style) = 'pmo-source'">
          <xsl:for-each select="$mal.cache">
            <xsl:variable name="srclink" select="$node/mal:p[1]/mal:link[1]"/>
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
            <xsl:with-param name="node" select="$node"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </div>
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
