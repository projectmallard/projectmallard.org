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

<!--
xsltproc checks.xsl __pintail__/tools/pintail.cache
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                xmlns:mal="http://projectmallard.org/1.0/"
                xmlns:cache="http://projectmallard.org/cache/1.0/"
                xmlns:site="http://projectmallard.org/site/1.0/"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                exclude-result-prefixes="str mal cache xi"
                version="1.0">

<xsl:output method="text"/>

<xsl:param name="prefix" select="''"/>

<xsl:template match="/cache:cache">
  <xsl:for-each select="mal:page">
    <xsl:variable name="cache_node" select="."/>
    <xsl:if test="starts-with(@id, $prefix)">
      <!-- We want the real source pages, not Pintail's staged sources,
           because we want to do pre-XInclude checks. -->
      <xsl:variable name="uri">
        <xsl:value-of select="substring-before(@cache:href, '/__pintail__/stage/')"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="substring-after(@cache:href, '/__pintail__/stage/')"/>
      </xsl:variable>
      <xsl:apply-templates select="document($uri)/mal:page">
        <xsl:with-param name="cache_node" select="$cache_node"/>
      </xsl:apply-templates>
    </xsl:if>
    <!-- Make sure every site:dir has an index.page -->
    <xsl:if test="not(preceding-sibling::mal:page[@site:dir=$cache_node/@site:dir])">
      <xsl:variable name="dirs" select="str:split(@site:dir, '/')"/>
      <xsl:for-each select="$dirs">
        <xsl:variable name="pos" select="position()"/>
        <xsl:variable name="pardir">
          <xsl:text>/</xsl:text>
          <xsl:for-each select="$dirs[position() &lt;= $pos]">
            <xsl:value-of select="."/>
            <xsl:text>/</xsl:text>
          </xsl:for-each>
        </xsl:variable>
        <xsl:if test="not($cache_node/../mal:page[@id=concat($pardir, 'index')])">
          <xsl:value-of select="$pardir"/>
          <xsl:text>&#x000A;Missing index.page&#x000A;&#x000A;</xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template match="/mal:page">
  <xsl:param name="cache_node"/>
  <xsl:variable name="errors">

    <!-- Check for credits -->
    <xsl:if test="not(mal:info/mal:credit)">
      <xsl:text>Missing credits&#x000A;</xsl:text>
    </xsl:if>
    <xsl:if test="not(mal:info/mal:credit[contains(concat(' ', @type, ' '), ' author ')])">
      <xsl:text>Missing author credits&#x000A;</xsl:text>
    </xsl:if>
    <xsl:if test="not(mal:info/mal:credit[contains(concat(' ', @type, ' '), ' copyright ')])">
      <xsl:text>Missing copyright credits&#x000A;</xsl:text>
    </xsl:if>
    <xsl:if test="not(mal:info/mal:credit/mal:years)">
      <xsl:text>Missing copyright years&#x000A;</xsl:text>
    </xsl:if>

    <!-- Check for the license -->
    <xsl:if test="not(mal:info/xi:include[contains(@href, 'cc-by-sa-3-0.xml')])">
      <xsl:text>Missing XInclude for license&#x000A;</xsl:text>
      <xsl:for-each select="mal:info/mal:license/@*">
        <xsl:value-of select="name(.)"/>
        <xsl:text>&#x000A;</xsl:text>
      </xsl:for-each>
      <xsl:text>:</xsl:text>
      <xsl:value-of select="xml:base"/>
      <xsl:text>&#x000A;</xsl:text>
    </xsl:if>

    <xsl:if test="string(@id) != 'index' and
                  string(@style) != 'details' and string(@style) != 'mep' and
                  not(starts-with($cache_node/@id, '/about/'))">

      <!-- Check for common sections -->
      <xsl:variable name="sects" select="mal:section"/>
      <xsl:if test="not($sects[1][@id='notes'][mal:title='Notes'])">
        <xsl:text>Missing Notes section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not($sects[2][@id='examples'][mal:title='Examples'])">
        <xsl:text>Missing Examples section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:variable name="no_comparison" select="processing-instruction('no-comparison')"/>
      <xsl:if test="not($sects[count($sects) - (1 + not($no_comparison))]
                    [@id='processing'][mal:title='Processing Expectations'])">
        <xsl:text>Missing Processing section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not($no_comparison) and
                    not($sects[count($sects)-1][@id='comparison'][mal:title='Comparison to Other Formats'])">
        <xsl:text>Missing Comparison section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not($sects[count($sects)][@id='schema'][mal:title='Schema'])">
        <xsl:text>Missing Schema section&#x000A;</xsl:text>
      </xsl:if>

      <!-- Check for comparisons -->
      <xsl:for-each select="$sects[@id='comparison']">
        <xsl:if test="not(processing-instruction('no-docbook')) and
                      not(.//mal:link[@xref='docbook'][string(.) = 'DocBook'])">
          <xsl:text>Comparison missing DocBook&#x000A;</xsl:text>
        </xsl:if>
        <xsl:if test="not(processing-instruction('no-dita')) and
                      not(.//mal:link[@xref='dita'][string(.) = 'DITA'])">
          <xsl:text>Comparison missing DITA&#x000A;</xsl:text>
        </xsl:if>
      </xsl:for-each>

      <!-- Check for an actual RNG schema -->
      <xsl:for-each select="$sects[@id='schema']">
        <xsl:if test="not(mal:synopsis/mal:code[@mime='application/relax-ng-compact-syntax'])">
          <xsl:text>Schema missing RNG&#x000A;</xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:variable>
  <xsl:if test="$errors != ''">
    <xsl:value-of select="$cache_node/@id"/>
    <xsl:text>&#x000A;</xsl:text>
    <xsl:value-of select="$errors"/>
    <xsl:text>&#x000A;</xsl:text>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
