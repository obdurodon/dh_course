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
    <!-- 
        Avoid duplicate code by using <xsl:next-match>
        2018-03-20 djb
        
        Speeches that aren't the last by their speaker flow from <p> to <a> to <strong>
        Those that are the last by their speaker bypass the <a> step
    -->
    <xsl:template match="speech" priority="1">
        <!-- 
            All speeches have <p> wrapper with @class and @id
            This has an explicit higher priority than the defaults, and will fire first
            We have to pass the $count value to the next template explicitly as a parameter
        -->
        <xsl:variable as="xs:integer" name="count"
            select="count(preceding::speech[@speaker eq current()/@speaker])"/>
        <p class="{lower-case(@speaker)}" id="{concat(@speaker, $count)}">
            <xsl:next-match>
                <xsl:with-param name="count" select="$count"/>
            </xsl:next-match>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="speech[following::speech[@speaker eq current()/@speaker]]">
        <xsl:param name="count" required="yes"/>
        <!-- 
            Speeches that aren't the last by their speaker have an <a> with an @href
            This has higher priority than the template below because of the predicate
        -->
        <a href="{concat('#',@speaker,$count + 1)}">
            <xsl:next-match/>
        </a>
    </xsl:template>
    <xsl:template match="speech">
        <!-- 
            All speeches embold the speaker name
            This has the lowest priority of the three templates that match speeches 
        -->
        <strong>
            <xsl:apply-templates select="@speaker"/>
            <xsl:text>:</xsl:text>
        </strong>
    </xsl:template>
    <!-- End of <xsl:next-match> change-->
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
