<%
class PhoneNumber

	private m_AreaCode
	private m_Prefix
	private m_Sufix
	private m_template
	
	public property get AreaCode()
		set AreaCode = m_AreaCode
	end property

	public property let AreaCode(byref value)
		m_AreaCode = value
	end property

	public property get Prefix()
		Prefix = m_Prefix
	end property

	public property let Prefix(byref value)
		m_Prefix = value
	end property

	public property get Sufix()
		Sufix = m_Sufix
	end property

	public property let Sufix(byref value)
		m_Sufix = value
	end property

	'Constructer
	private Sub Class_Initialize()
		m_template = "Modules/Phone/Templates/phone.template.tpl"
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

		strValue = replace(strValue,"{areacode}",m_AreaCode)
		strValue = replace(strValue,"{prefix}",m_Prefix)
		strValue = replace(strValue,"{sufix}",m_Sufix)

		file.Close
		Set file = Nothing
		Set fileSysObject = Nothing

		Load = strValue
	end function

end class
%>