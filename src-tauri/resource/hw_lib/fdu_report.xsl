<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="report">
  <html>
  <body>
  	<p>
  		<font size="6" face="Calibri">
  			<b><xsl:value-of select="@label"/></b>
  			<b><xsl:text> for Design '</xsl:text></b>
  			<b><xsl:value-of select="@design"/></b>
  			<b><xsl:text>'</xsl:text></b>
  		</font>		
  	</p>
  	<xsl:for-each select="section">
  		<br/>
  		<br/>
  		<font size="4" face="Verdana"><h3><xsl:value-of select="@label"/></h3></font>
  		<pre>--------------------------</pre>
  		
  			<xsl:for-each select="item">
  				<table align="center" width="100%" border="0" bordercolor="#000000">
  					<tr>
  						<td width="20%">
  							<font size="3" face="Courier New">
	  							<b><xsl:value-of select="@label"/></b>
  								<b><xsl:text>:</xsl:text></b>
  							</font>
  						</td>
  						<td align="left">
  							<font size="3" face="Courier New">
  								<xsl:value-of select="@value"/>
  							</font>
  						</td>
  					</tr>
  				</table>
  				<xsl:for-each select="item">
  					<table align="center" width="100%" border="0" bordercolor="#000000">
  						<tr>
  							<td width="5%"/>
  							<td width="60%">
  								<font size="3" face="Courier New">
 		 								<b><xsl:value-of select="@label"/></b>
  									<b><xsl:text>:</xsl:text></b>
  								</font>
  							</td>
  							<td width="35%" align="left">
  								<font size="3" face="Courier New">
  									<xsl:value-of select="@value"/>
  								</font>
  							</td>
  						</tr>
  					</table>	
  					<xsl:for-each select="item">
  						<table align="center" width="100%" border="0" bordercolor="#000000">
  							<tr>
  								<td width="10%"/>
  								<td width="55%">
  									<font size="3" face="Courier New">
	  									<b><xsl:value-of select="@label"/></b>
  										<b><xsl:text>:</xsl:text></b>
  									</font>
  								</td>
  								<td align="left" width="35%" >
  									<font size="3" face="Courier New">
	  									<xsl:value-of select="@value"/>
	  								</font>
  								</td>
  							</tr>
  						</table>
  					</xsl:for-each>
  				</xsl:for-each>
  			</xsl:for-each>
  			
  			<xsl:for-each select="table">
  				<div><font size = "5" face = "Calibri"><b><xsl:value-of select="@label"/></b></font></div>
  				<table width="80%">
  					<tr bgcolor="#9acd32">
      				<xsl:for-each select="column">
      					<th align="center"><font size = "4" face = "Calibri"><xsl:value-of select="@label"/></font></th>
      				</xsl:for-each>
    				</tr>
    				<xsl:for-each select="row">
    					<tr>
    						<xsl:for-each select="item">
    							<td align="center"><font size = "3" face = "Courier New"><xsl:value-of select="@value"/></font></td>
    						</xsl:for-each>
    					</tr>
    				</xsl:for-each>
  				</table>
  			</xsl:for-each>
  			
  	</xsl:for-each>
  	
  	
		<br/>
		<br/>
  	<xsl:for-each select="item">
  		<table align="center" width="100%" border="0" bordercolor="#000000">
  			<td width="65%">
  				<font size = "4" face = "Calibri">
  					<b><xsl:value-of select="@label"/></b>
  					<b><xsl:text>:</xsl:text></b>
  				</font>
  			</td>
  			<td width="35%">
  				<font size = "4" face = "Calibri">
  					<xsl:value-of select="@value"/>
  				</font>
  			</td>
  		</table>
  	</xsl:for-each>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>