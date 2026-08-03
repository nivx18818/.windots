modify(
  mode=mode.multiple
  where=(
    this.id(
      id.cast_to_device,
      id.disconnect_network_drive,
      id.give_access_to,
      id.map_network_drive,
      id.print,
      id.restore_previous_versions,
      id.send_to,
      id.share
    ) ||
    regex.match(this.name, '(edit (with|in)|(create|play) with|add to).*') ||
    str.equals(
      this.name,
      ['mediainfo', 'open in terminal', 'open linux shell here']
    )
  )
  vis=vis.remove
)

modify(
  type='recyclebin'
  where=(window.is_desktop && this.id == id.empty_recycle_bin)
  pos=1
  sep
)

modify(
  find='pin*'
  pos='top'
  menu=pin_unpin_menu
)

modify(
  find='unpin*'
  pos='bottom'
  menu=pin_unpin_menu
)

modify(
  where=(this.id == id.copy_as_path)
  menu=file_manage_menu
)

modify(
  type='dir.back|drive.back'
  where=(this.id == id.customize_this_folder)
  pos=1
  sep='top'
  menu=file_manage_menu
)

modify(
  mode=mode.multiple
  where=this.id(
    id.copy,
    id.create_shortcut,
    id.cut,
    id.eject,
    id.format,
    id.include_in_library,
    id.rename,
    id.rotate_left,
    id.rotate_right,
    id.set_as_desktop_background
  )
  pos=1
  menu=title.more_options
)
