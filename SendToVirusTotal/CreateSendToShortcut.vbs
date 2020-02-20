name = Wscript.Arguments(0)
targetPath = Wscript.Arguments(1)
iconLocation = Wscript.Arguments(2)
workingDirectory = Wscript.Arguments(3)

Set wshShell = WScript.CreateObject("WScript.Shell")
Set shortCut = wshShell.CreateShortcut(wshShell.SpecialFolders("SendTo") + "\" + name + ".lnk")
shortcut.WindowStyle = 1 
shortcut.IconLocation = iconLocation
shortcut.TargetPath = targetPath
shortcut.WorkingDirectory = workingDirectory
shortCut.Save