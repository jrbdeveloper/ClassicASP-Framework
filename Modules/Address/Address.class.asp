<%
'Mailing Address Class
class MailingAddress

	private m_Street
	private m_City
	private m_State
	private m_Zip
	private m_template

	public property get Street()
		Street = m_Street
	end property

	public property let Street(byref value)
		m_Street = value
	end property

	public property get City()
		City = m_City
	end property

	public property let City(byref value)
		m_City = value
	end property

	public property get State()
		State = m_State
	end property

	public property let State(byref value)
		m_State = value
	end property

	public property get Zip()
		Zip = m_Zip
	end property

	public property let Zip(byref value)
		m_Zip = value
	end property

	'Constructer
	private Sub Class_Initialize()
		m_template = "Modules/Address/Templates/address.template.tpl"
	end sub

	'Destructer
	private Sub Class_Terminate()
	end sub

	public function Load()
		Dim strValue

		Set fileSysObject = Server.CreateObject("Scripting.FileSystemObject")
		Set file = fileSysObject.OpenTextFile(Server.MapPath(m_template), 1)

		do while file.AtEndOfStream = false
			strValue = strValue & file.ReadLine & vbCrLF
		loop

		strValue = replace(strValue,"{street}",m_street)
		strValue = replace(strValue,"{city}",m_city)
		strValue = replace(strValue,"{state}",m_state)
		strValue = replace(strValue,"{zip}",m_zip)

		file.Close
		Set file = Nothing
		Set fileSysObject = Nothing

		Load = strValue
	end function

end class
%>