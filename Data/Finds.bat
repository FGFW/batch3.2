@Echo Off
::Batch-CN Finds
::     2014-10-24
SetLocal EnableDelayedExpansion
For /F "Skip=1 Tokens=3 Delims=#" %%i In ('Reg Query HKLM\SOFTWARE\Batch-CN /v ProgramPath') Do Set ProgramPath=%%i
If "%~1"=="" (
	For %%i In (
		";"
		";在列表中搜索关键词(关键词在Get-命令下不会显示)"
		";"
		";例:"
		";Find tool 注册表      在第三方列表中搜索包含关键词"注册表"的内容"
		";Find soft 编辑        在软件列表中搜索包含关键词"编辑"的内容"
		";Find example CAPI     在示例代码/帮助列表中搜索包含关键词"CAPI"的内容"
		";Find update 第三方    在可选更新中搜索包含关键词"第三方"的内容"
	) Do Echo%%~i
	Goto :Eof
)
If "%~2"=="" (
	EndLocal
	Goto :Eof
)
If Not Exist "%ProgramPath%Data\Lists\%~1.txt" (
	wget -O "%ProgramPath%Data\Lists\%~1.txt" -q "http://batch-cn.qiniudn.com/list/%~1.txt"
)
Echo 名称          版本     大小    简介
For /F "Tokens=1,2,3,4" %%i In ('Findstr /I "%~2" "%ProgramPath%Data\Lists\%~1.txt"') Do (
	Set Str=%%i                              
	Set Str2=%%j                        
	Set Size=%%l     
	Set /A Times+=1
	Echo !Str:~0,14!!Str2:~0,9!!Size:~0,8!%%k
	If !Times!==23 (
		Pause>nul
		Set Times=
	)
)
EndLocal