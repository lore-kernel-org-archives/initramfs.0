From: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>
Subject: Udev problem with FC24 (was ok in FC23)
Date: Sat, 2 Jul 2016 08:13:08 +0200
Message-ID: <c433c1aa-1d16-7ea3-f614-a4d0eb72505a@wiesinger.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 wiesinger.com u626D8uG001990
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hello,

I had the following configuration on FC23 (systemd-222-14.fc23) which=20
worked perfectly (ARM system):

cat /etc/udev/rules.d/8-usb-modem.rules
# Huawei E169
SUBSYSTEM=3D=3D"tty", ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D=
"1001",=20
ATTRS{product}=3D=3D"HUAWEI Mobile", ATTRS{version}=3D=3D" 1.10",=20
ENV{ID_USB_INTERFACE_NUM}=3D=3D"00" SYMLINK+=3D"ttyUSB-modem-at"
SUBSYSTEM=3D=3D"tty", ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D=
"1001",=20
ATTRS{product}=3D=3D"HUAWEI Mobile", ATTRS{version}=3D=3D" 1.10",=20
ENV{ID_USB_INTERFACE_NUM}=3D=3D"01" SYMLINK+=3D"ttyUSB-modem-aux"
SUBSYSTEM=3D=3D"tty", ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D=
"1001",=20
ATTRS{product}=3D=3D"HUAWEI Mobile", ATTRS{version}=3D=3D" 1.10",=20
ENV{ID_USB_INTERFACE_NUM}=3D=3D"02" SYMLINK+=3D"ttyUSB-modem-third"

After upgrade to FC24 (systemd-udev-229-8.fc24.armv7hl) I have the=20
problem that ttyUSB-modem-at link is not set.

lrwxrwxrwx 1 root root           7 Jul  1 18:49 ttyUSB-modem-aux -> tty=
USB2
lrwxrwxrwx 1 root root           7 Jul  1 18:49 ttyUSB-modem-third ->=20
ttyUSB3

I tried also:

# OK:
KERNEL=3D=3D"ttyUSB1", SUBSYSTEM=3D=3D"tty", ATTRS{idVendor}=3D=3D"12d1=
",=20
ATTRS{idProduct}=3D=3D"1001", ATTRS{product}=3D=3D"HUAWEI Mobile",=20
ATTRS{version}=3D=3D" 1.10" SYMLINK+=3D"ttyUSB-modem-at"
# NOT OK:
KERNEL=3D=3D"ttyUSB1", DRIVERS=3D=3D"option", SUBSYSTEM=3D=3D"tty",=20
ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1001",=20
ATTRS{product}=3D=3D"HUAWEI Mobile", ATTRS{version}=3D=3D" 1.10"=20
SYMLINK+=3D"ttyUSB-modem-at"

So when something more specific correct filter is added it doesn't work=
=20
any more (I tried several different more distinct filters):

I tried already: udevadm info --attribute-walk /dev/ttyUSB1 which looks=
=20
good

=46irst lines are:

    looking at device=20
'/devices/platform/soc@01c00000/1c14000.usb/usb3/3-1/3-1.1/3-1.1:1.0/tt=
yUSB1/tty/ttyUSB1':
      KERNEL=3D=3D"ttyUSB1"
      SUBSYSTEM=3D=3D"tty"
      DRIVER=3D=3D""

    looking at parent device=20
'/devices/platform/soc@01c00000/1c14000.usb/usb3/3-1/3-1.1/3-1.1:1.0/tt=
yUSB1':
      KERNELS=3D=3D"ttyUSB1"
      SUBSYSTEMS=3D=3D"usb-serial"
      DRIVERS=3D=3D"option1"
      ATTRS{port_number}=3D=3D"0"

    looking at parent device=20
'/devices/platform/soc@01c00000/1c14000.usb/usb3/3-1/3-1.1/3-1.1:1.0':
      KERNELS=3D=3D"3-1.1:1.0"
      SUBSYSTEMS=3D=3D"usb"
      DRIVERS=3D=3D"option"
      ATTRS{authorized}=3D=3D"1"
      ATTRS{bAlternateSetting}=3D=3D" 0"
      ATTRS{bInterfaceClass}=3D=3D"ff"
      ATTRS{bInterfaceNumber}=3D=3D"00"
      ATTRS{bInterfaceProtocol}=3D=3D"ff"
      ATTRS{bInterfaceSubClass}=3D=3D"ff"
      ATTRS{bNumEndpoints}=3D=3D"03"
      ATTRS{interface}=3D=3D"Data Interface"
      ATTRS{supports_autosuspend}=3D=3D"1"

This one looks also good:

ls -l /dev/serial/by-id/usb-=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=
=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF_H=
UAWEI_Mobile-if00-port0
lrwxrwxrwx 1 root root 13 Jul  1 18:49=20
/dev/serial/by-id/usb-=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=
=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF_HUAWEI_=
Mobile-if00-port0 ->=20
=2E./../ttyUSB1

I don't think I did anything wrong so it looks to be a bug.

Any ideas?

Thank you.

Ciao,

Gerhard


--=20

https://www.wiesinger.com/

