<%
'###########################################################################################################################
'#	Library	: dbClass.asp																									
'#	Class	: Database																										
'#	Methods	: open([strDb],[intRsCount]) 																					
'#			  close([intRsCount])																							
'#	Example : 																												
'#			Dim rsCount : rsCount = 3																						
'#			objDatabase.open("dbName",rsCount) or objDatabase.open("dbName","")												
'#			objDatabase.rs(0).open "SELECT * FROM [table]",objDatabase.con													
'#			while not objDatabase.rs(0).eof																					
'#				response.write objDatabase.rs(0)("attributeName") 'Write out the contents of the query						
'#				objDatabase.rs(1).open "SELECT * FROM [table] WHERE attrib='"& rs(0)("attrib") &"'",objDatabase.con			
'#				response.write objDatabase.rs(1)("attrib") 'Write out the contents of the query								
'#				objDatabase.rs(0).movenext																					
'#			wend																											
'#			objDatabase.close(rsCount)																						
'#																															
'#	NOTE:																													
'#	The rs() array is a 0 base indexed array. When you call the open method the first object will always					
'#	be: rs(0) even when you specify a blank string for the open methods second argument. The above 							
'#	example code tells the open method to create 3 recordsets ie. rs(0), rs(1), rs(2) unless you pass 						
'#	an empty string as the second argument then it will just be rs(0).														
'#																															
'#	A default database object has been created from the class and will be appropriately destroyed.							
'#	If the user creates an object from the class then they are responsible for destroying that object.						
'# 																															
'#	Feel free to copy this class and use it in other applications and rename the class as you see fit. I recommend naming it
'#	Database																												
'###########################################################################################################################
	class Database
		' Create a public connection and recordset array class attributes
		public con,rs()
		
		' Create a loop counter
		private counter
		
		' Open a connection to the database
		public function open(strDatabase,rsCount)
			counter = 0
			
			' Instantiate the connection object
			Set con = Server.CreateObject("ADODB.Connection")
			con.ConnectionTimeout = 120
			
			' If the method contains a value for the array index
			if rsCount <> "" AND rsCount > 0 then
				
				' Set the array index
				Redim rs(rsCount)
				
				' Loop through and create the specified number of recordsets
				while counter < ubound(rs)
					Set rs(counter) = Server.CreateObject("ADODB.Recordset")
					counter=counter+1
				wend
				
			' The method didn't contain a value for the array index, create the standard rs object
			else
				' Set the array index
				Redim rs(rsCount)
				Set rs(0) = Server.CreateObject("ADODB.Recordset")
			end if
			
			' Checked the URL and found that we are on the production server
			If (Instr(Request.ServerVariables("HTTP_HOST"),"www.") > 0) OR (Instr(Request.ServerVariables("HTTP_HOST"),".com") > 0) Then
	        	Con.Open "Driver={SQL Server}; Server=[server]; Database="& strDatabase &"; UID=[username]; PWD=[password]"
			
			' Checked the URL and found that we are on the staging server
			ElseIf Instr(Request.ServerVariables("HTTP_HOST"),"staging1") > 0 then
	        	Con.Open "Driver={SQL Server}; Server=[server]; Database="& strDatabase &"; UID=[username]; PWD=[password]"
			
			' We must be on the development server
			Elseif Instr(Request.ServerVariables("HTTP_HOST"),"localhost") > 0 then
	        	Con.Open "Provider=SQLOLEDB; Data Source = DEVDB3; Initial Catalog = "& strDatabase &"; User Id = defenseweb; Password=?sayyea!"

			elseif Instr(Request.ServerVariables("HTTP_HOST"),"webhost") > 0 then
				Con.Open "Driver={SQL Server}; Server=[server]; Database="& strDatabase &"; UID=[username]; PWD=[password]"
			
			elseif Instr(Request.ServerVariables("HTTP_HOST"),"portal.") > 0 then
				Con.Open "Driver={SQL Server}; Server=[server]; Database="& strDatabase &"; UID=[username]; PWD=[password]"
			End If
		end function

		' Close the connection to the database
		public function close(rsCount)
			Dim counter : counter = 0
			' Close and destroy the connection object
			con.close
			Set con = nothing
			' Loop through and close and destroy all recordset objects
			do until counter > rsCount
				on error resume next
				if rs(counter).status = 1 then
					rs(counter).close
					Set rs(counter) = Nothing
				end if
				counter=counter+1
			loop
			' Destroy the default database object
			'set objDatabase = nothing
		end function

		public function Query(strTable, strColumns, strFilters)
			if strColumns <> "" then
				Query = "SELECT "& strColumns &" FROM " & strTable & " WHERE " & strFilters
			else
				Query = "SELECT * FROM " & strTable & " WHERE " & strFilters
			end if
		end function

		public function Insert(strTable, strKeys, strValues)
			Insert = "INSERT INTO "& strTable & "("& strKeys &") values(" & strValues & ")"
		end function

		public function Update(strTable, strValues, ID)
			Update = "UPDATE " & strTable & " SET " & strValues & " WHERE " & strTable & "ID=" & ID
		end function

		public function Delete(strTable, strValues, ID)
			Delete = "DELETE FROM " & table & " WHERE " & table & "ID=" & ID
		end function
	end class
%>