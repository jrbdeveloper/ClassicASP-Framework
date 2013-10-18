<%
class Menu
	
	private m_L_template
	private m_T_template

	'Constructer
	private Sub Class_Initialize()
		m_T_template = "Modules/Menu/Template/top.template.tpl"
		m_L_template = "Modules/Menu/Template/left.template.tpl"
	end sub

	'Destructer
	private Sub Class_Terminate()
	end sub

	public function Load(menuLocation)
		if lcase(menuLocation) = "top" then
			Load = getTemplate(m_T_template)
		elseif lcase(menuLocation) = "left" then
			Load = getTemplate(m_L_template)
		end if		
	end function

	private function getTemplate(menuFile)
		Dim strValue

		Dim fileSysObject : Set fileSysObject = Server.CreateObject("Scripting.FileSystemObject")

		if fileSysObject.FileExists(Server.MapPath(menuFile)) then
			Dim file : Set file = fileSysObject.OpenTextFile(Server.MapPath(menuFile), 1)

			do while file.AtEndOfStream = false
				strValue = strValue & file.ReadLine & vbCrLF
			loop

			file.Close
			Set file = Nothing
			Set fileSysObject = Nothing
		else
			strValue = DisplayMessagePanel("The file: " & pageFile & " does not exists.")
		end if

		getTemplate = strValue
	end function

	' Method to display a MessagePanel object
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