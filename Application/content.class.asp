<%
class Content

	'Constructer
	private Sub Class_Initialize()
	end sub

	'Destructer
	private Sub Class_Terminate()
	end sub

	' Method to either load content from a "Page" file or by using the router to load content from an object
	'
	' Access: Public
	' Param: String
	' Return: String
	public function Load(pageFile)
		' If the pageFile param is empty use the router
		if pageFile = "" then
			Dim objRouter : Set objRouter = new Router
			
			Dim obj : obj = request.QueryString("obj")
			Dim task : task = request.QueryString("task")
			Dim param : param = request.QueryString("param")

			if IsEmpty(obj) then
			end if

			if IsEmpty(task) then
			end if

			if IsEmpty(param) or IsNull(param) then
				param = -1
			end if

			Load = objRouter.Route(obj, task, param)
		else ' The pageFile is not empty, load content from the pages folder

			Load = getPageContent(pageFile)
		end if
	end function

	' Method loads the content of a file located in the Pages folder
	'
	' Access: Private
	' Param: String
	' Return: String
	private function getPageContent(pageFile)
		Dim strValue
		Dim fileSysObject : Set fileSysObject = Server.CreateObject("Scripting.FileSystemObject")
		
		if fileSysObject.FileExists(Server.MapPath("Pages/"& pageFile &".html")) then
			Dim file : Set file = fileSysObject.OpenTextFile(Server.MapPath("Pages/"& pageFile &".html"), 1)
		
			do while file.AtEndOfStream = false
				strValue = strValue & file.ReadLine & vbCrLF
			loop

			file.Close
			Set file = Nothing
			Set fileSysObject = Nothing
		else
			strValue = DisplayMessagePanel("The file: <b><em>" & pageFile & "</em></b> does not exists.")
		end if

		getPageContent = strValue
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