#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Change2CUI=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; This example will "connect together" all INI sections into one ANSI encoding file

#include "_INI_memory.a3x"

If $CmdLine[0] < 3 Then
	ConsoleWrite("It needs minimum three parameters: " & @CRLF)
	ConsoleWrite('"output file.ini" "full path to the 1st.ini" "full path to the 2nd.ini" etc...' & @CRLF & @CRLF)
	ConsoleWrite("You've provided only these parameters:" & @CRLF)
	For $w = 1 To $CmdLine[0]
		ConsoleWrite('"' & $CmdLine[$w] & '" ')
	Next
	ConsoleWrite(@CRLF & @CRLF)
	Exit -1
EndIf
If FileExists( $CmdLine[1] ) Then
	ConsoleWrite('The file "' & $CmdLine[1] & '" exists...' & @CRLF)
	ConsoleWrite('please delete the above mentioned file manually, and run me again' & @CRLF)
	Exit 1
EndIf

$INI_memory = _IniCreateInMemory()
; the '?' below, can be one of: 0, 1, 2, 3
;$INI_memory = _IniSetEncoding( $INI_memory, ? )

For $w = 2 To $CmdLine[0]
	ConsoleWrite("-> Processing file: " & $CmdLine[$w] & @CRLF)
	Local $tmp_ini_memory = _IniLoadToMemory($CmdLine[$w])
	If @error Then ContinueLoop
	Local $ini_sections_names = _IniEnumSections($tmp_ini_memory)
	For $x = 0 To UBound($INI_sections_names)-1
		Local $ini_section = _IniGetSection($tmp_ini_memory, $INI_sections_names[$x])
		; skip empty section
		If UBound( _IniInternalEnumSectionKeys($ini_section) ) < 1 Then ContinueLoop
		ConsoleWrite("+[" & $ini_sections_names[$x] & "]" & @CRLF)
		$INI_memory = _IniAddSection( $INI_memory, $ini_sections_names[$x], $ini_section )
	Next
Next

ConsoleWrite('Saving the "INI memory" to a file: "' & $CmdLine[1] & '"' & @CRLF)
_IniMemorySaveToFile($INI_memory, $CmdLine[1])

Exit @error
