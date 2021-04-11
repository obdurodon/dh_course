<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="input" as="xs:string" select="'unparsed-practice.txt'"/>
    <xsl:template name="xsl:initial-template">
        <xsl:variable name="text" select="unparsed-text($input)"/>
        <xsl:variable name="text-lines" select="unparsed-text-lines($input)"/>
        <myElement>
            <sample type="unparsed-text">
                <xsl:value-of select="$text"/>
            </sample>
            <count type="unparsed-text">
                <xsl:value-of select="count($text)"/>
            </count>
            <sample type="unparsed-text-lines">
                <xsl:value-of select="$text-lines"/>
            </sample>
            <count type="unparsed-text-lines">
                <xsl:value-of select="count($text-lines)"/>
            </count>
            <!-- content goes here to create xml elements??? -->
        </myElement>
    </xsl:template>
</xsl:stylesheet>
