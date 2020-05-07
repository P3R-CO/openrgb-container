## ![P3R OpenRGB](https://raw.githubusercontent.com/P3R-CO/unraid/master/OpenRGB-P3R-256px.png)
## P3R OpenRGB

RGB software...  Every manufacturer has their own app, their own brand, their own style.  Most of these apps are windows only, and usually only support their own brands hardware.  OpenRGB was developed as a way to bypass this issue, and P3R took the initiative to turn the application into a container for systems operating as hyervisors.  The primary focus of this project was to give users of Unraid OS a way to edit their RGB configurations, with s little effort as necessary.

## Supported Devices

See the [Project Wiki](https://gitlab.com/CalcProgrammer1/OpenRGB/-/wikis/home) for the current list of supported devices.

## WARNING!

This project provides a tool to probe the SMBus.  This is a potentially dangerous operation if you don't know what you're doing.  Exercise caution when clicking the Detect Devices or Dump Device buttons.  There have been reports of Gigabyte motherboards having serious issues (bricking the RGB or bricking the entire board) when dumping certain devices.  On the same lines, exercise the same caution when using the i2cdump and i2cdetect commands on Linux, as they perform the same functionality.  OpenRGB is not liable for damage caused by improper SMBus access.

As of now, only Gigabyte RGB Fusion 2.0 boards have been reported to have issues.

### SMBus Access

  *  SMBus access is necessary for controlling RGB RAM and certain motherboard on-board LEDs.

  *  If you are not trying to use OpenRGB to control RGB RAM or motherboard LEDs, you may skip this section.

  *  ASUS and ASRock motherboards have their RGB controller on an SMBus interface that is not accessible by an unmodified Linux kernel (for now).  I am working on getting patches submitted upstream, but for now you must patch your kernel with the provided OpenRGB.patch file.

  *  Allowing access to SMBus from Unraid OS Console

      1. Load the i2c-dev module: `modprobe i2c-dev`

      2. Load the i2c driver for your chipset:
          -  Intel:
              - `modprobe i2c-i801`
              - `modprobe i2c-nct6775` - Secondary controller for motherboard LEDs (requires a kernel patch, not yet tested)
          -  AMD:
              - `modprobe i2c-piix4` 
              - Unmodified kernel will have one interface, patched kernel will have two.  The first at 0x0B00 and the second at 0x0B20.  The 0x0B20 interface is for motherboard LEDs.

  *  Modprobe will have to be run on each Unraid server reboot, or you can add the drivers to your 'go' file to automatically do this.:
      ```# modprobe for each sensor
           modprobe i2c-dev
           modprobe i2c-i801
           modprobe <sensor3>'''

  *  Instructions on patching the kernel:
      - https://gitlab.com/CalcProgrammer1/OpenRGB/-/wikis/OpenRGB-Kernel-Patch
      
  *  Some Gigabyte/Aorus motherboards have an ACPI conflict with the SMBus controller.
      - Add `acpi_enforce_resources=lax` to your kernel command line and reboot.  The controller should now show up.

  *  You'll have to enable perl in order for detect script to work on Unraid console.
      - List all SMBus controllers: `sensors-detect'. type Yes for all prompts, this is safe according to Unraid.
      - Note the number for PIIX4, I801, and NCT6775 controllers.
      - Pass these devices to P3R OpenRGB, ie. /dev/i2c-0, /dev/i2c-1, with read only permission is acceptable.

### USB Access

  *  USB devices should auto-populate if you didnt change UID or PID settings in the container.
  
## Projects Used

  * OpenRGB: https://gitlab.com/CalcProgrammer1/OpenRGB
