<%
class SoftwareContract
	
	private m_ContractName
	private m_Cost
	private m_Terms
	private m_FreePatches
	private m_FreeUpgrades
	private m_template

	public property get ContractName()
		ContractName = m_ContractName
	end property

	public property let ContractName(byref value)
		m_ContractName = value
	end property

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

	public property get FreePatches()
		FreePatches = m_FreePatches
	end property

	public property let FreePatches(byref value)
		m_FreePatches = value
	end property

	public property get FreeUpgrades()
		FreeUpgrades = m_FreeUpgrades
	end property

	public property let FreeUpgrades(byref value)
		m_FreeUpgrades = value
	end property

	'Constructer
	private Sub Class_Initialize()
		m_template = "Modules/SoftwareTracker/Templates/contract.template.tpl"
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
		strCurrentLine = replace(strCurrentLine,"{contractName}",m_ContractName)
		strCurrentLine = replace(strCurrentLine,"{contractCost}",m_Cost)
		strCurrentLine = replace(strCurrentLine,"{contractTerms}",m_Terms)
		'strCurrentLine = replace(strCurrentLine,"{zip}",m_zip)

		PopulateTemplate = strCurrentLine
	end function
end class
%>