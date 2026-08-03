menu(mode=mode.multiple title='&Develop' vis=key.shift() sep=sep.bottom image=\uE26E) {
  item(title='Visual Studio Code' image=\uE272 cmd='code' args='"@sel.path"')
  separator
  item(type='file' mode=mode.single title='Notepad' image=\uE113 cmd='@sys.bin\notepad.exe' args='"@sel.path"')
}
