<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="input" as="xs:string" select="'trial_composition.csv'"/>
    <xsl:template name="xsl:initial-template">
        <xsl:variable name="text-lines" select="unparsed-text-lines($input)" as="xs:string+"/>
        <root>
            <xsl:for-each select="$text-lines">
                <line>
                    <xsl:variable name="tokenized-line" select="tokenize(., ',')"/>
                    <xsl:for-each select="$tokenized-line">
                        <data>
                            <xsl:value-of select="$tokenized-line"/>
                        </data>
                    </xsl:for-each>
                </line>
            </xsl:for-each>
        </root>
    </xsl:template>
</xsl:stylesheet>
