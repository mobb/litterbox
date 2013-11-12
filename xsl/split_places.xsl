<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <!-- 
    
    stylesheet to convert a group of
    SBC's places into individual docs. based on split_citations.xsl, and split_Data_places.xsl
    
    1. Uses the "override copy idiom" from example 8.1,  in the XSLT Cookbook, 2nd edition
    2. then XSLT2.0 instructions for multiple document output. (example 6.9)
    3. for now, you have to run this in oxygen, since it has xslt2
  -->
  <!-- <xsl:import href="copy.xsl"/> -->
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
 
  <xsl:variable name="xml_output_dir">/Volumes/sbc-data/internal/research/Metadata/Site_Descriptions/working/output_temp</xsl:variable>
 
<xsl:template match="/places">
    <xsl:for-each-group select="place" group-by="@siteid">
    
      <xsl:result-document href="{$xml_output_dir}/waypoint_{current-grouping-key()}.xml">

     <!--    <xsl:result-document href="00_waypoint_{current-grouping-key()}.xml">-->
        
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
