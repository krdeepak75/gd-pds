<xsl:stylesheet version="3.0" 
xmlns:fn ="http://www.w3.org/2005/xpath-functions"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/2005/xpath-functions">
<xsl:output method="text" encoding="UTF-8"/>

<xsl:template match="/msi_document">
    <!-- CONVERT INPUT TO XML FOR JSON -->
    <xsl:variable name="xml">
        <array>
            <xsl:for-each-group select="*" group-starting-with="DSSOBJECT">
            <xsl:sort select="xs:integer(DBMSType)" order="ascending"/>
                <map>
                    <string key="Name">
                        <xsl:value-of select="@NAME"/>
                    </string>
                    <string key="DBMSType">
                        <xsl:value-of select="DBMSType"/>
                    </string>
                    <string key="DatabaseType">
                        <xsl:value-of select="PROPERTYSET[@NAME='VLDB Report']/PROPERTY[@NAME='DBRole DB Type']/@VALUE"/>
                    </string>
                </map>
            </xsl:for-each-group>
        </array>
    </xsl:variable>
    <!-- OUTPUT -->
    <xsl:value-of select="xml-to-json($xml)"/>
</xsl:template>

</xsl:stylesheet>
