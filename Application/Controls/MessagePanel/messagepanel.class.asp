<%
class MessagePanel
	private m_template

	'Constructer
	private Sub Class_Initialize()
		m_template = "Application/Controls/MessagePanel/Templates/messagepanel.template.tpl"
	end sub

	'Destructer
	private Sub Class_Terminate()
	end sub

	public function Load(messageText)
		Dim strValue

		Dim fileSysObject : Set fileSysObject = Server.CreateObject("Scripting.FileSystemObject")
		
		if fileSysObject.FileExists(Server.MapPath(m_template)) then
			Dim file : Set file = fileSysObject.OpenTextFile(Server.MapPath(m_template), 1)

			do while file.AtEndOfStream = false
				strValue = strValue & file.ReadLine & vbCrLF
			loop

			strValue = replace(strValue,"{MessageText}",messageText)

			file.Close
			Set file = Nothing
			Set fileSysObject = Nothing
		else
			strValue = DisplayMessagePanel("The file: " & pageFile & " does not exists.")
		end if

		Load = strValue
	end function

	' Method loads the content of a file located in the Pages folder
	'
	' Access: Private
	' Param: String
	' Return: String
	private function DisplayMessagePanel(strMessage)
		Dim objPanel : set objPanel = new MessagePanel
		DisplayMessagePanel = objPanel.load(strMessage)
		set objPanel = nothing
	end function

end class
%>