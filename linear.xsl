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
                xmlns:set="http://exslt.org/sets"
                xmlns:mal="http://projectmallard.org/1.0/"
                xmlns:cache="http://projectmallard.org/cache/1.0/"
                version="1.0">

<xsl:import href="/usr/share/yelp-xsl/xslt/mallard/common/mal-link.xsl"/>
<xsl:import href="/usr/share/yelp-xsl/xslt/mallard/common/mal-sort.xsl"/>

<xsl:param name="mal.cache" select="/cache:cache"/>

<xsl:output method="text"/>

<!--
<xsl:key name="links.key" match="mal:link" use="@xref"/>

<xsl:template match="/cache:cache">
  <xsl:variable name="links">
    <xsl:call-template name="linear">
      <xsl:with-param name="node" select="key('mal.cache.key', $root)"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:for-each select="exsl:node-set($links)/mal:link">
    <xsl:if test="set:has-same-node(key('links.key', @xref)[1], .)">
      <xsl:value-of select="concat(@xref, '&#x000A;')"/>
    </xsl:if>
  </xsl:for-each>
</xsl:template>
-->

<xsl:template match="/cache:cache">
  <xsl:variable name="links">
    <xsl:call-template name="mal.sort.tsort"/>
  </xsl:variable>
  <xsl:for-each select="exsl:node-set($links)/mal:link">
    <xsl:value-of select="concat(@xref, '&#x000A;')"/>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
