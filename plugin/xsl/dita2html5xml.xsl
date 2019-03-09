<!--
    Replaces base html5 transform in order to set the output method to
    xhtml from html.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0">
  
  <xsl:import href="plugin:org.dita.html5:xsl/dita2html5Impl.xsl"/>
  
  <xsl:output method="xhtml"
    encoding="UTF-8"
    indent="no"
    omit-xml-declaration="no"/>
  
  <!-- root rule -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
</xsl:stylesheet>