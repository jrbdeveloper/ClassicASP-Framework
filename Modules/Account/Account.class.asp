<%
' User Account Class
class UserAccount

	private m_userName
	private m_password
	private m_template

	public property get UserName()
		UserName = m_userName
	end property

	public property let UserName(byref value)
		m_userName = value
	end property

	public property get Password()
		Password = m_password
	end property

	public property let Password(byref value)
		m_password = value
	end property

	'Constructer
	private Sub Class_Initialize()
		m_template = "Modules/Account/Templates/account.template.tpl"
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

		strValue = replace(strValue,"{username}",m_username)
		strValue = replace(strValue,"{password}",m_password)

		file.Close
		Set file = Nothing
		Set fileSysObject = Nothing

		Load = strValue
	end function
end class
%>