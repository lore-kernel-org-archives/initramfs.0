From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/8] /etc/multipath.conf is not mandatory
Date: Wed, 1 Jul 2015 10:56:19 +0200
Message-ID: <5593AB33.40901@redhat.com>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
 <1435330557-17685-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435330557-17685-2-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, bmarzins-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 26.06.2015 16:55, Thomas Renninger wrote:
> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
>=20
> If rootfs is on multipath, but platform does not have an /etc/multipa=
th.conf
> file which is not urgently needed, they system will not boot, due to:
>=20
> multipathd is not started and rootfs and swap are not found:
> systemctl status multipathd.service
> * multipathd.service - Device-Mapper Multipath Device Controller
>    Loaded: loaded (/usr/lib/systemd/system/multipathd.service; disabl=
ed; vendor preset: enabled)
>    Active: inactive (dead)
> Condition: start condition failed at Thu 2015-05-07 11:49:11 CEST; 7m=
in ago
>            ConditionPathExists=3D/etc/multipath.conf was not met
> and exit to dracut shell.
>=20
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/90multipath/multipathd.service | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/modules.d/90multipath/multipathd.service b/modules.d/90m=
ultipath/multipathd.service
> index b64b02c..f7bc65f 100644
> --- a/modules.d/90multipath/multipathd.service
> +++ b/modules.d/90multipath/multipathd.service
> @@ -6,7 +6,6 @@ Conflicts=3Dshutdown.target
>  ConditionKernelCommandLine=3D!nompath
>  ConditionKernelCommandLine=3D!rd.multipath=3D0
>  ConditionKernelCommandLine=3D!rd_NO_MULTIPATH
> -ConditionPathExists=3D/etc/multipath.conf
> =20
>  [Service]
>  Type=3Dsimple
>=20

CC'ing Benjmain Marzinski as the Fedora maintainer of device-mapper-mul=
tipath.

I don't understand how multipath is used without a configuration?

Anyway, I see the service file in Fedora is quiet different from yours =
and
yours is also different from upstream.

So we have:

*Upstream* -
<http://git.opensvc.com/gitweb.cgi?p=3Dmultipath-tools/.git;a=3Dblob_pl=
ain;f=3Dmultipathd/multipathd.service;h=3Db5b755bbacd08cd9f612206ce73dc=
e965dbc8b2a;hb=3DHEAD>

[Unit]
Description=3DDevice-Mapper Multipath Device Controller
Before=3Discsi.service iscsid.service lvm2-activation-early.service
Before=3Dlocal-fs-pre.target
After=3Dmultipathd.socket
DefaultDependencies=3Dno
Wants=3Dlocal-fs-pre.target multipathd.socket
Conflicts=3Dshutdown.target

[Service]
Type=3Dnotify
NotifyAccess=3Dmain
LimitCORE=3Dinfinity
ExecStartPre=3D/sbin/modprobe dm-multipath
ExecStart=3D/sbin/multipathd -d -s
ExecReload=3D/sbin/multipathd reconfigure

[=85]

*Fedora device-mapper-multipath-0.4.9-76*

 [Unit]
 Description=3DDevice-Mapper Multipath Device Controller
 Before=3Discsi.service iscsid.service lvm2-activation-early.service
-Before=3Dlocal-fs-pre.target
-After=3Dmultipathd.socket
+After=3Dsyslog.target
+ConditionPathExists=3D/etc/multipath.conf
+ConditionKernelCommandLine=3D!nompath
 DefaultDependencies=3Dno
-Wants=3Dlocal-fs-pre.target multipathd.socket
 Conflicts=3Dshutdown.target

 [Service]
-Type=3Dnotify
-NotifyAccess=3Dmain
-LimitCORE=3Dinfinity
+Type=3Dforking
+PIDFile=3D/var/run/multipathd/multipathd.pid
 ExecStartPre=3D/sbin/modprobe dm-multipath
-ExecStart=3D/sbin/multipathd -d -s
+ExecStartPre=3D-/sbin/multipath -A
+ExecStart=3D/sbin/multipathd
 ExecReload=3D/sbin/multipathd reconfigure
+#ExecStop=3D/path/to/scrip delete-me if not necessary


*openSUSE multipath-tools-0.5.0-20.1*

 [Unit]
 Description=3DDevice-Mapper Multipath Device Controller
 Before=3Discsi.service iscsid.service lvm2-activation-early.service
-Before=3Dlocal-fs-pre.target
-After=3Dmultipathd.socket
+Before=3Dlocal-fs-pre.target systemd-udev-trigger.service
+After=3Dmultipathd.socket systemd-udevd.service
 DefaultDependencies=3Dno
 Wants=3Dlocal-fs-pre.target multipathd.socket
 Conflicts=3Dshutdown.target
@@ -11,6 +11,10 @@
 Type=3Dnotify
 NotifyAccess=3Dmain
 LimitCORE=3Dinfinity
-ExecStartPre=3D/sbin/modprobe dm-multipath
+ExecStartPre=3D/sbin/modprobe -a scsi_dh_alua scsi_dh_emc scsi_dh_rdac=
 dm-multipath
 ExecStart=3D/sbin/multipathd -d -s
 ExecReload=3D/sbin/multipathd reconfigure



I think it's impossible to make this independent in dracut from the shi=
pped
package. You guys definetly should either ship the initramfs version in=
 the
package, so the dracut module can copy that, or better use the same uni=
t file
across distributions.
