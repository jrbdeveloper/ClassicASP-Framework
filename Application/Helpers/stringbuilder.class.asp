<%
Class StringBuilder
	Dim arr 	'the array of strings to concatenate
	Dim growthRate  'the rate at which the array grows
	Dim itemCount   'the number of items in the array

	Private Sub Class_Initialize()
		growthRate = 100
		itemCount = 0
		ReDim arr(growthRate)
	End Sub

	Public Sub Append(ByVal strValue)
		If itemCount > UBound(arr) Then
			ReDim Preserve arr(UBound(arr) + growthRate)
		End If
		arr(itemCount) = strValue
		itemCount = itemCount + 1
	End Sub
	
	Public Sub Remove()
		ReDim arr(100)
	End Sub

	Public Function ToString() 
		ToString = Join(arr, "")
	End Function
End Class
%>