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
                    <xsl:variable name="tokenized-line" select="tokenize(., '\t')"/>
                    <xsl:for-each select="$tokenized-line">
                        <data>
                            <xsl:choose>
                                <xsl:when test="position()=2">
                                    <xsl:value-of
                                        select="tokenize(., '/')[last()] ! substring-before(., '.txt')"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="format-number(number(.), '0.00')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </data>
                    </xsl:for-each>
                </line>
            </xsl:for-each>
        </root>
    </xsl:template>
</xsl:stylesheet>
