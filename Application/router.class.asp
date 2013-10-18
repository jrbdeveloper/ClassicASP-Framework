<%
class Router

	private m_object
	private m_method
	private m_parameter

	public property get Object()
		Object = request.QueryString("obj")
	end property

	public property let Object(byref value)
		m_object = value
	end property

	public property get Method()
		Method = request.QueryString("task")
	end property

	public property let Method(byref value)
		m_method = value
	end property

	public property get Parameter()
		Parameter = request.QueryString("param")
	end property

	public property let Parameter(byref value)
		m_parameter = value
	end property

	private Sub Class_Initialize()
	end sub

	private Sub Class_Terminate()
	end sub

	public function Route(obj, task, param)
		Dim m_obj : m_obj = obj
		Dim m_param : m_param = param

		Dim object
		Dim retValue

		if m_obj <> "" then
			Execute "set object = new " & m_obj
		end if
		
		Execute "retValue = object." & task & "(" & m_param & ")"

		Route = retValue

	end function

end class
%>