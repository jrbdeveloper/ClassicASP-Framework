<%
Class SoftwareLicense
	
	private m_Cost
	private m_Terms
	private m_Type
	private m_Key
	private m_Count
	private m_MaintainedBy
	private m_template

	public property get Cost()
		Cost = m_Cost
	end property

	public property let Cost(byref value)
		m_Cost = value
	end property

	public property get Terms()
		Terms = m_Terms
	end property

	public property let Terms(byref value)
		m_Terms = value
	end property

	public property get LicenseType()
		LicenseType = m_Type
	end property

	public property let LicenseType(byref value)
		m_Type = value
	end property

	public property get Key()
		Key = m_Key
	end property

	public property let Key(byref value)
		m_Key = value
	end property

	public property get Count()
		Count = m_Count
	end property

	public property let Count(byref value)
		m_Count = value
	end property

	public property get MaintainedBy()
		MaintainedBy = m_MaintainedBy
	end property

	public property let MaintainedBy(byref value)
		m_MaintainedBy = value
	end property

	'Constructer
	private Sub Class_Initialize()
		m_template = "Modules/SoftwareTracker/Templates/license.template.tpl"
	end sub

	'Destructer
	private Sub Class_Terminate()
	end sub

	public function Load()
		Dim strValue

		Dim fileSysObject : Set fileSysObject = Server.CreateObject("Scripting.FileSystemObject")
		Dim file : Set file = fileSysObject.OpenTextFile(Server.MapPath(m_template), 1)

		do while file.AtEndOfStream = false
			strValue = strValue & file.ReadLine & vbCrLF
			strValue = PopulateTemplate(strValue)
		loop

		file.Close
		Set file = Nothing
		Set fileSysObject = Nothing

		Load = strValue
	end function

	private function PopulateTemplate(strCurrentLine)
		strCurrentLine = replace(strCurrentLine,"{licenseCost}",m_Cost)
		strCurrentLine = replace(strCurrentLine,"{licenseTerms}",m_Terms)
		strCurrentLine = replace(strCurrentLine,"{licenseKey}",m_Key)
		strCurrentLine = replace(strCurrentLine,"{licenseCount}",m_Count)
		strCurrentLine = replace(strCurrentLine,"{maintainedBy}",m_MaintainedBy)

		PopulateTemplate = strCurrentLine
	end function
end Class
%>