# Plymouth Themes

- Official docs: https://www.freedesktop.org/wiki/Software/Plymouth/Scripts/
- Reference: https://github.com/adi1090x/plymouth-themes/blob/master/template/template.script

## Set theme

```bash
sudo plymouth-set-default-theme -R <theme_name>
```

## Combine 2 themes

You can follow this template (read docs for further customization):

```txt
# combine.plymouth

[Plymouth Theme]
Name=Combine
Description=Combined theme
ModuleName=script

[script]
ImageDir=/usr/share/plymouth/themes/combine/frames
ScriptFile=/usr/share/plymouth/themes/combine/combine.script
```

```txt
# combine.script

mode = Plymouth.GetMode();

if (mode == "shutdown") {
    # On-shutdown animation
} else {
    # On-boot animation
}
```
