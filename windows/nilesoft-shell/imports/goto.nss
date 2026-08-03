menu(type='*' where=sel.count mode=mode.multiple title=title.go_to sep=sep.both image=\uE14A) {
  $folder_icon = \uE1F4

  item(title='Windows' image=folder_icon cmd=sys.dir)
  item(title='System' image=folder_icon cmd=sys.bin)
  item(title='Program Files' image=folder_icon cmd=sys.prog)
  item(title='Program Files x86' image=folder_icon cmd=sys.prog32)
  item(title='ProgramData' image=folder_icon cmd=sys.programdata)
  item(title='Applications' image=folder_icon cmd='shell:appsfolder')
  item(title='Users' image=folder_icon cmd=sys.users)

  separator

  //item(title='@user.name@@@sys.name' vis=label)
  item(title='Desktop' image=folder_icon cmd=user.desktop)
  item(title='Downloads' image=folder_icon cmd=user.downloads)
  item(title='Pictures' image=folder_icon cmd=user.pictures)
  item(title='Documents' image=folder_icon cmd=user.documents)
  item(title='Startmenu' image=folder_icon cmd=user.startmenu)
  item(title='Profile' image=folder_icon cmd=user.dir)
  item(title='AppData' image=folder_icon cmd=user.appdata)
  item(title='Temp' image=folder_icon cmd=user.temp)
}
