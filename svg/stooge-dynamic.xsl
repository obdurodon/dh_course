<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>

    <!-- ================================================================ -->
    <!-- Stylesheet variables                                             -->
    <!-- barWidth, interbarSpacing, maxWidth, maxHeight, yScale           -->
    <!-- ================================================================ -->
    <xsl:variable name="barWidth" as="xs:double" select="100"/>
    <xsl:variable name="interbarSpacing" as="xs:double" select="$barWidth div 2"/>
    <xsl:variable name="maxWidth" as="xs:double"
        select="count(//stooge) * ($barWidth + $interbarSpacing)"/>
    <xsl:variable name="maxHeight" as="xs:double" select="100"/>
    <xsl:variable name="yScale" as="xs:double" select="5"/>
    <!-- ================================================================ -->

    <!-- ================================================================ -->
    <!-- Main                                                             -->
    <!-- ================================================================ -->
    <xsl:template match="/">
        <svg>
            <g transform="translate(100, {$yScale * $maxHeight + 20})">
                <!-- ======================================================== -->
                <!-- SVG overlaps objects by drawing them as they are created -->
                <!--   so the order in which they are drawn matters where     -->
                <!--   they overlap                                           -->
                <!-- Neither ruling lines nor rectangles should overlap axes, -->
                <!--   so draw axes after them                                -->
                <!-- ======================================================== -->
                
                <!-- ======================================================== -->
                <!-- tick marks, ruling lines, and labels on Y axis           -->
                <!-- labels right-aligned and centered vertically on ticks    -->
                <!-- draw before axes, so that axes are on top of ruling      -->
                <!-- ======================================================== -->
                <xsl:for-each select="1 to 10">
                    <xsl:variable name="height" as="xs:double" select=". * 10 * $yScale"/>
                    <line x1="0" y1="-{$height}" x2="-10" y2="-{$height}" stroke="black"/>
                    <line x1="0" y1="-{$height}" x2="{$maxWidth}" y2="-{$height}" stroke="lightgray"/>
                    <text x="-20" y="-{$height}" text-anchor="end" alignment-baseline="central">
                        <xsl:value-of select=". * 10"/>
                    </text>
                </xsl:for-each>

                <!-- ======================================================== -->
                <!-- apply templates to <stooge> elements (sort?)             -->
                <!-- draw rectangles before axes, so that rectangles don’t    -->
                <!--   dig into X axis                                        -->
                <!-- ======================================================== -->
                <xsl:apply-templates select="//stooge"/>

                <!-- ======================================================== -->
                <!-- draw axes                                                -->
                <!-- lines should meet squarely                               -->
                <!-- should be drawn after ruling lines and rectangles        -->
                <!--   because of overlap                                     -->
                <!-- ======================================================== -->
                <line x1="0" y1="0" x2="{$maxWidth}" y2="0" stroke="black" stroke-linecap="square"/>
                <line x1="0" y1="0" x2="0" y2="-{$maxHeight * $yScale}" stroke="black"
                    stroke-linecap="square"/>
                
                <!-- ======================================================== -->
                <!-- label both axes                                          -->
                <!-- labels should be centered on axis and large              -->
                <!-- y label should be vertical                               -->
                <!-- can be drawn at any time; doesn’t overlap with anything  -->
                <!-- ======================================================== -->
                <text x="{$maxWidth div 2}" y="{10 * $yScale}" text-anchor="middle"
                    font-size="larger">Stooges</text>
                <text x="-60" y="-{$maxHeight * $yScale div 2}" writing-mode="tb"
                    text-anchor="middle" font-size="larger">Percentage</text>

            </g>
        </svg>
    </xsl:template>
    <xsl:template match="stooge">
        <!-- ============================================================ -->
        <!-- $xPos variable:                                              -->
        <!--    function of position(), $barWidth, $interbarSpacing       -->
        <!-- ============================================================ -->
        <xsl:variable name="xPos" as="xs:double"
            select="
                ($interbarSpacing div 2) +
                (position() - 1) * ($barWidth + $interbarSpacing)"/>

        <!-- ============================================================ -->
        <!-- draw rectangle                                               -->
        <!-- ============================================================ -->
        <rect x="{$xPos}" y="-{$yScale * .}" width="{$barWidth}" height="{. * $yScale}" fill="blue"/>

        <!-- ============================================================ -->
        <!-- write percentage above rectangle                             -->
        <!-- percentage should be centered over rectangle                 -->
        <!-- ============================================================ -->
        <text x="{$xPos + $barWidth div 2}" y="-{(. + 3) * $yScale}" text-anchor="middle">
            <xsl:value-of select=". || '%'"/>
        </text>

        <!-- ============================================================ -->
        <!-- write stooge name under rectangle, centered                  -->
        <!-- ============================================================ -->
        <text x="{$xPos + $barWidth div 2}" y="{5 * $yScale}" text-anchor="middle">
            <xsl:value-of select="@name"/>
        </text>
    </xsl:template>
</xsl:stylesheet>
