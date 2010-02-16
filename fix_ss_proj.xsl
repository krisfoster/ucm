<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ss="http://www.stellent.com/sitestudio/Project/" 
    exclude-result-prefixes="ss">

    <!-- Output methods, xml -->
    <xsl:output encoding="UTF-8" indent="yes" method="xml" />

    <!-- Identity transform -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- 
    Fix any sections without secondaryUrl and secondaryUrlFieldVariable attribute:
    * Add attribute: secondaryUrl="MODEL_INTRANET_ARTICLE_PAGE"
    * Add attribute: secondaryUrlVariableField="cr05_placeholder"
    -->
    <xsl:template match="ss:section[not(@secondaryUrl) and not(@secondaryUrlVariableField)]">
        <section xmlns="http://www.stellent.com/sitestudio/Project/">
            <xsl:attribute name="secondaryUrl">MODEL_INTRANET_ARTICLE_PAGE</xsl:attribute>
            <xsl:attribute name="secondaryUrlVariableField">cr05_placeholder</xsl:attribute>
            <xsl:apply-templates select="node()|@*"/>
        </section>
    </xsl:template>

    <!-- 
    Fix any sections without secondaryUrl and secondaryUrlFieldVariable attribute:
    * Add attribute: secondaryUrl="MODEL_INTRANET_ARTICLE_PAGE"
    * Add attribute: secondaryUrlVariableField="cr05_placeholder"
    -->
    <xsl:template match="ss:section[@secondaryUrl and not(@secondaryUrlVariableField)]">
        <section xmlns="http://www.stellent.com/sitestudio/Project/">
            <xsl:attribute name="secondaryUrlVariableField">cr05_placeholder</xsl:attribute>
            <xsl:apply-templates select="node()|@*"/>
        </section>
    </xsl:template>

</xsl:stylesheet>
