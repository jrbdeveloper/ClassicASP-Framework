<!-- #include file="contract.class.asp" -->
<!-- #include file="license.class.asp" -->
<%
class Software

	private m_recordKey
	private m_ProductName
	private m_Version
	private m_PurchaseDate
	private m_ExpirationDate
	private m_PurchaseMethod
	private m_License
	private m_Contract
	private m_InstalledOnCSHIP
	private m_template

	public property get RecordKey()
		RecordKey = m_recordKey
	end property

	public property let RecordKey(byref value)
		m_recordKey = value
	end property

	public property get ProductName()
		ProductName = m_ProductName
	end property

	public property let ProductName(byref value)
		m_ProductName = value
	end property

	public property get Version()
		Version = m_Version
	end property

	public property let Version(byref value)
		m_Version = value
	end property

	public property get PurchaseDate()
		PurchaseDate = m_PurchaseDate
	end property

	public property let PurchaseDate(byref value)
		m_PurchaseDate = value
	end property

	public property get ExpirationDate()
		ExpirationDate = m_ExpirationDate
	end property

	public property let ExpirationDate(byref value)
		m_ExpirationDate = value
	end property

	public property get PurchaseMethod()
		PurchaseMethod = m_PurchaseMethod
	end property

	public property let PurchaseMethod(byref value)
		m_PurchaseMethod = value
	end property

	public property get License()
		set License = m_License
	end property

	public property let License(byref value)
		set m_License = value
	end property

	public property get Contract()
		set Contract = m_Contract
	end property

	public property let Contract(byref value)
		set m_Contract = value
	end property

	'Constructer
	private Sub Class_Initialize()
		m_template = "Modules/SoftwareTracker/Templates/software.template.tpl"
		set m_License = new SoftwareLicense
		set m_Contract = new SoftwareContract
	end sub

	'Destructer
	private Sub Class_Terminate()
		set m_License = nothing
		set m_Contract = nothing
	end sub

	public function Load(id)
		Dim strValue

		Dim fileSysObject : Set fileSysObject = Server.CreateObject("Scripting.FileSystemObject")
		Dim file : Set file = fileSysObject.OpenTextFile(Server.MapPath(m_template), 1)
		
		do while file.AtEndOfStream = false
			strValue = strValue & file.ReadLine & vbCrLF
		loop

		strValue = PopulateTemplate(strValue)

		file.Close
		Set file = Nothing
		Set fileSysObject = Nothing

		Load = strValue
	end function

	public function Save(id)
		Dim objData : set objData = new DataObject
		objData.Properties = objData.GetFormValues()
		objData.SaveTo "Personnel", id
		set objData = nothing
		response.Redirect "?obj=software&task=load"
	end function

	public function Delete(id)
	end function

	' Method called the get by criteria method and populates the template with data
	'
	' Return: String
	private function PopulateTemplate(strCurrentLine)
		GetByCriteria "", "OR"

		strCurrentLine = replace(strCurrentLine,"{recordKey}",request.QueryString("param"))
		strCurrentLine = replace(strCurrentLine,"{productName}",m_ProductName)
		strCurrentLine = replace(strCurrentLine,"{productVersion}",m_Version)
		strCurrentLine = replace(strCurrentLine,"{purchaseDate}",m_PurchaseDate)
		strCurrentLine = replace(strCurrentLine,"{expirationDate}",m_ExpirationDate)
		strCurrentLine = replace(strCurrentLine,"{purchaseMethod}",m_PurchaseMethod)
		strCurrentLine = replace(strCurrentLine,"{installedOnCSHIP}",m_InstalledOnCSHIP)
		strCurrentLine = replace(strCurrentLine,"{contract}",Contract.Load())
		strCurrentLine = replace(strCurrentLine,"{license}",License.Load())
		
		PopulateTemplate = strCurrentLine
	end function

	' Method populates this object properties based on the variables in the querystring or a form or hard coded
	' This method includes more functionality than it should; for testing purposes
	'
	' Return: void
	private function GetByCriteria(getOption, operator)
		Dim objData : set objData = new DataObject

		if getOption = lcase("querystring") then
			objData.Properties = objData.GetQueryStringValues()
		elseif getOption = lcase("form") then
			objData.Properties = objData.GetFormValues()
		else
			objData.Properties.Add "email","john.e.atkinson@dweb.com"
			objData.Properties.Add "phone","(800)555-1212"
			objData.Properties.Add "personnel_id","052PA27V-VGWE-VOV1-HDJT-4SL3FZXLMHA2"
		end if

		if operator = "AND" then
			objData.FilterOperator = "AND"
		else
			objData.FilterOperator = "OR"
		end if

		objData.GetFrom("Personnel")

		m_ProductName	= objData.Properties.Item("Email")
		m_Version		= objData.Properties.Item("Phone")
		m_PurchaseDate	= objData.Properties.Item("Title")
		m_ExpirationDate = objData.Properties.Item("Investigation")
		m_PurchaseMethod = objData.Properties.Item("Clearance")
		m_InstalledOnCSHIP = objData.Properties.Item("Active")

		set objData = nothing
	end function

end class
%>