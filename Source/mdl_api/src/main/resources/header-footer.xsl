<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/">
		<fo:static-content flow-name="xsl-region-before">
			<fo:block-container position="absolute">
				<fo:block font-size="6pt">					
					<fo:external-graphic content-height="25%"
						content-width="scale-to-fit" scaling="uniform" overflow="hidden"
						src="mdl-logo.png" />
					
				</fo:block>
			</fo:block-container>
			<fo:block-container position="absolute">
				<fo:block text-align="right" font-size="6pt" font-family="Times">
					<fo:inline color="#6A6766">Modern Democracy Limited</fo:inline>
				</fo:block>
			</fo:block-container>
			<fo:block font-size="15pt" text-align="center" margin-top="5mm"
				font-family="Times" font-weight="bold">
				<xsl:value-of select="$ptitle" />
			</fo:block>
			<fo:block font-size="11pt" text-align="center" font-family="Times" margin-top="2mm"
				font-weight="normal">
				<fo:inline color="#9D0808"><xsl:value-of select="$psubtitle" /></fo:inline>
			</fo:block>
		</fo:static-content>
		<fo:static-content flow-name="xsl-region-after">
			<fo:block font-size="6pt" text-align="center" font-family="Times"
				margin-bottom="2mm">
				<fo:inline color="#9D7A8C">Copyright &#169; 2016 MDL. All rights reserved</fo:inline>				
			</fo:block>
			<fo:block font-size="10pt" text-align="right" font-family="Times"
				margin-bottom="0.2cm">
				<fo:inline color="#577777">Page <fo:page-number /></fo:inline>	
			</fo:block>
		</fo:static-content>
	</xsl:template>
</xsl:stylesheet>