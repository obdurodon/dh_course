<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="bar-width" as="xs:integer" select="75"/>
    <xsl:variable name="bar-interval" as="xs:integer" select="25"/>
    <xsl:variable name="xlength" as="xs:integer" select="count(//stooge)*($bar-interval+$bar-width)"/>
    <xsl:variable name="yscale" as="xs:integer" select="3"/>
    <xsl:template match="/">
        <svg>
            <g transform="translate(80,400)">
                <line x1="0" y1="0" x2="{$xlength}" y2="0" stroke="black" stroke-width="1" stroke-linecap="square"/>
                <line x1="0" y1="0" x2="0" y2="-300" stroke="black" stroke-width="1"/>
                <xsl:apply-templates select="//stooge"/>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="stooge">
        <xsl:variable name="percent" as="xs:integer" select="."/>
        <xsl:variable name="preceding-stooge" as="xs:integer" select="count(preceding-sibling::stooge)"/>
        <rect x="{$bar-interval+($bar-width+$bar-interval)*$preceding-stooge}" y="-{$percent*$yscale}" height="{$percent*$yscale}" width="{$bar-width}" fill="blue" stroke="black"/>
        <text x="{67+(67+33)*count(preceding-sibling::stooge)}" y="15" text-anchor="middle">
            <xsl:value-of select="@name"/>
        </text>
    </xsl:template>
</xsl:stylesheet>
