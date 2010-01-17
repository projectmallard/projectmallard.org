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
                xmlns:mal="http://projectmallard.org/1.0/"
                xmlns:site="http://projectmallard.org/site/1.0/"
                xmlns:cache="http://projectmallard.org/cache/1.0/"
                xmlns:str="http://exslt.org/strings"
                xmlns="http://projectmallard.org/1.0/"
                exclude-result-prefixes="mal cache site str"
                version="1.0">

<xsl:template match="/cache:cache">
  <page id="META">
    <info>
    </info>
    <title>Mallard 1.0 META</title>
    <p>This page lists various information about the Mallard 1.0 DRAFT specification.
    This information is extracted automatically as part of the build process.</p>
    <section id="status-1-0">
      <title>1.0 Status and Reviews</title>
      <table frame="top bottom" rules="rows">
        <thead><tr>
          <td><p>Page</p></td>
          <td><p>Status</p></td>
          <td><p>Reviews</p></td>
        </tr></thead>
        <tbody>
        <xsl:for-each select="mal:page[@site:dir = '/1.0/']">
          <xsl:sort select="@id"/>
          <xsl:variable name="page" select="document(@cache:href)/mal:page"/>
          <tr>
            <td><p>
              <link xref="{$page/@id}"><xsl:value-of select="$page/@id"/></link>
            </p></td>
            <td><p>
              <xsl:variable name="rev" select="$page/mal:info/mal:revision[@docversion = '1.0']"/>
              <xsl:choose>
                <xsl:when test="$rev">
                  <xsl:value-of select="$rev/@status"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>none</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </p></td>
            <td><p></p></td>
          </tr>
        </xsl:for-each>
        </tbody>
      </table>
    </section>
    <section id="sections">
      <title>Common Sections</title>
      <table frame="top bottom" rules="rows" shade="cols">
        <thead><tr>
          <td><p>Page</p></td>
          <td><p>Notes</p></td>
          <td><p>Examples</p></td>
          <td><p>Processing</p></td>
          <td><p>Comparison</p></td>
          <td><p>Schema</p></td>
        </tr></thead>
        <tbody>
        <xsl:for-each select="mal:page[@site:dir = '/1.0/']">
          <xsl:sort select="@id"/>
          <xsl:variable name="page" select="document(@cache:href)/mal:page"/>
          <xsl:variable name="sects" select="count($page/mal:section)"/>
          <xsl:variable name="error">
            <xsl:choose>
              <xsl:when test="not($page/mal:section[1]/@id = 'notes')">
                <xsl:text>n</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>y</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
              <xsl:when test="not($page/mal:section[2]/@id = 'examples')">
                <xsl:text>n</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>y</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
              <xsl:when test="$page/mal:section[$sects]/@id = 'schema'">
                <xsl:choose>
                  <xsl:when test="$page/mal:section[$sects - 1]/@id = 'comparison'">
                    <xsl:choose>
                      <xsl:when test="$page/mal:section[$sects - 2]/@id = 'processing'">
                        <xsl:text>yy</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>ny</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="$page/mal:section[$sects - 1]/@id = 'processing'">
                        <xsl:text>yn</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>nn</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text>y</xsl:text>
              </xsl:when>
              <xsl:when test="$page/mal:section[$sects]/@id = 'comparison'">
                <xsl:choose>
                  <xsl:when test="$page/mal:section[$sects - 1]/@id = 'processing'">
                    <xsl:text>yyn</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>nyn</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="$page/mal:section[$sects]/@id = 'processing'">
                <xsl:text>ynn</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>nnn</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:if test="not($error = 'yyyyy')">
            <tr>
              <td><p>
                <link xref="{$page/@id}"><xsl:value-of select="$page/@id"/></link>
              </p></td>
              <xsl:for-each select="str:split('1 2 3 4 5')">
                <td><p>
                  <xsl:if test="substring($error, number(.), 1) != 'y'">
                    <xsl:text> ✘</xsl:text>
                  </xsl:if>
                </p></td>
              </xsl:for-each>
            </tr>
          </xsl:if>
        </xsl:for-each>
        </tbody>
      </table>
    </section>
  </page>
</xsl:template>

</xsl:stylesheet>
