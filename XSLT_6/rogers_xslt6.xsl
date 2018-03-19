<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Immigration Debate</title>
                <link rel="stylesheet" type="text/css" href="rogers_xslt_6.css"/>
            </head>
            <body>
                <h1>Debate</h1>
                <img id="eagle" src="eagle.jpg" alt="America"/>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="loc | date">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="participants">
        <div class="participants">
            <h3>
                <xsl:apply-templates select="candidate"/>
            </h3>
        </div>
    </xsl:template>
    <xsl:template match="candidate">
        <xsl:value-of select="replace(., ';( and)?', '')"/>
        <xsl:if test="following-sibling::candidate">
            <br/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="speech">
        <xsl:variable as="xs:integer" name="count"
            select="count(preceding::speech[@speaker eq current()/@speaker])"/>

        <xsl:choose>
            <xsl:when test="following::speech[@speaker eq current()/@speaker]">  
                <p id="{concat(@speaker, $count)}" class="{lower-case(@speaker)}">
                    <a href="{concat('#', @speaker, $count + 1)}">
                        <strong>
                            <xsl:apply-templates select="@speaker"/>
                            <xsl:text>:</xsl:text>
                        </strong>
                    </a>
                    <xsl:apply-templates/>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <p class="{lower-case(@speaker)}" id="{concat(@speaker, $count)}" class="{lower-case(@speaker)}>
                    <strong>
                        <xsl:apply-templates select="@speaker"/>
                        <xsl:text>:</xsl:text>
                    </strong>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="immigration">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    <xsl:template match="keyword">
        <span class="keyword">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
