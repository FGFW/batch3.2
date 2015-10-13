@Echo Off
:: Batch-CN Dels
::     2014-11-15
SetLocal EnableDelayedExpansion
For /F "Skip=1 Tokens=2,3 Delims=#" %%i In ('Reg Query HKLM\SOFTWARE\Batch-CN /v ProgramPath') Do (
	Set Desktop=%%i
	Set ProgramPath=%%j
)
If "%~1"=="" (
	For %%i In (
		";"
		";打印本地列表或删除一个第三方等"
		";"
		";Dels tool             获取本地第三方列表"
		";Dels soft iBAT        卸载iBAT"
		";Dels exmalpe          获取本地示例代码/帮助列表"
		";Dels update           获取本地可选更新列表"
	) Do Echo%%~i
	Goto :Eof
)
Call :%~1 %2
If Not "%~2"=="" Echo 删除完毕!
EndLocal
Goto :Eof
:tool
If "%~1"=="" (
	For %%i In ("%ProgramPath%Data\Tools\*.exe") Do Echo %%~nxi
) Else (
	Del "%ProgramPath%Data\Tools\%~1.exe"
)
Goto :Eof
:example
If "%~1"=="" (
	For %%i In ("%ProgramPath%Data\Examples\*") Do Echo %%~nxi
) Else (
	Rd /S /Q "%ProgramPath%Data\Examples\%~1"
)
Goto :Eof
:soft
If "%~1"=="" (
	For /D %%i In ("%ProgramPath%Data\Softs\*") Do Echo %%~nxi
) Else (
	Rd /S /Q "%ProgramPath%Data\Softs\%~1"
	Del "%UserProfile%\%Desktop%\%~1.lnk"
)
Goto :Eof