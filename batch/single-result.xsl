<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <!-- ================================================================ -->
    <!-- Multiple inputs, single output                                   -->
    <!-- Do not specify input document in <oXygen/> debugger              -->
    <!-- ================================================================ -->
    
    <xsl:template name="xsl:initial-template">
        <out>
            <p>Consolidated result</p>
            <xsl:for-each select="collection('xml')">
                <xsl:copy-of select="root"/>
            </xsl:for-each>
        </out>
    </xsl:template>

</xsl:stylesheet>
