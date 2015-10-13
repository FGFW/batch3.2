@Echo Off
For /F "Skip=1 Tokens=3 Delims=#" %%i In ('Reg Query HKLM\SOFTWARE\Batch-CN /v ProgramPath') Do Set ProgramPath=%%i
Doskey /MacroFile="%ProgramPath%Data\Keyword-Base.dic"
Path %ProgramPath%Data;%ProgramPath%Data\Tools;%Path%
Cd /D %ProgramPath%
Echo 检测更新中......
Call Gets.bat "update" "ver"
Cls
Title Batch-CN
Echo aiwozhonghuaba Batch-CN [版本 3.2]
Prompt Batch-CN $P$G