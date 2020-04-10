<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <!-- ================================================================ -->
    <!-- Single input, single output                                      -->
    <!-- Normal XSLT confugration, can be run as patch with               -->
    <!--   transformation scenario                                        -->
    <!-- ================================================================ -->
    
    <xsl:template match="/">
        <out>
            <xsl:copy-of select="root"/>
        </out>
    </xsl:template>
</xsl:stylesheet>
