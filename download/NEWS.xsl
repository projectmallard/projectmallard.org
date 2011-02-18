<?xml version='1.0' encoding='UTF-8'?><!-- -*- indent-tabs-mode: nil -*- -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                xmlns:mal="http://projectmallard.org/1.0/"
                exclude-result-prefixes="mal str"
                version="1.0">

<xsl:output method="text"/>

<xsl:param name="package" select="''"/>
<xsl:param name="version" select="''"/>

<xsl:template match="/">
  <xsl:for-each select="//mal:terms/mal:item[string(mal:title//mal:span[@style='package']) = $package]">
    <xsl:variable name="pversion" select="mal:title//mal:span[@style='version']"/>
    <xsl:variable name="versions" select="str:split($version, '.')"/>
    <xsl:variable name="pversions" select="str:split($pversion, '.')"/>
    <xsl:variable name="yes">
      <xsl:choose>
        <xsl:when test="number($pversions[1]) &lt; number($versions[1])">
          <xsl:text>x</xsl:text>
        </xsl:when>
        <xsl:when test="number($pversions[1]) = number($versions[1])">
          <xsl:choose>
            <xsl:when test="number($pversions[2]) &lt; number($versions[2])">
              <xsl:text>x</xsl:text>
            </xsl:when>
            <xsl:when test="number($pversions[2]) = number($versions[2])">
              <xsl:if test="number($pversions[3]) &lt;= number($versions[3])">
                <xsl:text>x</xsl:text>
              </xsl:if>
            </xsl:when>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="string($yes) != ''">
      <xsl:value-of select="$pversion"/>
      <xsl:text>&#x000A;</xsl:text>
      <xsl:call-template name="repeat">
        <xsl:with-param name="cnt" select="string-length($pversion)"/>
      </xsl:call-template>
      <xsl:text>&#x000A;</xsl:text>
      <xsl:for-each select="mal:list/mal:item">
        <xsl:text>* </xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>&#x000A;</xsl:text>
      </xsl:for-each>
      <xsl:text>&#x000A;</xsl:text>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template name="repeat">
  <xsl:param name="str" select="'='"/>
  <xsl:param name="cnt" select="0"/>
  <xsl:if test="$cnt &gt; 0">
    <xsl:value-of select="$str"/>
    <xsl:call-template name="repeat">
      <xsl:with-param name="str" select="$str"/>
      <xsl:with-param name="cnt" select="$cnt - 1"/>
    </xsl:call-template>
 </xsl:if>
</xsl:template>

</xsl:stylesheet>
