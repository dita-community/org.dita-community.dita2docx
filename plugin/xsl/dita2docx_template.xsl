<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita="http://dita-ot.sourceforge.net"
  exclude-result-prefixes="xs dita"
  expand-text="yes"
  version="3.0">
  <!-- ==========================================================================================
       DITA to DOCX Simple Word Processing XML (SWPX) Generation Transform
       
       This transform takes the HTML5 output of the base HTML5 plug and generates SWPX XML from
       it. The SWPX XML is then the input to the Wordinator Java application that generates the
       final DOCX files.
       
       Copyright (c) 2019 DITA Community
       
       Author: Eliot Kimber, ekimber@contrext.com
       
       ========================================================================================== -->
  
  <xsl:import href="ditahtml2docx/ditahtml2docx.xsl"/>
  
  <dita:extension id="xsl.dc.dita2docx" 
    behavior="org.dita.dost.platform.ImportXSLAction" 
    xmlns:dita="http://dita-ot.sourceforge.net"
  />
  
  
</xsl:stylesheet>