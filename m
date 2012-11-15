From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch RFC 0/6] network fixes for link waiting
Date: Thu, 15 Nov 2012 09:52:24 +0800
Message-ID: <50A44AD8.9000604@redhat.com>
References: <20121108034018.789330224@redhat.com> <50A35B2E.9050206@redhat.com> <50A378F0.4030907@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50A378F0.4030907-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/14/2012 06:56 PM, Harald Hoyer wrote:

> Am 14.11.2012 09:49, schrieb Dave Young:
>> Even with this series we still need add rd.retry=3D90 to make it wor=
k.
>> How about increase the default rd.retry value in dracut?
>>
>> On 11/08/2012 11:40 AM, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
>>
>>> Here is a patch set for some network cleanup and fixes:
>>> 01-network-move-wait-for-if-function-to-net-lib.patch
>>> 02-network-add-function-linkup.patch
>>> 03-network-use-linkup-function.patch
>>> 04-network-wait-for-link-ready-before-use.patch
>>> 05-network-get-ifaces-for-udev-rule-use.patch
>>> 06-network-wait-interface-up-at-early-stage.patch
>>>
>>> Tested kdump with a nic which delay abouth 60s while initializing.
>>>
>>> Please help to review especially for the patch 3/6 which replace so=
me ip link
>>> up with a function linkup.
>>>
>>> --
>>> Thanks a lot
>>> Dave
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe initramfs=
" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>=20
> wow, which HW is recognized only after 40 seconds?


Hi, It's a Qlogic nic, seel below log, looks like it detected a wrong
firmware, then released it and loaded firmware from flash:

Ethernet using netxen_nic driver for exp., suppressed irrelevant info.
[    6.666842] QLogic/NetXen Network Driver v4.0.80
[    6.727424] netxen_nic 0000:04:00.0: 2MB memory map
[   38.484866] netxen_nic 0000:04:00.0: Incompatibility detected betwee=
n
driver and firmware version on flash. This configuration is not
recommended. Please update the firmware on flash immediately
dracut-pre-pivot[581]: device node not found
dracut-pre-pivot[581]: cat: /sys/class/net/em1/address: No such file or
directory
dracut-pre-pivot[581]: cat: /sys/class/net/em1/address: No such file or
directory
dracut-pre-pivot[581]: ++ KDUMP_PATH=3D/var/crash
dracut-pre-pivot[581]: ++ CORE_COLLECTOR=3D
dracut-pre-pivot[581]: ++ DEFAULT_CORE_COLLECTOR=3D'makedumpfile -c
--message-level 1 -d 31'
dracut-pre-pivot[581]: ++ DEFAULT_ACTION=3Ddump_rootfs
dracut-pre-pivot[581]: +++ date +%d.%m.%y-%T
dracut-pre-pivot[581]: ++ DATEDIR=3D05.11.12-00:32:36
dracut-pre-pivot[581]: ++ DUMP_INSTRUCTION=3D
dracut-pre-pivot[581]: ++ SSH_KEY_LOCATION=3D/root/.ssh/kdump_id_rsa
dracut-pre-pivot[581]: ++ KDUMP_SCRIPT_DIR=3D/kdumpscripts
dracut-pre-pivot[581]: ++ DD_BLKSIZE=3D512
dracut-pre-pivot[581]: ++ FINAL_ACTION=3D'reboot -f'
dracut-pre-pivot[581]: ++ DUMP_RETVAL=3D0
dracut-pre-pivot[581]: ++ conf_file=3D/etc/kdump.conf
dracut-pre-pivot[581]: ++ KDUMP_PRE=3D


Entering emergency mode. Exit the shell to continue.
Type "journalctl" to view system logs.

