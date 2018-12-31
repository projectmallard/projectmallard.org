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
  <xsl:variable name="style" select="concat(' ', @style, ' ')"/>
  <xsl:variable name="isspec" select="contains($style, ' spec ') or
                                      contains($style, ' spec-details ') or
                                      contains($style, ' spec-guide ')"/>
  <xsl:variable name="errors">

    <!-- Check for page style -->
    <xsl:if test="not($isspec or
                      contains($style, ' mep ') or
                      contains($style, ' tutorial ') or
                      contains($style, ' pmo-about ') or
                      contains($style, ' pmo-guide ') or
                      contains($style, ' pmo-source ') or
                      contains($style, ' pmo-splash ')
                      )">
      <xsl:text>Bad style attribute&#x000A;</xsl:text>
    </xsl:if>

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

    <!-- Check for desc elements on non-index pages -->
    <xsl:if test="string(@id) != 'index' and not(mal:info/mal:desc)">
      <xsl:text>Missing desc element&#x000A;</xsl:text>
    </xsl:if>

    <!-- Check for revision elements -->
    <xsl:if test="$isspec">
      <xsl:if test="not(mal:info/mal:revision[@date][@docversion][@status])">
        <xsl:text>Missing revision element&#x000A;</xsl:text>
      </xsl:if>
    </xsl:if>

    <!-- Checks only for spec pages -->
    <xsl:if test="contains($style, ' spec ')">

      <!-- Check for common sections -->
      <!--
          Notes
          Examples
          **
          Processing Expectations | Specification
          Feature Token ?
          Comparison to Other Formats ? spec-no-comparison
          Schema ? spec-no-schema
      -->
      <xsl:variable name="sects" select="mal:section"/>
      <xsl:if test="not($sects[1][@id='notes'][mal:title='Notes'])">
        <xsl:text>Missing Notes section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not($sects[2][@id='examples'][mal:title='Examples'])">
        <xsl:text>Missing Examples section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:variable name="no_comparison" select="contains($style, ' spec-no-comparison ')"/>
      <xsl:variable name="no_schema" select="contains($style, ' spec-no-schema ')"/>
      <xsl:variable name="token" select="$sects[count($sects) - (not($no_comparison) + not($no_schema))]
                                         [@id='token'][mal:title='Feature Token']"/>
      <xsl:if test="not($sects[count($sects) - (not($no_comparison) + not($no_schema) + count($token))]
                              [@id='processing'][mal:title='Processing Expectations']
                        or
                        $sects[count($sects) - (not($no_comparison) + not($no_schema) + count($token))]
                              [@id='spec'][mal:title='Specification']
                       )">
        <xsl:text>Missing Processing or Specification section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not($no_comparison) and
                    not($sects[count($sects)-1][@id='comparison'][mal:title='Comparison to Other Formats'])">
        <xsl:text>Missing Comparison section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not($no_schema) and
                    not($sects[count($sects)][@id='schema'][mal:title='Schema'])">
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

    <!-- Check for MEP structure -->
    <xsl:if test="contains($style, ' mep ')">
      <!-- Check for common sections -->
      <!--
          Background
          Proposal
          Addendums ?
          Examples
          Accessibility ?
          Internationalization ?
          Alternatives ?
          Compatibility and Fallback
          Comparison to Other Formats
      -->
      <xsl:variable name="sects" select="mal:section"/>
      <xsl:if test="not(mal:p[1][@style='lead'])">
        <xsl:text>Missing lead paragraph&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not($sects[1][@id='background'][mal:title='Background'])">
        <xsl:text>Missing Background section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not($sects[2][@id='proposal'][mal:title='Proposal'])">
        <xsl:text>Missing Proposal section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="$sects[3][@id='addendums']">
        <xsl:if test="not($sects[3][mal:title='Addendums'])">
          <xsl:text>Missing Addendums section&#x000A;</xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:variable name="posex" select="3 + count($sects[3][@id='addendums'])"/>
      <xsl:if test="not($sects[$posex][@id='examples'][mal:title='Examples'])">
        <xsl:text>Missing Examples section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:variable name="posac" select="$posex + 1"/>
      <xsl:if test="$sects[$posac][@id='a11y']">
        <xsl:if test="not($sects[$posac][mal:title='Accessibility'])">
          <xsl:text>Missing Accessibility section&#x000A;</xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:variable name="posin" select="$posac + count($sects[$posac][@id='a11y'])"/>
      <xsl:if test="$sects[$posin][@id='i18n']">
        <xsl:if test="not($sects[$posin][mal:title='Internationalization'])">
          <xsl:text>Missing Internationalization section&#x000A;</xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:variable name="posalt" select="$posin + count($sects[$posin][@id='i18n'])"/>
      <xsl:if test="$sects[$posalt][@id='alternatives']">
        <xsl:if test="not($sects[$posalt][mal:title='Alternatives'])">
          <xsl:text>Missing Alternatives section&#x000A;</xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:variable name="poscom" select="$posalt + count($sects[$posalt][@id='alternatives'])"/>
      <xsl:if test="not($sects[$poscom][@id='compatibility'][mal:title='Compatibility and Fallback'])">
        <xsl:text>Missing Compatibility and Fallback section&#x000A;</xsl:text>
      </xsl:if>
      <xsl:variable name="poscmp" select="$poscom + 1"/>
      <xsl:if test="not($sects[$poscmp][@id='comparison'][mal:title='Comparison to Other Formats'])">
        <xsl:text>Missing Comparison section&#x000A;</xsl:text>
      </xsl:if>

      <!-- MEP titles -->
      <xsl:if test="not(mal:info/mal:title[@type='text'])">
        <xsl:text>Missing text title&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not(mal:info/mal:title[@type='link'])">
        <xsl:text>Missing link title&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="not(mal:subtitle)">
        <xsl:text>Missing subtitle&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="string(mal:info/mal:title[@type='text']) != string(mal:subtitle)">
        <xsl:text>Mismatched text title and subtitle&#x000A;</xsl:text>
      </xsl:if>
      <xsl:if test="concat(mal:title, ': ', mal:subtitle) !=
                    string(mal:info/mal:title[@type='link'])">
        <xsl:text>Mismatched link title and title/subtitle&#x000A;</xsl:text>
      </xsl:if>

      <!-- MEP status checks -->
      <xsl:variable name="status">
        <xsl:for-each select="mal:info/mal:revision">
          <xsl:sort select="@date"/>
          <xsl:if test="position() = last()">
            <xsl:value-of select="@status"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:variable>
      <xsl:if test="not(contains(
                    ' incomplete proposed revised implemented final rejected replaced withdrawn ',
                    concat(' ', $status, ' ') ))">
        <xsl:text>Unknown MEP status </xsl:text>
        <xsl:value-of select="$status"/>
        <xsl:text>&#x000A;</xsl:text>
      </xsl:if>
      <xsl:variable name="docversion">
        <xsl:for-each select="mal:info/mal:revision">
          <xsl:sort select="@date"/>
          <xsl:if test="position() = last()">
            <xsl:value-of select="@docversion"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:variable>
      <xsl:if test="$docversion != mal:info/mal:link[@type='guide' and @xref='index']/@group">
        <xsl:text>Mismatched docversion and link group&#x000A;</xsl:text>
      </xsl:if>

      <!-- MEP links -->
      <xsl:if test="not(mal:info/mal:link[@type='mep:issue'][starts-with(@href, 'https://github.com/projectmallard/projectmallard.org/issues/')])">
        <xsl:text>Missing GitHub issue link&#x000A;</xsl:text>
      </xsl:if>

    </xsl:if>

    <xsl:apply-templates mode="block.checks" select="*"/>
  </xsl:variable>
  <xsl:if test="$errors != ''">
    <xsl:value-of select="$cache_node/@id"/>
    <xsl:text>&#x000A;</xsl:text>
    <xsl:value-of select="$errors"/>
    <xsl:text>&#x000A;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template mode="block.checks" match="mal:p | mal:screen | mal:title |
                                         mal:subtitle | mal:desc | mal:cite | mal:name"/>
<xsl:template mode="block.checks" match="*">
  <xsl:apply-templates mode="block.checks" select="*"/>
</xsl:template>
<xsl:template mode="block.checks" match="mal:tree//mal:item">
  <xsl:apply-templates mode="block.checks" select="mal:item"/>
</xsl:template>
<xsl:template mode="block.checks" match="mal:code">
  <xsl:choose>
    <xsl:when test="not(@mime)">
      <xsl:if test="not(contains(concat(' ', @style, ' '), ' no-mime '))">
        <xsl:text>Missing mime attribute on code&#x000A;</xsl:text>
      </xsl:if>
    </xsl:when>
    <xsl:when test="@mime = 'application/xml'"/>
    <xsl:when test="@mime = 'application/relax-ng-compact-syntax'"/>
    <xsl:when test="@mime = 'text/x-c++src'"/>
    <xsl:when test="@mime = 'text/x-ducktype'"/>
    <xsl:otherwise>
      <xsl:text>Incorrect mime attribute: </xsl:text>
      <xsl:value-of select="@mime"/>
      <xsl:text>&#x000A;</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
