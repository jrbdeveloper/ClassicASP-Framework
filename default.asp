<% Option Explicit %>
<!-- #include file="Application/include.libraries.asp" -->
<%
' Create a Database object to be used by the application and open the connection to the paticular Database
	Dim objDatabase : set objDatabase = new Database
	objDatabase.Open "lbautista_Ritpo_AssetMgmt",1

' Get the requested template, if none is requested set a default to use
	Dim template
	if IsEmpty(request.QueryString("template")) then
		template = "main" ' Set a default
	else
		template = request.QueryString("template")
	end if

' Get the requested page file, if none is requested set a default value of empty
	Dim pagefile 
	if IsEmpty(request.QueryString("page")) then
		pagefile = ""
	else
		pagefile = request.QueryString("page")
	end if

' Create a Page object and call the load method passing it the templte to load and the page file (if one is requested)
	Dim objPage : Set objPage = new Page
	response.Write objPage.Load(template, pagefile)

' Destroy objects created
	set objDatabase = nothing
	set objPage = nothing
%>