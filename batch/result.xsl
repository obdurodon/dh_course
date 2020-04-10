<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <!-- ================================================================ -->
    <!-- Multiple input, multiple output                                  -->
    <!-- Do not specify input document in <oXygen/> debugger              -->
    <!-- ================================================================ -->
    <xsl:template name="xsl:initial-template">
        <xsl:for-each select="collection('xml')">
            <xsl:message select="'Processing file #' || position()"/>
            <xsl:result-document href="result/{tokenize(base-uri(), '/')[last()]}">
                <out>
                    <p>Result document</p>
                    <xsl:copy-of select="root"/>
                </out>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
