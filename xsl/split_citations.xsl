<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <!-- 
    
    stylesheet to convert SBC's large biblio doc into separate EML 2.1 docs.
    1. Uses the "override copy idiom" from example 8.1,  in the XSLT Cookbook, 2nd edition
    2. then XSLT2.0 instructions for multiple document output. (example 6.9)
    3. an extra "address" element was added to dev DTD, and needs to be removed for EML2.1. this
    followed example 8.7 (love that book!)
    4. dev DTD allowed mixed content in titles, EML2.1 does not
    5. dev DTD put additionalMetadata inside citation element, wrong, too.
  -->
  <xsl:import href="copy.xsl"/>
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
 
<xsl:template match="citationList">
    <xsl:for-each-group select="citation" group-by="@id">
      <xsl:result-document href="output/citation-{current-grouping-key()}.xml">
        
        <!-- wrap the output in the eml element  -->
        <eml:eml  xmlns:eml="eml://ecoinformatics.org/eml-2.1.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="eml://ecoinformatics.org/eml-2.1.0 eml.xsd">
          <!-- add the required attributes; this is revision #1 for all citations.  -->
          <xsl:attribute name="packageId">
              <xsl:value-of select="concat(current-grouping-key(), '.1')"/>
          </xsl:attribute>
          <xsl:attribute name="system">knb</xsl:attribute>
          <xsl:attribute name="scope">system</xsl:attribute>
          
          <!-- apply the copy rules from copy.xsl -->
          <xsl:apply-templates select="current-group()"/>

          <!-- put the additionalMetadata in the right place, if there is one in the original doc -->
          <xsl:if test="additionalMetadata">
          <additionalMetadata>
            <xsl:copy-of select="additionalMetadata/*"/>
          </additionalMetadata>
          </xsl:if>
        </eml:eml>
        </xsl:result-document>
    </xsl:for-each-group>
</xsl:template>
  
  <xsl:template name="flatten-conferenceLocation" match="conferenceLocation">
    <xsl:copy>
      <!--  keep only the grandchildren -->
      <xsl:apply-templates select="*/*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template name="flatten-title" match="title/emphasis">
    <!--  keep only the text children -->
      <xsl:apply-templates select="./text()"/>
  </xsl:template>
  
  
  <!-- pubDate and contact were switched in the DTD. need these 2 templates to swap them
  the first copies pubDate to above contact, the second removes the extra pubDate. -->
  <xsl:template name="swap-pubDate-contact" match="contact[following-sibling::pubDate]">
      <xsl:copy-of select="following-sibling::pubDate"/>
      <xsl:copy-of select="."/>
        </xsl:template>
  
  <xsl:template name="remove-extra-pubDate" match="pubDate[preceding-sibling::contact]">
   <!-- do nothing -->
  </xsl:template> 
  
  <xsl:template name="remove-extra-additionalMetadata" match="citation/additionalMetadata">
    <!-- do nothing -->
  </xsl:template> 
  
  <!-- template to prune the pubDate node if empty -->
  <xsl:template match="pubDate">
    <xsl:call-template name="prune-if-empty"></xsl:call-template>
  </xsl:template>
  
  <!-- template to prune the pageRange node if empty -->
  <xsl:template match="pageRange">
    <xsl:call-template name="prune-if-empty"></xsl:call-template>
  </xsl:template>
  
  <!-- template to prune the ISBN node if empty -->
  <xsl:template match="ISBN">
    <xsl:call-template name="prune-if-empty"></xsl:call-template>
  </xsl:template>
  
  <!-- template to prune the totalPages node if empty -->
  <xsl:template match="totalPages">
    <xsl:call-template name="prune-if-empty"></xsl:call-template>
  </xsl:template>
  
  <!-- the generic template to prune an element with no text content. dont use this on elements 
    that have attribute nodes without text-->
  <xsl:template name="prune-if-empty">
    <xsl:choose>
      <xsl:when test="not(normalize-space())">
        <!-- empty,  node is dropped -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@* | node()"></xsl:apply-templates>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
 
  
</xsl:stylesheet>
