<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <!-- ================================================================ -->
    <!-- Run against election_2012_data.xml                               -->
    <!-- Uncomment individual lines to see what they do                   -->
    <!-- To see the whitespace in your XML as visible characters, go to:  -->
    <!--   Preferences->Editor and then look for the Whitespaces section  -->
    <!-- ================================================================ -->
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <states>
            <!-- ======================================================== -->
            <!--   Apply templates to all child nodes:                    --> 
            <!--    elements and text (including whitespace)              -->
            <!-- ======================================================== -->
            <!--<xsl:apply-templates/>-->

            <!-- ======================================================== -->
            <!-- Apply templates only to states                           --> 
            <!-- ======================================================== -->
            <!--<xsl:apply-templates select="//state"/>-->

            <!-- ======================================================== -->
            <!-- Apply templates only to some states                      --> 
            <!-- ======================================================== -->
            <!--<xsl:apply-templates select="//state[starts-with(@name, 'O')]"/>-->
        </states>
    </xsl:template>
    <xsl:template match="state">
        <state>
            <xsl:text>Hi, I’m state name </xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text> at position </xsl:text>
            <xsl:value-of select="position()"/>

            <!-- ======================================================== -->
            <!-- how to use <xsl:message>                                 -->
            <!-- ======================================================== -->

            <!--<xsl:message>Hi, Mom!</xsl:message>-->
            
            <!--<xsl:message>
                <xsl:value-of select="position()"/>
            </xsl:message>-->
        </state>
    </xsl:template>
</xsl:stylesheet>
