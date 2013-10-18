<%
Const TEMPLATES_PATH = "Modules/Page/Templates/"

class Page

	'::::::::::::::::::::::::::::::
	' Member Variables
	'::::::::::::::::::::::::::::::
	private m_nav
	private m_pageTitle
	private m_pageContent
	private m_fileSystemObject

	'::::::::::::::::::::::::::::::
	' Properties
	'::::::::::::::::::::::::::::::
	public property get Navigation()
		set Navigation = m_nav
	end property

	public property let Navigation(byref value)
		set m_nav = value
	end property

	public property get PageContent()
		set PageContent = m_pageContent
	end property

	public property let PageContent(byref value)
		set m_pageContent = value
	end property

	public property get Title()
		Title = m_pageTitle
	end property

	public property let Title(byref value)
		m_pageTitle = value
	end property
	
	private property get FileSystemObject()
		set FileSystemObject = m_fileSystemObject
	end property

	private property let FileSystemObject(byref value)
		set m_fileSystemObject = value
	end property
	 
	'Constructer
	private Sub Class_Initialize()
		set m_nav = new Menu
		set m_pageContent = new Content
		
		set m_fileSystemObject = Server.CreateObject("Scripting.FileSystemObject")
	end sub

	'Destructer
	private Sub Class_Terminate()
		set m_fileSystemObject = nothing
	end sub

	'::::::::::::::::::::::::::::::
	' Public Functions
	'::::::::::::::::::::::::::::::
	public function Load(template, pageFile)
		Dim strValue
		
		Dim file : Set file = FileSystemObject.OpenTextFile(Server.MapPath(TEMPLATES_PATH & template & ".template.tpl"), 1)

		do while file.AtEndOfStream = false
			strValue = strValue & file.ReadLine & vbCrLF
		loop

		strValue = replace(strValue,"{title}",m_pageTitle)
		strValue = replace(strValue,"{header}",LoadPageSection("header"))
		strValue = replace(strValue,"{topmenu}",Navigation.Load("top"))
		strValue = replace(strValue,"{leftmenu}",Navigation.Load("left"))
		strValue = replace(strValue,"{content}",PageContent.Load(pageFile))
		strValue = replace(strValue,"{footer}",LoadPageSection("footer"))

		file.Close
		Set file = Nothing

		Load = strValue
	end function

	'::::::::::::::::::::::::::::::
	' Private Functions
	'::::::::::::::::::::::::::::::
	private function LoadPageSection(strSection)
		Dim strValue
		Dim file
		
		if(strSection = lcase("header")) then
			Set file = FileSystemObject.OpenTextFile(Server.MapPath(TEMPLATES_PATH & "header.template.tpl"), 1)
		elseif (strSection = lcase("footer")) then
			Set file = FileSystemObject.OpenTextFile(Server.MapPath(TEMPLATES_PATH & "footer.template.tpl"), 1)
		end if

		do while file.AtEndOfStream = false
			strValue = strValue & file.ReadLine & vbCrLF
		loop

		file.Close
		Set file = Nothing

		loadPageSection = strValue
	end function

end class
%>