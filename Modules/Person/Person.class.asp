<%
'Person Class
class Person

	' Member variables
	private m_FirstName
	private m_LastName
	private m_address
	private m_account
	private m_phone

	private m_arrPeople
	private m_template

	' Properties
	public property get Address()
		set Address = m_address
	end property

	public property let Address(byref value)
		set m_address = value
	end property

	public property get Account()
		set Account = m_account
	end property

	public property let Account(byref value)
		set m_account = value
	end property

	public property get Phone()
		set Phone = m_phone
	end property

	public property let Phone(byref value)
		set m_phone = value
	end property

	public property get FirstName()
		FirstName = m_FirstName
	end property

	public property let FirstName(byref value)
		m_FirstName = value
	end property
	
	public property get LastName()
		LastName = m_LastName
	end property

	public property let LastName(byref value)
		m_LastName = value
	end property
	
	'Constructer
	private Sub Class_Initialize()
		m_template = "Modules/Person/Templates/person.template.tpl"

		set m_address = new MailingAddress
		set m_account = new UserAccount
		set m_phone = new PhoneNumber
	end sub

	'Destructer
	private Sub Class_Terminate()
		set m_address = nothing
		set m_account = nothing
		set m_phone = nothing
	end sub

	public function Load(person)
		Dim strValue

		Set fileSysObject = Server.CreateObject("Scripting.FileSystemObject")
		Set file = fileSysObject.OpenTextFile(Server.MapPath(m_template), 1)

		do while file.AtEndOfStream = false
			strValue = strValue & file.ReadLine & vbCrLF
		loop

		strValue = replace(strValue,"{firstname}",person.FirstName)
		strValue = replace(strValue,"{lastname}",person.LastName)
		strValue = replace(strValue,"{address}",person.Address.Load())
		strValue = replace(strValue,"{account}",person.Account.Load())
		strValue = replace(strValue,"{phone}",person.Phone.Load())

		file.Close
		Set file = Nothing
		Set fileSysObject = Nothing

		Load = strValue
	end function

	public function Display(id)
		Dim retValue
		GetByCriteria(id)

		For count = 0 to Ubound(m_arrPeople)
			retValue = retValue & Load(m_arrPeople(count))
		next

		Display = retValue
	end function
	
	private function GetByCriteria(id)
		Dim person1 : set person1 = new Person
		person1.FirstName = "John"
		person1.LastName = "Bales"

		Dim person2 : set person2 = new Person
		person2.FirstName = "Bob"
		person2.LastName = "Caroll"

		m_arrPeople = array(person1, person2)
	end function

end class
%>