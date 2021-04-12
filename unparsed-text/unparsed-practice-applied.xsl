<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="input" as="xs:string" select="'input.txt'"/>
    <xsl:template name="xsl:initial-template">
        <xsl:variable name="text-lines" select="unparsed-text-lines($input)" as="xs:string+"/>
    </xsl:template>
</xsl:stylesheet>
