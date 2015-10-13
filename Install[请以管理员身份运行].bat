@Echo Off
Title Batch-CN 安装/卸载程序
Echo Test>>"%SystemRoot%\System32\Test.bat"
If Not Exist "%SystemRoot%\System32\Test.bat" (
	Echo 请以管理员身份运行!
	Pause
	Exit
)
Del "%SystemRoot%\System32\Test.bat">nul
SetLocal EnableDelayedExpansion
Set Desktop=Desktop
Set Pat=%~dp0
Ver|findstr "5\.[1-9]\.[1-9]*"&&(
	Set Desktop=桌面
	Set Pat=%CD%\
)
:Menu
Echo 请选择任务:
Echo;
Echo N - 普通安装     安装后创建一个桌面快捷方式,通过快捷方式进入Batch-CN
Echo E - 嵌入式安装   安装后嵌入到cmd当中,可以在cmd中运行Batch-CN命令
Echo U - 卸载         删除Batch-CN的注册表项与环境变量,之后可以直接删除Batch-CN目录
Echo;
Echo   注:默认安装在当前目录!
Echo;
Set /P Choice=请选择:
If /I "%Choice%"=="N" Goto Normal
If /I "%Choice%"=="E" Goto Normal
If /I "%Choice%"=="U" Goto Uninstall
Cls
Goto Menu
:Normal
Reg Add HKLM\SOFTWARE\Batch-CN /f
Reg Add HKLM\SOFTWARE\Batch-CN /v "Version" /t REG_SZ /d "3.2" /f
Reg Add HKLM\SOFTWARE\Batch-CN /v "ProgramPath" /t REG_SZ /d "#%Desktop%#%Pat%#" /f
If /I "%Choice%"=="E" (
	Reg Add "HKLM\SOFTWARE\Microsoft\Command Processor" /v "AutoRun" /t REG_SZ /d "Doskey /MacroFile=\"%Pat%Data\Keyword-Base.dic\"&Path %Pat%Data;%Pat%Data\Tools;%%Path%%" /f
) Else (
	"%Pat%Data\Tools\ShortCut.exe" /F:"%UserProFile%\%Desktop%\Batch-CN.lnk" /A:C /T:"cmd.exe" /P:"/K \"%Pat%Batch-CN.bat\"" /I:"cmd.exe"
)
Echo 安装完成！
Goto End
:Uninstall
Reg Delete HKLM\SOFTWARE\Batch-CN /f 2>nul
Reg Delete "HKLM\SOFTWARE\Microsoft\Command Processor" /v "AutoRun" /f 2>nul
Del "%UserProFile%\%Desktop%\Batch-CN.lnk" 2>nul
Echo 卸载完成！
:End
Echo 任意键退出...
Pause>nul