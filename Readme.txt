3.2
  取消了永久环境变量修改,不用注销系统就能用!
  增加了嵌入式安装(强烈推荐)
  增加了"大小"列
  解决了启动时出现两个cmd.exe的问题
  增加了Get-Update Notice,可以查看作者公告
  由于启动方式更改,旧版请卸载后重新安装一次

Batch-CN 3.2 帮助:

Get-Tool [ToolName]
描述:该命令从互联网上获取相应第三方,单独键入该命令获得在线第三方列表
别名:GT
示例:Get-Tool sed

Get-Example [ExampleName]
描述:该命令从互联网上获取相应第三方的教程或示例代码等,单独键入该命令获得在线示例代码等列表
别名:GE
示例:Get-Example conset

Get-Soft [SoftName]
描述:该命令从互联网上获取相应软件,单独键入该命令获得在线软件列表
别名:GS
示例:Get-Soft iBAT

Get-Update [Ver | Update |Notice]
描述:该命令检查更新,单独键入该命令获得可选更新列表
别名:GU
示例:Get-Update Ver

Del-Tool [TooName]
描述:该命令将一个第三方从目录里删除,单独键入该命令获得本地第三方列表
别名:DT
示例:DT sed

Del-Soft [SoftName]
描述:该命令将卸载一个通过Batch-CN安装的软件,单独键入该命令获得本地软件列表
别名:DS
示例:DS iBAT

Del-Example [Example]
描述:该命令删除一个示例代码等,,单独键入该命令获得本地示例代码等列表
别名:DE
示例:DE conset

Find-Tool [Keyword]
描述:该命令在第三方列表中寻找包含关键词的行并打印
别名:FT
示例:FT "注册表"

Find-Soft [Keyword]
描述:该命令在软件列表中寻找包含关键词的行并打印
别名:FS
示例:FS "搜索"

Find-Example [Keyword]
描述:该命令在示例代码列表中寻找包含关键词的行并打印
别名:FE
示例:FE "conset"

Version
描述:该命令查看Batch-CN当前版本
别名:N/A
示例:Version


你可以通过键入Gets Dels Finds来查看Gets.bat Dels.bat Finds.bat的用法,
然后就可以自己修改Keyword_base.txt来自定义功能了

PS 一部分第三方的帮助需要使用 --help -help --h -h,或键入不带参数的命令来查询
   如果安装不正常的话建议先卸载再安装