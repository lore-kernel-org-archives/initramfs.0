From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Udev problem with FC24 (was ok in FC23)
Date: Mon, 4 Jul 2016 13:38:45 +0200
Message-ID: <6c7e010c-5c6b-c126-08b8-79338bbfbadf@redhat.com>
References: <2b2d505f-1119-2b1d-9a80-16c6bd2e30e0@wiesinger.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2b2d505f-1119-2b1d-9a80-16c6bd2e30e0-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Better file a bug in the RH bugzilla <https://bugzilla.redhat.com/>
or an issue on github <https://github.com/systemd/systemd/issues>

On 01.07.2016 19:55, Gerhard Wiesinger wrote:
> Hello,
>
> I had the following configuration on FC23 (systemd-222-14.fc23) which=
 worked perfectly (ARM system):
>
> cat /etc/udev/rules.d/8-usb-modem.rules
> # Huawei E169
> SUBSYSTEM=3D=3D"tty", ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=
=3D"1001", ATTRS{product}=3D=3D"HUAWEI Mobile", ATTRS{version}=3D=3D" 1=
=2E10",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"00" SYMLINK+=3D"ttyUSB-modem-at"
> SUBSYSTEM=3D=3D"tty", ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=
=3D"1001", ATTRS{product}=3D=3D"HUAWEI Mobile", ATTRS{version}=3D=3D" 1=
=2E10",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"01" SYMLINK+=3D"ttyUSB-modem-aux"
> SUBSYSTEM=3D=3D"tty", ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=
=3D"1001", ATTRS{product}=3D=3D"HUAWEI Mobile", ATTRS{version}=3D=3D" 1=
=2E10",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"02" SYMLINK+=3D"ttyUSB-modem-third"
>
> After upgrade to FC24 (systemd-udev-229-8.fc24.armv7hl) I have the pr=
oblem that ttyUSB-modem-at link is not set.
>
> lrwxrwxrwx 1 root root           7 Jul  1 18:49 ttyUSB-modem-aux -> t=
tyUSB2
> lrwxrwxrwx 1 root root           7 Jul  1 18:49 ttyUSB-modem-third ->=
 ttyUSB3
>
> I tried also:
>
> # OK:
> KERNEL=3D=3D"ttyUSB1", SUBSYSTEM=3D=3D"tty", ATTRS{idVendor}=3D=3D"12=
d1", ATTRS{idProduct}=3D=3D"1001", ATTRS{product}=3D=3D"HUAWEI Mobile",
> ATTRS{version}=3D=3D" 1.10" SYMLINK+=3D"ttyUSB-modem-at"
> # NOT OK:
> KERNEL=3D=3D"ttyUSB1", DRIVERS=3D=3D"option", SUBSYSTEM=3D=3D"tty", A=
TTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1001", ATTRS{product=
}=3D=3D"HUAWEI
> Mobile", ATTRS{version}=3D=3D" 1.10" SYMLINK+=3D"ttyUSB-modem-at"
>
> So when something more specific correct filter is added it doesn't wo=
rk any more (I tried several different more distinct filters):
>
> I tried already: udevadm info --attribute-walk /dev/ttyUSB1 which loo=
ks good
>
> First lines are:
>
>    looking at device '/devices/platform/soc@01c00000/1c14000.usb/usb3=
/3-1/3-1.1/3-1.1:1.0/ttyUSB1/tty/ttyUSB1':
>      KERNEL=3D=3D"ttyUSB1"
>      SUBSYSTEM=3D=3D"tty"
>      DRIVER=3D=3D""
>
>    looking at parent device '/devices/platform/soc@01c00000/1c14000.u=
sb/usb3/3-1/3-1.1/3-1.1:1.0/ttyUSB1':
>      KERNELS=3D=3D"ttyUSB1"
>      SUBSYSTEMS=3D=3D"usb-serial"
>      DRIVERS=3D=3D"option1"
>      ATTRS{port_number}=3D=3D"0"
>
>    looking at parent device '/devices/platform/soc@01c00000/1c14000.u=
sb/usb3/3-1/3-1.1/3-1.1:1.0':
>      KERNELS=3D=3D"3-1.1:1.0"
>      SUBSYSTEMS=3D=3D"usb"
>      DRIVERS=3D=3D"option"
>      ATTRS{authorized}=3D=3D"1"
>      ATTRS{bAlternateSetting}=3D=3D" 0"
>      ATTRS{bInterfaceClass}=3D=3D"ff"
>      ATTRS{bInterfaceNumber}=3D=3D"00"
>      ATTRS{bInterfaceProtocol}=3D=3D"ff"
>      ATTRS{bInterfaceSubClass}=3D=3D"ff"
>      ATTRS{bNumEndpoints}=3D=3D"03"
>      ATTRS{interface}=3D=3D"Data Interface"
>      ATTRS{supports_autosuspend}=3D=3D"1"
>
> This one looks also good:
>
> ls -l /dev/serial/by-id/usb-=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=
=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=
_HUAWEI_Mobile-if00-port0
> lrwxrwxrwx 1 root root 13 Jul  1 18:49 /dev/serial/by-id/usb-=C3=BF=C3=
=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=
=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF_HUAWEI_Mobile-if00-port0 -> ../../tty=
USB1
>
> I don't think I did anything wrong so it looks to be a bug.
>
> Any ideas?
>
> Thank you.
>
> Ciao,
>
> Gerhard
>
>
> --
>
> https://www.wiesinger.com/
>
>
