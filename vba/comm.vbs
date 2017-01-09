Public Function j_sqlstr(str, btrim As Boolean)
    If btrim = False Then
        j_sqlstr = "'" & str & "'"
    Else
        j_sqlstr = "'" & Trim(str) & "'"
    End If
End Function


Public Function insert_sql(tbname As String, btrim As Boolean, ParamArray col())
'
'µ÷ÓÃ =insert_sql("taname",true,$B$2:$E$2,$B$3:$E$3,$C3:$E3)
'
'
   insert_sql = "insert into " & Trim(tbname) & " ("
    str_tmp = ""
    col_names = col(0)
    col_types = col(1)
    col_vals = col(2)
       
    Dim col_nums, i As Integer
    i = 0
    col_nums = 0

    For Each col_name In col_names
        If Trim(col_name) = "" Then
            str_tmp = str_tmp
        Else
            str_tmp = str_tmp & "," & Trim(col_name)
        End If
        col_nums = col_nums + 1
    Next
    str_tmp = str_tmp & ") values ("
    
    insert_sql = insert_sql & Mid(str_tmp, 2)
    str_tmp = ""
    
    Dim Arr() As String
    ReDim Arr(col_nums + 1)
    
    For Each col_type In col_types
        Arr(i) = Trim(col_type)
        i = i + 1
    Next
    
    i = 0
    For Each col_val In col_vals
        If Arr(i) = "str" Then
            str_tmp = str_tmp & "," & j_sqlstr(col_val, btrim)
        ElseIf Arr(i) = "" Then
            str_tmp = str_tmp
        Else
            str_tmp = str_tmp & "," & Trim(col_val)
        End If
        i = i + 1
    Next
       
    insert_sql = insert_sql & Mid(str_tmp, 2) & ");"
End Function

