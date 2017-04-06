<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:import href=""/>
<xsl:output version="1.0" method="xml" indent="yes"/>
<xsl:variable name="ptitle" select="'VOTING ANALYSIS SHEET'"/>
<xsl:variable name="psubtitle" select="'STRICTLY CONFIDENTIAL'"/>

<xsl:template match="/">
	<fo:root>
		<fo:layout-master-set>
			<fo:simple-page-master master-name="votes_list" margin="3mm">
				<fo:region-body margin="1in">
				</fo:region-body>
				<fo:region-before extent="1in">
				</fo:region-before>
				<fo:region-after extent="1in">
				</fo:region-after>
			</fo:simple-page-master>
		</fo:layout-master-set>
		<fo:page-sequence master-reference="votes_list">
		
			<xsl:apply-imports></xsl:apply-imports>
				
			 <fo:flow flow-name="xsl-region-body">
				<xsl:apply-templates select="/list">
				</xsl:apply-templates>
			</fo:flow> 
		</fo:page-sequence>
	</fo:root>
</xsl:template>

<xsl:template match="/list">
		<fo:table inline-progression-dimension="auto">
			<fo:table-column column-width="auto" border="solid 0.2mm black" />
				<fo:table-column column-width="auto" border="solid 0.2mm black" />
				<fo:table-column column-width="13%" border="solid 0.2mm black" />
				<fo:table-column column-width="25%" border="solid 0.2mm black" />
				<fo:table-column column-width="auto" border="solid 0.2mm black" />
				<fo:table-column column-width="auto" border="solid 0.2mm black" />

				<fo:table-header font="8pt Arial" color="MEDIUMBLUE">
					<fo:table-row>
						<fo:table-cell padding="1pt">
							<fo:block font-weight="bold">Ward</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1pt">
							<fo:block font-weight="bold">Polling Station</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1pt">
							<fo:block font-weight="bold">Hour</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1pt">
							<fo:block font-weight="bold">Number of Ballot Papers Issued</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1pt">
							<fo:block font-weight="bold">Total Number Electors</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1pt">
							<fo:block font-weight="bold">Running Total</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>



				<fo:table-body font="7pt Arial" color="DARKSLATEGRAY">

					<xsl:for-each select="//row">
						<fo:table-row border="solid 0.1mm black" page-break-before="always">
						<fo:table-cell>
										<fo:block></fo:block>
									</fo:table-cell>
						</fo:table-row>
						<xsl:for-each select="timehourly/timehourly">
							<fo:table-row border="solid 0.1mm black">
	
									<fo:table-cell padding="1pt">
										<fo:block>
											<xsl:value-of select="../../ward"/>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell padding="1pt">
										<fo:block>
											<xsl:value-of select="../../pollingstationname"/>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell padding="1pt">
										<fo:block>
											<xsl:value-of select="hour"/>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell padding="1pt">
									
										<xsl:for-each select="papersissued/papersissued">
											<fo:block-container>
												<fo:block-container>
													<fo:block>
														<xsl:value-of select='ename' />
													</fo:block>
												</fo:block-container>
												<fo:block-container position="absolute"  text-align="right">
													<fo:block>
														<xsl:value-of select='papers' />
													</fo:block>
												</fo:block-container>
											</fo:block-container>
										</xsl:for-each>
										
									</fo:table-cell>
									
									<fo:table-cell padding="1pt">
										<fo:block>
											<xsl:value-of select='totalcount' />
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell padding="1pt">
										<fo:block>
											<xsl:value-of select='runningtotal' />
										</fo:block>
									</fo:table-cell>
									
							</fo:table-row>
						</xsl:for-each>	
					</xsl:for-each>
				</fo:table-body>
	
		</fo:table>
	
</xsl:template>

</xsl:stylesheet>
