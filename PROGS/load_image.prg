Procedure load_image
	Lparameters sourceFile, finalFile
	Local fileAfterResize
	
	Wait window 'Wczytywanie pliku...' nowait  
	
	lcOldCompat = SET("COMPATIBLE")
	SET COMPATIBLE ON
	filesize = FSIZE(Alltrim(sourceFile))
	SET COMPATIBLE &lcOldCompat
	
	If InList(Upper(JustExt(sourceFile)), 'JPG', 'JPEG', 'PNG', 'BMP')	and filesize > 	256000
		fileAfterResize = JustPath(Alltrim(sourceFile)) + '\' + Alltrim(JustStem(Upper(sourceFile))) + '_1920x1176.jpg'
	
		Try 
			sCommand =  '"' + Alltrim(appPath) + '/LIBS/imgresize_windows_amd64.exe" -w 1920 -h 1176 -b 2 -f jpg ' + sourceFile 
			objShell = Createobject("WScript.Shell")
			objShell.Run(sCommand, 0, .T.)
			objShell = .Null.	
		Catch to err	
		EndTry 
		
		If File(Alltrim(fileAfterResize)) = .f.
			Try 
				sCommand =  '"' + Alltrim(appPath) + '/LIBS/imgresize_windows_386.exe" -w 1920 -h 1176 -b 2 -f jpg ' + sourceFile 
				objShell = Createobject("WScript.Shell")
				objShell.Run(sCommand, 0, .T.)
				objShell = .Null.
			Catch to err		
			EndTry 
		endif
		
		If File(Alltrim(fileAfterResize)) = .t.
			Copy File Alltrim(fileAfterResize) to Alltrim(finalFile)
			Delete File Alltrim(fileAfterResize)
		Else
			Wait window 'Nieudane zmniejszanie rozmiaru. Wczytuj� orygina�...' timeout 2
			Try 
				Copy File Alltrim(sourceFile) to Alltrim(finalFile)
			Catch to err
				MessageBox('Jest problem z wczytaniem pliku...')
			EndTry 
		EndIf 
	Else 
		Try 
			Copy File Alltrim(sourceFile) to Alltrim(finalFile)
		Catch to err
			MessageBox('Jest problem z wczytaniem pliku...')
		EndTry 
	EndIf 
	
	Wait clear 
EndProc 
