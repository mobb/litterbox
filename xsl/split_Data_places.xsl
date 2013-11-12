<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <!-- 
    
    stylesheet to convert "Data" export from Acrobat 
    SBC's places into individual docs. based on split_citations.xsl
    
    1. Uses the "override copy idiom" from example 8.1,  in the XSLT Cookbook, 2nd edition
    2. then XSLT2.0 instructions for multiple document output. (example 6.9)
    3. an extra "address" element was added to dev DTD, and needs to be removed for EML2.1. this
    followed example 8.7 (love that book!)
    4. dev DTD allowed mixed content in titles, EML2.1 does not
    5. dev DTD put additionalMetadata inside citation element, wrong, too.
  -->
  <!-- <xsl:import href="copy.xsl"/> -->
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
 
<xsl:template match="Data">
    <xsl:for-each-group select="place" group-by="@siteid">
      <xsl:result-document href="output/vector_{current-grouping-key()}_data.xml">
        
          <!-- apply the copy rules from copy.xsl -->
          <xsl:apply-templates select="current-group()"/>

        </xsl:result-document>
    </xsl:for-each-group>
</xsl:template>
 
 
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
