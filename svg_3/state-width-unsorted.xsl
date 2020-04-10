<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes"/>
    <!-- ================================================================ -->
    <!-- Variable-width bars, in document order (alphabetical by acronym) -->
    <!-- ================================================================ -->
    <!-- Stylesheet variables (available anywhere in the stylesheet)      -->
    <!--                                                                  -->
    <!-- $xScale as xs:integer : stretch horizontally                     -->
    <!-- $interbarSpacing as xs:double : distance between bars            -->
    <!-- $barShift as xs:double : space between Y axis is first bar       -->
    <!-- $xLength as xs:double : length of X axis                         -->
    <!-- $yScale as xs:integer : stretch vertically                       -->
    <!-- $fullHeight as xs:double : slightly larger than Y axis length    -->
    <!-- ================================================================ -->
    <xsl:variable name="xScale" as="xs:integer" select="3"/>
    <xsl:variable name="interbarSpacing" as="xs:integer" select="18"/>
    <xsl:variable name="barShift" as="xs:double" select="$interbarSpacing div 2"/>
    <xsl:variable name="xLength" as="xs:double"
        select="
            sum(//state/@elec) * $xScale +
            count(//state) * $interbarSpacing +
            $barShift
            "/>
    <xsl:variable name="yScale" select="8" as="xs:integer"/>
    <xsl:variable name="fullHeight" as="xs:double" select="105 * $yScale"/>
    <!-- ================================================================ -->

    <!-- ================================================================ -->
    <!-- Main                                                             -->
    <!-- ================================================================ -->
    <xsl:template match="/">
        <svg height="{$fullHeight + 200}">
            <g transform="translate(120, {$fullHeight + 30})">

                <!-- ==================================================== -->
                <!-- Ruling lines, tick marks, Y labels                   -->
                <!-- ==================================================== -->
                <xsl:for-each select="1 to 10">
                    <xsl:variable name="height" as="xs:double" select=". * 10 * $yScale"/>
                    <line x1="0" y1="-{$height}" x2="-10" y2="-{$height}" stroke="black"/>
                    <line x1="0" y1="-{$height}" x2="{$xLength}" y2="-{$height}" stroke="gray"/>
                    <text x="-20" y="-{$height}" text-anchor="end" alignment-baseline="central">
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
                <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>
                <line x1="0" x2="0" y1="0" y2="-{$fullHeight}" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>

                <!-- ==================================================== -->
                <!-- Axis labels                                          -->
                <!-- ==================================================== -->
                <text x="{$xLength div 2}" y="90" text-anchor="middle" font-size="200%">State
                    (acronym and electoral votes)</text>
                <text x="-70" y="-{$fullHeight div 2}" text-anchor="middle" font-size="200%"
                    writing-mode="tb">Democratic percentage</text>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="state">
        <!-- X position depends on sum of electoral votes of preceding states -->
        <xsl:variable name="currentStatePos" as="xs:integer" select="position()"/>
        <xsl:variable name="precedingStates" as="element(state)*"
            select="//state[position() lt $currentStatePos]"/>
        <xsl:variable name="xPos" as="xs:double"
            select="
                count($precedingStates) * $interbarSpacing +
                sum($precedingStates/@elec) * $xScale
                + $barShift
                "/>

        <!-- height depends on percentage of democratic votes -->
        <xsl:variable name="totalVotes" select="sum(candidate)" as="xs:double"/>
        <xsl:variable name="demVotes" select="candidate[@party = 'Democrat']" as="xs:integer"/>
        <xsl:variable name="demPer" select="$demVotes div $totalVotes * 100" as="xs:double"/>
        <xsl:variable name="height" as="xs:double" select="$demPer * $yScale"/>
        <xsl:variable name="width" as="xs:double" select="@elec * $xScale"/>
        <xsl:variable name="centerXPos" as="xs:double" select="$xPos + $width div 2"/>

        <!-- rectangle -->
        <rect x="{$xPos}" y="-{$height}" stroke="black" stroke-width=".5" fill="blue"
            width="{@elec * $xScale}" height="{$demPer * $yScale}"/>
        <!-- acronym -->
        <text x="{$centerXPos}" y="30" text-anchor="middle" font-size="120%">
            <xsl:value-of select="@acro"/>
        </text>
        <!-- electoral votes-->
        <text x="{$centerXPos}" y="50" text-anchor="middle">
            <xsl:value-of select="@elec"/>
        </text>
        <!-- percentage -->
        <text x="{$centerXPos}" y="-{$height + 10}" text-anchor="middle">
            <xsl:value-of select="round($demPer)"/>
        </text>
    </xsl:template>
</xsl:stylesheet>
