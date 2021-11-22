<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="bar-width" as="xs:double" select="100"/>
    <xsl:variable name="spacing" as="xs:double" select="$bar-width div 2"/>
    <xsl:variable name="max-width" as="xs:double"
        select="$spacing + ($bar-width + $spacing) * count(//stooge)"/>
    <xsl:variable name="yscale" as="xs:double" select="5"/>
    <xsl:variable name="max-height" as="xs:double" select="100 * $yscale"/>
    <xsl:template match="/">
        <svg height="1000" width="1000">
            <g transform="translate(50, {$max-height + 100})">
                <!-- Axes -->
                <line x1="0" x2="{$max-width}" y1="0" y2="0" stroke="black"/>
                <line x1="0" x2="0" y1="0" y2="-{$max-height}" stroke="black"/>
                <xsl:apply-templates select="//stooge"/>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="stooge">
        <xsl:variable name="x-pos" as="xs:double"
            select="$spacing + (position() - 1) * ($bar-width + $spacing)"/>
        <xsl:variable name="bar-height" as="xs:double" select=". * $yscale"/>
        <xsl:for-each select=".">
            <rect x="{$x-pos}" y="-{$bar-height}" width="{$bar-width}" height="{$bar-height}"/>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
