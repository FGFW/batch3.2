@Echo Off
:: Batch-CN Gets
::    2014-11-15
SetLocal EnableDelayedExpansion
For /F "Skip=1 Tokens=2,3 Delims=#" %%i In ('Reg Query HKLM\SOFTWARE\Batch-CN /v ProgramPath') Do (
	Set Desktop=%%i
	Set ProgramPath=%%j
)
If "%~1"=="" (
	For %%i In (
		";"
		";获取在线列表以及更新"
		";"
		";例:"
		";Gets update           获取可选更新列表"
		";Gets update verion       检查并更新"
		";Gets tool             获取第三方列表"
		";Gets tool sed         获取sed.exe"
		";Gets tool CAPI.rar    获取CAPI.rar"
		";Gets soft BatProject  获取BatchProject并安装"
		";Gets example CAPI     获取CAPI的示例代码/帮助"
	) Do Echo%%~i
	Goto :Eof
)
If "%~2"=="" (
	Call :list "%~1"
) Else (
	Call :%~1 "%~2"
)
EndLocal
Goto :Eof
:update
If /I "%~1"=="Ver" (
	wget -O "%ProgramPath%Data\Lists\ver.txt" -q "http://batch-cn.qiniudn.com/update/ver.txt"
	Set /P Ver=<"%ProgramPath%Data\Lists\ver.txt"
	If !Ver! Gtr 3.2 (
		Echo 更新中......
		wget -O "%ProgramPath%Data\!Ver:.=-!.rar" -q "http://batch-cn.qiniudn.com/update/!Ver:.=-!.rar"
		rar x -o+ "%ProgramPath%Data\!Ver:.=-!.rar" "%ProgramPath%" >nul 2>nul
		(For /F "Usebackq Delims=" %%i In ("%ProgramPath%Dellist.txt") Do Del "%ProgramPath%%%i"
		Del "%ProgramPath%Dellist.txt"
		)>nul 2>nul
		Start "" "%ProgramPath%Readme.txt"
		Exit
	) Else (
		Echo 当前已是最新版本
	)
) Else If /I "%~1"=="Notice" (
	wget -O "%ProgramPath%Data\Lists\notice.txt" -q "http://batch-cn.qiniudn.com/update/notice.txt"
	Type "%ProgramPath%Data\Lists\notice.txt"
) Else (
	Echo 下载中...
	wget -O "%ProgramPath%Data\%~1.rar" -q "http://batch-cn.qiniudn.com/update/%~1.rar"
	For %%i In ("%ProgramPath%Data\%~1.rar") Do (
		If %%~zi Lss 21 (
			Echo 未查找到名为%~1的可选更新
			Del "%ProgramPath%Data\%~1.rar"
		) Else (
			rar x -o+ "%ProgramPath%Data\%~1.rar" "%Temp%" >nul 2>nul
			Start "" /B /Wait "%Temp%\Install.bat"
			Echo %~1更新完成
		)
	)
)
Goto :Eof
:list
Echo;
Set List=%~1
wget -O "%ProgramPath%Data\Lists\!List!.txt" -q "http://batch-cn.qiniudn.com/list/!List!.txt"
Echo 名称          版本     大小    简介
For /F "Usebackq Tokens=1,2,3,4" %%i In ("%ProgramPath%Data\Lists\!List!.txt") Do (
	Set Str=%%i                              
	Set Str2=%%j                        
	Set Size=%%l     
	Set /A Times+=1
	If Not "%%i"=="Rem" (
		Echo !Str:~0,14!!Str2:~0,9!!Size:~0,8!%%k
	) ELSE (
		Echo %%j%%k
	)
	If !Times!==23 (
		Pause>nul
		Set Times=
	)
)
Goto :Eof
:tool
If Not "%~x1"==".rar" Set Suffix=.exe
wget -O "%ProgramPath%Data\Tools\%~nx1!Suffix!" -q "http://batch-cn.qiniudn.com/tool/%~1!Suffix!"
For %%i In ("%ProgramPath%Data\Tools\%~nx1!Suffix!") Do (
	If %%~zi Leq 21 (
		Echo 下载失败,请确认输入无误
		Del "%ProgramPath%Data\Tools\%~nx1!Suffix!"
		Goto :Eof
	) Else (
		If "%~x2"==".rar" rar x "%ProgramPath%Data\Tools\%~nx1" "%ProgramPath%Data\Softs\" >nul 2>nul
		Echo 下载成功
	)
)
Goto :Eof
:soft
Echo 下载中...
wget -O "%ProgramPath%Data\Softs\%~1.rar" -q "http://batch-cn.qiniudn.com/soft/%~1.rar"
For %%i In ("%ProgramPath%Data\Softs\%~1.rar") Do (
		If %%~zi Leq 21 (
			Echo 下载失败,请确认输入无误
			Del "%ProgramPath%Data\Softs\%~1.rar"
			Goto :Eof
		) Else (
			Echo 安装中...
			rar x "%ProgramPath%Data\Softs\%~1.rar" "%ProgramPath%Data\Softs\" >nul 2>nul
			ShortCut /F:"%UserProFile%\%Desktop%\%~1.lnk" /A:C /T:"%ProgramPath%Data\Softs\%~1\%~1.exe" /I:"%ProgramPath%Data\softs\%~1\%~1.exe",0 >nul 2>nul
			Echo 完成！
			Del "%ProgramPath%Data\Softs\%~1.rar"
		)
	)
)
Goto :Eof
:example
wget -O "%ProgramPath%Data\Examples\%~1.rar" -q "http://batch-cn.qiniudn.com/example/%~1.rar"
For %%i In ("%ProgramPath%Data\Examples\%~1.rar") Do (
	If %%~zi Leq 21 (
		Echo 下载失败,请确认输入无误
	) Else (
		rar x "%ProgramPath%Data\Examples\%~1.rar" "%ProgramPath%Data\Examples\"  >nul 2>nul
		Echo %~n2的教程已下载在%ProgramPath%Data\Examples文件夹里,请自行查看
		Del "%ProgramPath%Data\examples\%~1.rar"
	)
)
Goto :Eof