kdump:/# dracut-pre-pivot[581]: ++ KDUMP_POST=3D
dracut-pre-pivot[581]: ++ export
PATH=3D/usr/sbin:/usr/bin:/sbin:/bin:/kdumpscripts
dracut-pre-pivot[581]: ++ PATH=3D/usr/sbin:/usr/bin:/sbin:/bin:/kdumpsc=
ripts
dracut-pre-pivot[581]: ++ read_kdump_conf
dracut-pre-pivot[581]: ++ '[' '!' -f /etc/kdump.conf ']'
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ case "$config_opt" in
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ case "$config_opt" in
dracut-pre-pivot[581]: ++ KDUMP_PATH=3D/
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ case "$config_opt" in
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ case "$config_opt" in
dracut-pre-pivot[581]: ++ case $config_val in
dracut-pre-pivot[581]: ++ DEFAULT_ACTION=3D'_emergency_shell kdump'
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ case "$config_opt" in
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ case "$config_opt" in
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ case "$config_opt" in
dracut-pre-pivot[581]: ++ add_dump_code 'dump_fs
ibm-x3250m4-01.rhts.eng.nay.redhat.com:/mnt/testarea/nfs'
dracut-pre-pivot[581]: ++ DUMP_INSTRUCTION=3D'dump_fs
ibm-x3250m4-01.rhts.eng.nay.redhat.com:/mnt/testarea/nfs'
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ case "$config_opt" in
dracut-pre-pivot[581]: ++ read config_opt config_val
dracut-pre-pivot[581]: ++ '[' -z '' ']'
dracut-pre-pivot[581]: ++ CORE_COLLECTOR=3D'makedumpfile -c
--message-level 1 -d 31'
dracut-pre-pivot[581]: ++ is_ssh_dump_target
dracut-pre-pivot[581]: ++ grep -q '^ssh.*@' /etc/kdump.conf
dracut-pre-pivot[581]: ++ is_raw_dump_target
dracut-pre-pivot[581]: ++ grep -q '^raw' /etc/kdump.conf
dracut-pre-pivot[581]: ++ '[' -z 'dump_fs
ibm-x3250m4-01.rhts.eng.nay.redhat.com:/mnt/testarea/nfs' ']'
dracut-pre-pivot[581]: ++ do_kdump_pre
dracut-pre-pivot[581]: ++ '[' -n '' ']'
dracut-pre-pivot[581]: ++ '[' 0 -ne 0 ']'
dracut-pre-pivot[581]: ++ dump_fs
ibm-x3250m4-01.rhts.eng.nay.redhat.com:/mnt/testarea/nfs
dracut-pre-pivot[581]: +++ findmnt -k -f -n -r -o TARGET
ibm-x3250m4-01.rhts.eng.nay.redhat.com:/mnt/testarea/nfs
dracut-pre-pivot[581]: ++ local _mp=3D
dracut-pre-pivot[581]: ++ '[' -z '' ']'
dracut-pre-pivot[581]: ++ echo 'kdump: error: Dump target
ibm-x3250m4-01.rhts.eng.nay.redhat.com:/mnt/testarea/nfs is not mounted=
=2E'
dracut-pre-pivot[581]: ++ return 1
dracut-pre-pivot[581]: ++ DUMP_RETVAL=3D1
dracut-pre-pivot[581]: ++ do_kdump_post 1
dracut-pre-pivot[581]: ++ '[' -n '' ']'
dracut-pre-pivot[581]: ++ '[' 0 -ne 0 ']'
dracut-pre-pivot[581]: ++ '[' 1 -ne 0 ']'
dracut-pre-pivot[581]: ++ do_default_action
dracut-pre-pivot[581]: ++ wait_for_loginit
dracut-pre-pivot[581]: ++ '[' no =3D yes ']'
dracut-pre-pivot[581]: ++ return
dracut-pre-pivot[581]: ++ _emergency_shell kdump
dracut-pre-pivot[581]: ++ local _name=3Dkdump
dracut-pre-pivot[581]: ++ '[' -n 1 ']'
dracut-pre-pivot[581]: ++ echo 'PS1=3D"kdump:${PWD}# "'
dracut-pre-pivot[581]: ++ systemctl start dracut-emergency.service
[  101.732446] netxen_nic 0000:04:00.0: loading firmware from flash
[  103.873799] netxen_nic 0000:04:00.0: Gen2 strapping detected
[  106.880731] netxen_nic 0000:04:00.0: using 64-bit dma mask
[  106.888721] netxen_nic: failed card response code:0x10
[  106.894405] netxen_nic 0000:04:00.0: Can't get template size 1684300=
9
[  106.901481] netxen_nic 0000:04:00.0: Failed to setup minidump rcode =
=3D -5
[  106.908839] netxen_nic: NX3031 Gigabit Ethernet Board S/N
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=E2=96=92=EF=BF=BD=EF=BF=BD  Chip rev 0x42
[  106.919726] netxen_nic 0000:04:00.0: firmware v4.0.527 [legacy]
[  106.926689] netxen_nic 0000:04:00.0: using msi-x interrupts
[  106.933163] netxen_nic 0000:04:00.0: eth0: GbE port initialized
[  106.939902] netxen_nic 0000:04:00.1: 2MB memory map
[  106.949661] netxen_nic 0000:04:00.1: using 64-bit dma mask
[  106.965572] systemd-udevd[629]: renamed network interface eth0 to em=
1
[  106.982471] netxen_nic: failed card response code:0x10
[  106.988124] netxen_nic 0000:04:00.1: Can't get template size 1684300=
9
[  106.995196] netxen_nic 0000:04:00.1: Failed to setup minidump rcode =
=3D -5
[  107.002555] netxen_nic 0000:04:00.1: firmware v4.0.527 [legacy]
[  107.009440] netxen_nic 0000:04:00.1: using msi-x interrupts
[  107.015687] netxen_nic 0000:04:00.1: eth0: GbE port initialized
[  107.022569] netxen_nic 0000:04:00.2: 2MB memory map
[  107.030819] netxen_nic 0000:04:00.2: using 64-bit dma mask
[  107.062359] systemd-udevd[633]: renamed network interface eth0 to em=
2
[  107.075314] netxen_nic: failed card response code:0x10
[  107.081043] netxen_nic 0000:04:00.2: Can't get template size 1684300=
9
[  107.088117] netxen_nic 0000:04:00.2: Failed to setup minidump rcode =
=3D -5
[  107.095476] netxen_nic 0000:04:00.2: firmware v4.0.527 [legacy]
[  107.102316] netxen_nic 0000:04:00.2: using msi-x interrupts
[  107.108574] netxen_nic 0000:04:00.2: eth0: GbE port initialized
[  107.115596] netxen_nic 0000:04:00.3: 2MB memory map
[  107.124339] netxen_nic 0000:04:00.3: using 64-bit dma mask
[  107.157705] systemd-udevd[629]: renamed network interface eth0 to em=
3
[  107.184131] netxen_nic: failed card response code:0x10
[  107.189786] netxen_nic 0000:04:00.3: Can't get template size 1684300=
9
[  107.196853] netxen_nic 0000:04:00.3: Failed to setup minidump rcode =
=3D -5
[  107.204205] netxen_nic 0000:04:00.3: firmware v4.0.527 [legacy]
[  107.211062] netxen_nic 0000:04:00.3: using msi-x interrupts
[  107.217311] netxen_nic 0000:04:00.3: eth0: GbE port initialized
[  107.244557] systemd-udevd[629]: renamed network interface eth0 to em=
4


--=20
Thanks
Dave
