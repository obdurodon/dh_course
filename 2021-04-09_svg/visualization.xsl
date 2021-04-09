<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <!-- ========================================================== -->
    <!-- Stylesheet variables                                       -->
    <!--                                                            -->
    <!-- $all-speeches as document-node()+                          -->
    <!-- $bar-width as xs:double                                    -->
    <!-- $speech-width as xs:double                                 -->
    <!-- $y-scale as xs:double                                      -->
    <!-- ========================================================== -->
    <xsl:variable name="all_speeches" as="document-node()+"
        select="collection('Marked_Up_Speeches?select=*.xml')"/>
    <xsl:variable name="bar-width" as="xs:double" select="20"/>
    <xsl:variable name="speech-width" as="xs:double" select="$bar-width * 1.5"/>
    <xsl:variable name="max-word-count" as="xs:integer"
        select="$all_speeches/descendant::body ! (tokenize(.) => count()) => max()"/>
    <xsl:variable name="y-scale" as="xs:double" select="0.1"/>
    <!-- ========================================================== -->
    <xsl:template name="xsl:initial-template">
        <svg>
            <g transform="translate(100, {$max-word-count * $y-scale + 100})">
                <!-- ============================================== -->
                <!-- Horizontal grid lines                          -->
                <!-- ============================================== -->
                <xsl:for-each select="0 to $max-word-count idiv 1000">
                    <xsl:variable name="y-value" as="xs:double" select="current() * 1000"/>
                    <line x1="0" y1="-{$y-value * $y-scale}"
                        x2="{count($all_speeches) * $speech-width}" y2="-{$y-value * $y-scale}"
                        stroke="lightgray" stroke-width="1"/>
                    <text x="-20" y="-{$y-value * $y-scale}" text-anchor="end"
                        dominant-baseline="middle">
                        <xsl:value-of select="$y-value"/>
                    </text>
                </xsl:for-each>
                <xsl:apply-templates select="$all_speeches/speech">
                    <xsl:sort select="descendant::date ! replace(., '.*(\d{4})$', '$1')"/>
                </xsl:apply-templates>
                <!-- ============================================== -->
                <!-- Axes                                           -->
                <!-- ============================================== -->
                <line x1="0" y1="0" x2="{count($all_speeches) * $speech-width}" y2="0"
                    stroke="black" stroke-width="2" stroke-linecap="square"/>
                <line x1="0" y1="0" x2="0" y2="-{$max-word-count * $y-scale}" stroke="black"
                    stroke-width="2" stroke-linecap="square"/>
            </g>
        </svg>
    </xsl:template>
    <!-- ========================================================== -->
    <!-- Bar and label for each speech -->
    <!-- ========================================================== -->
    <xsl:template match="speech">
        <!-- ====================================================== -->
        <!-- Template variables                                     -->
        <!--                                                        -->
        <!-- $word-count                                            -->
        <!-- $x-pos                                                 -->
        <!-- $y-pos                                                 -->
        <!-- $year                                                  -->
        <!-- $color                                                 -->
        <!-- ====================================================== -->
        <xsl:variable name="word-count" as="xs:integer" select="tokenize(body) => count()"/>
        <xsl:variable name="x-pos" as="xs:double" select="(position() - 1) * $speech-width"/>
        <xsl:variable name="y-pos" as="xs:double" select="$word-count * $y-scale"/>
        <xsl:variable name="year" as="xs:string" select="replace(meta/date, '.*(\d{4})$', '$1')"/>
        <xsl:variable name="color" as="xs:string" select="
                if (meta/party eq 'Democratic') then
                    'blue'
                else
                    if (meta/party eq 'Republican') then
                        'red'
                    else
                        'gray'"/>
        <rect x="{$x-pos}" y="-{$y-pos}" width="{$bar-width}" height="{$y-pos}" fill="{$color}"/>
        <text x="{$x-pos + $bar-width div 2}" y="10" text-anchor="start" writing-mode="tb">
            <xsl:value-of select="meta/name"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$year"/>
            <xsl:text>)</xsl:text>
        </text>
    </xsl:template>
</xsl:stylesheet>
