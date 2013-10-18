<form name="softwaretracker" action="default.asp?obj=software&task=save&param={recordKey}" method="post">
<table border="0">
	<tr>
		<td width="145"><label for="productName">Product Name</label></td>
		<td>
			<input type="text" id="productName" name="productName" value="{productName}" />
		</td>
	</tr>
	<tr>
		<td><label for="productVersion">Version</label></td>
		<td>
			<input type="text" id="productVersion" name="productVersion" value="{productVersion}" />
		</td>
	</tr>
	<tr>
		<td>
			<label for="purchaseDate">Purchase Date</label>
		</td>
		<td>
			<input type="text" id="purchaseDate" name="purchaseDate" value="{purchaseDate}" />
		</td>
	</tr>
	<tr>
		<td>
			<label for="expirationDate">Expiration Date</label>
		</td>
		<td>
			<input type="text" id="expirationDate" name="expirationDate" value="{expirationDate}" />
		</td>
	</tr>
	<tr>
		<td>
			<label for="purchaseMethod">Purchase Method</label>
		</td>
		<td>
			<input type="text" id="purchaseMethod" name="purchaseMethod" value="{purchaseMethod}" />
		</td>
	</tr>
	<tr>
		<td>
			<label for="installedOnCSHIP">Installed On CSHIP</label>
		</td>
		<td>
			<input type="text" id="installedOnCSHIP" name="installedOnCSHIP" value="{installedOnCSHIP}" />
		</td>
	</tr>
</table>

{contract}
{license}

<input type="submit" id="btnSave" name="button" value="Save" />
	
</form>