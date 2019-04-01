<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Here, we write global variables that can be applied at any point in our document. They can be
    applied anywhere because their value is computed only once, rather than "local variables", whose value
    changes with each <stooge> element that it finds.-->
    <xsl:variable name="bar-width" as="xs:integer" select="75"/>
    <xsl:variable name="bar-interval" as="xs:integer" select="25"/>
    <xsl:variable name="xlength" as="xs:integer" select="count(//stooge)*($bar-interval+$bar-width)"/>
    <xsl:variable name="ylength" as="xs:integer" select="300"/>
    <xsl:variable name="yscale" as="xs:integer" select="$ylength div 100"/>
    <!-- The variable $ylength was made after class finished. We set our y-axis length at 300 pixels,
    which is the same as it was before. Now, though, we've added another variable, $yscale, which
    takes our $ylength value and divides it by 100 (to know how much space each percent value occupies
    in the visualization). If we wanted to change our $ylength to 400 or 200 or 581, we wouldn't need
    to manually calculate what the $yscale would be as a result, since it's calculating that automatically for us.-->
    <xsl:template match="/">
        <svg>
            <g transform="translate(80,400)">
                <line x1="0" y1="0" x2="{$xlength}" y2="0" stroke="black" stroke-width="1" stroke-linecap="square"/>
                <line x1="0" y1="0" x2="0" y2="-{$ylength}" stroke="black" stroke-width="1"/>
                <xsl:apply-templates select="//stooge"/>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="stooge">
        
        <!-- Inside our template, we declare our local variables, which are computed values that
        are dependent upon different values or characteristics of each individual <stooge>. Since
        that value, e.g., its position in the sequence of stooges, its total number of tallies, etc.,
        change with the stooge in question, declaring local variables will allow us to make those
        calculations for each individual stooge. Notice that we also declare some global variables
        inside our <stooge> template, which is perfectly legal. -->
        <xsl:variable name="percent" as="xs:integer" select="."/>
        <xsl:variable name="preceding-stooge" as="xs:integer" select="count(preceding-sibling::stooge)"/>
        <rect x="{$bar-interval+($bar-width+$bar-interval)*$preceding-stooge}" y="-{$percent*$yscale}" height="{$percent*$yscale}" width="{$bar-width}" fill="blue" stroke="black"/>
        <text x="{$bar-interval+($bar-width+$bar-interval)*$preceding-stooge}" y="15" text-anchor="middle">
            <xsl:value-of select="@name"/>
        </text>
    </xsl:template>
</xsl:stylesheet>
