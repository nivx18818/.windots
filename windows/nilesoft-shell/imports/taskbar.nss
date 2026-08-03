menu(type='taskbar' vis=key.shift() or key.lbutton() pos=0 title=app.name image=\uE249) {
  item(title='config' image=\uE10A cmd='"@app.cfg"')
  item(title='manager' image=\uE0F3 admin cmd='"@app.exe"')
  item(title='directory' image=\uE0E8 cmd='"@app.dir"')
  item(title='version\t'+@app.ver vis=label col=1)
  item(title='docs' image=\uE1C4 cmd='https://nilesoft.org/docs')
  item(title='donate' image=\uE1A7 cmd='https://nilesoft.org/donate')
}

menu(where=@(this.count == 0) type='taskbar' image=icon.settings expanded=true) {
  item(
    where=package.exists('WindowsTerminal')
    title='Terminal'
    tip=tip_run_admin
    admin=has_admin
    image=icon.run_with_powershell
    cmd='wt.exe'
    arg='-d "@sel.path\."'
  )
  item(title=title.settings sep='both' image=icon.settings(auto, image.color1) cmd='ms-settings:')
  item(title=title.task_manager sep='both' image=icon.task_manager cmd='taskmgr.exe')
  item(title=title.control_panel sep='before' image=inherit cmd='control.exe')
  item(title=title.taskbar_Settings sep='after' image=inherit cmd='ms-settings:taskbar')
  item(vis=key.shift() title='Restart Explorer' cmd=command.restart_explorer)
}
