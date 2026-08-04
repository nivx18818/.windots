# CachyOS setup

## Dual-booting with Windows

> [!NOTE]
>
> This guide assumes that you already have your Windows installed on your PC and the BIOS mode is UEFI.

> [!INFO]
>
> Reference: https://www.youtube.com/watch?v=8WVk2ntV9Mo

Make a room for your CachyOS using Windows's Disk Management.

Go to [CachyOS's Download page](https://cachyos.org/download/), download the Desktop Edition with from Direct source. You will get an ISO file from this step.

Download [Rufus](https://rufus.ie/en/#download) (portable version is supported).

Connect your USB to your PC (make sure to cleanup your USB first).

Open Rufus:
- Device: Choose your USB.
- Boot selection, choose the ISO file you've downloaded.
- Partition scheme: GPT.
- Target system: UEFI (non CSM).
- Leave the rest as is, click Start, then spam the OK button.
- Once done, you're ready to dual-boot.

*..to be continued..*

## Bootstrap

Run `bootstrap.sh` for app installation and config setup.

```bash
chmod +x linux/bootstrap.sh
linux/bootstrap.sh
```
