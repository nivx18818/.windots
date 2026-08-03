import 'imports/images.nss'
import 'imports/theme.nss'
import 'imports/modify.nss'
import 'imports/terminal.nss'
import 'imports/goto.nss'
import 'imports/file-manage.nss'
import 'imports/develop.nss'
import 'imports/taskbar.nss'

/* Global variables */
$tip_run_admin = ["\xE1A7 Press SHIFT key to run " + this.title + " as administrator", tip.warning, 1.0]
$has_admin = key.shift() || key.rbutton()

// Menus
$file_manage_menu = "File manage"
$pin_upin_menu = "Pin/Unpin"

// Colors
$windows_blue = #4cc2ff

settings {
  showdelay = 0

  exclude {
    where = !process.is_explorer
  }

  tip {
    enabled = true
  }
}

menu(mode="multiple" title=pin_unpin_menu image=icon.pin) {
}

menu(mode="multiple" title=title.more_options image=icon.more_options) {
}
