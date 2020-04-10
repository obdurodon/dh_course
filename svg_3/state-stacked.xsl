<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes"/>
    <!-- ================================================================ -->
    <!-- Create stacked bar chart, uniform bar width                      -->
    <!-- ================================================================ -->
    <!-- Stylesheet variables (available anywhere in the stylesheet)      -->
    <!--                                                                  -->
    <!-- $barWidth as xs:integer : width of rectangle                     -->
    <!-- $interbarSpacing as xs:double : distance between bars            -->
    <!-- $barShift as xs:double : space between Y axis and first bar      -->
    <!-- $yScale as xs:integer : stretch vertically                       -->
    <!-- $fullHeight as xs:double : slightly larger than Y axis length    -->
    <!-- ================================================================ -->
    <xsl:variable name="bar_width" as="xs:integer" select="30"/>
    <xsl:variable name="interbarSpacing" as="xs:double" select="$bar_width div 2"/>
    <xsl:variable name="barShift" as="xs:double" select="$interbarSpacing div 2"/>
    <xsl:variable name="fullWidth" as="xs:double"
        select="count(//state) * ($bar_width + $interbarSpacing) + $barShift"/>
    <xsl:variable name="yScale" select="8" as="xs:integer"/>
    <xsl:variable name="fullHeight" as="xs:double" select="105 * $yScale"/>

    <!-- ================================================================ -->

    <!-- ================================================================ -->
    <!-- Main                                                             -->
    <!-- ================================================================ -->
    <xsl:template match="/">
        <svg height="{$fullHeight + 150}">
            <g transform="translate(120, {$fullHeight + 30})">

                <!-- ==================================================== -->
                <!-- Ruling lines, tick marks, Y labels                   -->
                <!-- ==================================================== -->
                <xsl:for-each select="1 to 10">
                    <xsl:variable name="yPos" as="xs:double" select=". * 10 * $yScale"/>
                    <line x1="0" y1="-{$yPos}" x2="-10" y2="-{$yPos}" stroke="black"/>
                    <line x1="0" y1="-{$yPos}" x2="{$fullWidth}" y2="-{$yPos}" stroke="gray"/>
                    <text x="-20" y="-{$yPos}" text-anchor="end" alignment-baseline="central">
                        <xsl:value-of select=". * 10"/>
                    </text>
                </xsl:for-each>

                <!-- ==================================================== -->
                <!-- States overlap ruling lines                          -->
                <!-- ==================================================== -->
                <xsl:apply-templates select="//state"/>

                <!-- ==================================================== -->
                <!-- Axes overlap rectangles                              -->
                <!-- ==================================================== -->
                <line x1="0" y1="0" x2="{$fullWidth}" y2="0" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>
                <line x1="0" x2="0" y1="0" y2="-{$fullHeight}" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>

                <!-- ==================================================== -->
                <!-- Axis labels                                          -->
                <!-- ==================================================== -->
                <text x="{$fullWidth div 2}" y="90" text-anchor="middle" font-size="200%">State
                    (acronym and electoral votes)</text>
                <text x="-70" y="-{$fullHeight div 2}" text-anchor="middle" font-size="200%"
                    writing-mode="tb">Democratic percentage</text>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="state">
        <xsl:variable name="xPos" as="xs:double"
            select="(position() - 1) * ($bar_width + $interbarSpacing) + $barShift"/>
        <xsl:variable name="totalVotes" select="sum(candidate)" as="xs:double"/>
        <xsl:variable name="demVotes" select="candidate[@party = 'Democrat']" as="xs:integer"/>
        <xsl:variable name="repVotes" select="candidate[@party = 'Republican']" as="xs:integer"/>
        <xsl:variable name="greenVotes" select="candidate[@party = 'Green']" as="xs:integer"/>
        <xsl:variable name="libVotes" select="candidate[@party = 'Libertarian']" as="xs:integer"/>
        <xsl:variable name="demPer" select="$demVotes div $totalVotes * 100" as="xs:double"/>
        <xsl:variable name="repPer" select="$repVotes div $totalVotes * 100" as="xs:double"/>
        <xsl:variable name="greenPer" select="$greenVotes div $totalVotes * 100" as="xs:double"/>
        <xsl:variable name="libPer" select="$libVotes div $totalVotes * 100" as="xs:double"/>
        <xsl:variable name="centerXPos" as="xs:double" select="$xPos + $bar_width div 2"/>

        <!-- rectangle -->
        <rect x="{$xPos}" y="-{100 * $yScale}" stroke="black" width="{$bar_width}" fill="blue"
            height="{100 * $yScale}"/>
        <rect x="{$xPos}" y="-{($greenPer + $libPer + $repPer) * $yScale}" fill="green"
            width="{$bar_width}" height="{($greenPer + $libPer + $repPer) * $yScale}"/>
        <rect x="{$xPos}" y="-{($libPer + $repPer) * $yScale}" fill="yellow" width="{$bar_width}"
            height="{($libPer + $repPer) * $yScale}"/>
        <rect x="{$xPos}" y="-{$repPer * $yScale}" fill="red" width="{$bar_width}"
            height="{$repPer * $yScale}"/>
        <!-- acronym -->
        <text x="{$centerXPos}" y="30" text-anchor="middle" font-size="120%">
            <xsl:value-of select="@acro"/>
        </text>
    </xsl:template>
</xsl:stylesheet>
