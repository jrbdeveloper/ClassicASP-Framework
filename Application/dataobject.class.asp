<%
class DataObject
	
	private m_properties
	private m_filterOperator
	
	public property get Properties()
		set Properties = m_properties
	end property

	public property let Properties(byref value)
		set m_properties = value
	end property

	public property get FilterOperator()
		FilterOperator = m_filterOperator
	end property

	public property let FilterOperator(byref value)
		m_filterOperator = value
	end property

'Constructer
	private Sub Class_Initialize()
		Set m_properties = Server.CreateObject("Scripting.Dictionary")

		if IsEmpty(m_filterOperator) then
			m_filterOperator = "AND"
		end if
	end sub

	'Destructer
	private Sub Class_Terminate()
		Set m_properties = nothing
	end sub
	
	' Method queries the database for records based on the criteria filters and set the criteria properties
	'
	' Return: Void
	public function GetFrom(table)
		Dim i, x, strWhereFilters, keys, values
		Dim strWhere : set strWhere = new StringBuilder

		keys = m_properties.Keys
		values = m_properties.Items
		
		' assemble the where filters for the sql select statement
		for i=0 to m_properties.Count-1
			if m_properties.Exists(keys(i)) then
				if i < m_properties.Count then
					if IsNumeric(values(i)) then
						strWhere.Append(keys(i) & "=" & values(i) & m_filterOperator)
					else
						strWhere.Append(keys(i) & "='" & values(i) & "' " & m_filterOperator & " ")
					end if
				end if
			end if
		next

		' remove the trailing operator
		if InStrRev(strWhere.toString(),m_filterOperator) > 0 then
			strWhereFilters = trim(left(strWhere.toString(),instrrev(strWhere.toString(),m_filterOperator)-1))
		end if
		
		' Execute the sql statement
		objDatabase.rs(0).open objDatabase.Query(table,"",strWhereFilters), objDatabase.con

		' populate the criteria objects properties with the database values returned from the query
		for each x in objDatabase.rs(0).fields
			if not objDatabase.rs(0).eof then
				if not m_properties.Exists(x.name) then
					m_properties.Add x.name, x.value
				end if
			end if
		next
		objDatabase.rs(0).close

		set strWhere = nothing
	end function

	public function SaveTo(table, recordKey)
		Dim keys, values, i, strInsertKeys, strInsertValues, strUpdateValues

		Dim insertKeys : set insertKeys = new StringBuilder
		Dim insertValues : set insertValues = new StringBuilder
		Dim updateValues : set updateValues = new StringBuilder

		keys = m_properties.Keys
		values = m_properties.Items

		for i=0 to m_properties.Count-1
			if m_properties.Exists(keys(i)) then
				if i < m_properties.Count then
					if keys(i) <> "button" then
						
						if values(i) <> "" then
							insertKeys.Append(keys(i) & ", ")
						end if

						if IsNumeric(values(i)) then
							if recordKey > 0 then
								if values(i) <> "" then
									updateValues.Append(keys(i) & "=" & values(i) & ", ")
								end if
							else
								if values(i) <> "" then
									insertValues.Append(values(i) & ", ")
								end if
							end if
						else
							if recordKey > 0 then
								if values(i) <> "" then
									updateValues.Append(keys(i) & "='" & values(i) & "', ")
								end if
							else
								if values(i) <> "" then
									insertValues.Append("'" & values(i) & "', ")
								end if
							end if
						end if
					end if
				end if
			end if
		next

		' remove the trailing comma
		if InStrRev(insertValues.toString(),",") > 0 then
			if recordKey > 0 then
				strUpdateValues = trim(left(updateValues.toString(),instrrev(updateValues.toString(),",")-1))
			else
				strInsertKeys = trim(left(insertKeys.toString(),instrrev(insertKeys.toString(),",")-1))
				strInsertValues = trim(left(insertValues.toString(),instrrev(insertValues.toString(),",")-1))
			end if
		end if

		' Execute the sql statement
		if recordKey > 0 then
			objDatabase.con.execute objDatabase.Update(table, strUpdateValues, recordKey)
		else
			objDatabase.con.execute objDatabase.Insert(table, strInsertKeys, strInsertValues)
		end if

		set insertKeys = nothing
		set insertValues = nothing
		set updateValues = nothing
	end function

	' Method gets all query string variables past the param variable
	'
	' Return: Dictionary
	public function GetQueryStringValues()
		Dim qsDictionary : set qsDictionary = Server.CreateObject("Scripting.Dictionary")
		if request.QueryString.Count > 3 then
			for i=4 to request.QueryString.Count
				qsDictionary.Add request.QueryString.Key(i),request.QueryString.Item(i)
			next
		end if

		set GetQueryStringValues = qsDictionary
	end function

	' Method gets all form variables past the param variable
	'
	' Return: Dictionary
	public function GetFormValues()
		Dim x
		Dim frmDictionary : set frmDictionary = Server.CreateObject("Scripting.Dictionary")
		For x = 1 to Request.Form.Count	
			if not isEmpty(Request.Form.Item(x)) then
				frmDictionary.Add Request.Form.Key(x), Request.Form.Item(x)
			end if
		next

		set GetFormValues = frmDictionary
	end function
	
end class
%>