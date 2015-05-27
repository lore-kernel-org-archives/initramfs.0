From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Update FC22 - doesn't find root fs and doesn't boot
Date: Wed, 27 May 2015 15:13:52 +0300
Message-ID: <CAA91j0UysOKJG6LpuvCdrh3jcRMdj9+=XaD-R+Shw7WFZSvbUw@mail.gmail.com>
References: <5565AA58.6000409@wiesinger.com>
	<5565B0E6.3050204@redhat.com>
	<5565B3E6.4010806@wiesinger.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RtRmlNKZWKMvmJXkZAsGNnkZ/O5cIop1L0xxReYY4v4=;
        b=yMuRWq0SCSClJB9YJYGBKGqo15FmECQFwfNTukBNz0s7gbvoS9G1URHvD5DqK4vyyH
         BpULzpBRXAUNwa/7PnvzVHFthnfb845Fqy16sDcc4d0avZ8KmUnmPqAg5VpjmcXFPvEU
         AbA9FTEAN3tZRtoDKn8MB5rjZN6u+N2PXtU11YKV/FInltgNI/m2/wWF1cs028+DSr4I
         o1QQPQF0RR/xqnl8MzE4PVMHy3oFFWIHmj8IJdLHxqtmQEmcPuVJuDhOpqlS1UR4aLxG
         5m6kprKr1d1rCEzD4OrfuWPcJNqB1Vzg2bYDGOlQSVEqmh+SpBOp8dELiS3FeuXz0NGz
         LCng==
In-Reply-To: <5565B3E6.4010806-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, May 27, 2015 at 3:09 PM, Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org> wrote:
> On 27.05.2015 13:56, Harald Hoyer wrote:
>>
>> Am 27.05.2015 um 13:28 schrieb Gerhard Wiesinger:
>>>
>>> Hello,
>>>
>>> After upgrading one machine it does't boot anymore. Booting the old
>>> kernel
>>> works well.
>>>
>>> It is a RAID, LUKS, LVM setup. Find relevant details below.
>>>
>>> So it looks RAID assembling doesn't work any more.
>>>
>>> Any ideas?
>>>
>>> Thank you.
>>>
>>> Ciao,
>>> Gerhard
>>>
>>> blkid
>>> /dev/sda1: UUID="56e9bde4-5cd1-630d-188c-22a54c1c8c37"
>>> TYPE="linux_raid_member"
>>> PARTUUID="5ec6792c-01"
>>> /dev/sdb1: UUID="56e9bde4-5cd1-630d-188c-22a54c1c8c37"
>>> TYPE="linux_raid_member"
>>> PARTUUID="1c7cffaf-01"
>>> /dev/sdc1: UUID="56e9bde4-5cd1-630d-188c-22a54c1c8c37"
>>> TYPE="linux_raid_member"
>>> PARTUUID="0079dfc3-01"
>>> /dev/sdd1: UUID="eb295015-e20b-e133-15db-5c9130487300"
>>> TYPE="linux_raid_member"
>>> PARTUUID="fadeaffe-01"
>>> /dev/sde1: UUID="eb295015-e20b-e133-15db-5c9130487300"
>>> TYPE="linux_raid_member"
>>> PARTUUID="539b5814-01"
>>> /dev/sdf1: UUID="eb295015-e20b-e133-15db-5c9130487300"
>>> TYPE="linux_raid_member"
>>> PARTUUID="badeaffe-01"
>>> /dev/sdh1: UUID="51e8e983-8786-b868-dbc3-87357e1a9534"
>>> TYPE="linux_raid_member"
>>> PARTUUID="15631562-01"
>>> /dev/sdg1: UUID="51e8e983-8786-b868-dbc3-87357e1a9534"
>>> TYPE="linux_raid_member"
>>> PARTUUID="162f0d0b-01"
>>>
>>>
>>> blkid -o udev
>>> ID_FS_UUID=56e9bde4-5cd1-630d-188c-22a54c1c8c37
>>> ID_FS_UUID_ENC=56e9bde4-5cd1-630d-188c-22a54c1c8c37
>>> ID_FS_TYPE=linux_raid_member
>>> ID_FS_PARTUUID=5ec6792c-01
>>>
>>> ID_FS_UUID=56e9bde4-5cd1-630d-188c-22a54c1c8c37
>>> ID_FS_UUID_ENC=56e9bde4-5cd1-630d-188c-22a54c1c8c37
>>> ID_FS_TYPE=linux_raid_member
>>> ID_FS_PARTUUID=1c7cffaf-01
>>>
>>> ID_FS_UUID=56e9bde4-5cd1-630d-188c-22a54c1c8c37
>>> ID_FS_UUID_ENC=56e9bde4-5cd1-630d-188c-22a54c1c8c37
>>> ID_FS_TYPE=linux_raid_member
>>> ID_FS_PARTUUID=0079dfc3-01
>>>
>>> ID_FS_UUID=eb295015-e20b-e133-15db-5c9130487300
>>> ID_FS_UUID_ENC=eb295015-e20b-e133-15db-5c9130487300
>>> ID_FS_TYPE=linux_raid_member
>>> ID_FS_PARTUUID=fadeaffe-01
>>>
>>> ID_FS_UUID=eb295015-e20b-e133-15db-5c9130487300
>>> ID_FS_UUID_ENC=eb295015-e20b-e133-15db-5c9130487300
>>> ID_FS_TYPE=linux_raid_member
>>> ID_FS_PARTUUID=539b5814-01
>>>
>>> ID_FS_UUID=eb295015-e20b-e133-15db-5c9130487300
>>> ID_FS_UUID_ENC=eb295015-e20b-e133-15db-5c9130487300
>>> ID_FS_TYPE=linux_raid_member
>>> ID_FS_PARTUUID=badeaffe-01
>>>
>>> ID_FS_UUID=51e8e983-8786-b868-dbc3-87357e1a9534
>>> ID_FS_UUID_ENC=51e8e983-8786-b868-dbc3-87357e1a9534
>>> ID_FS_TYPE=linux_raid_member
>>> ID_FS_PARTUUID=15631562-01
>>>
>>> ID_FS_UUID=51e8e983-8786-b868-dbc3-87357e1a9534
>>> ID_FS_UUID_ENC=51e8e983-8786-b868-dbc3-87357e1a9534
>>> ID_FS_TYPE=linux_raid_member
>>> ID_FS_PARTUUID=162f0d0b-01
>>>
>>> [    2.479836] myhost systemd[1]: Device
>>> dev-disk-by\x2did-usb\x2dUSBDisk_RunDisk_ABCDEFGH\x2d0:0.device appeared
>>> twice
>>> with different sysfs paths /sys
>>>
>>> /devices/pci0000:00/0000:00:04.1/usb2/2-5/2-5:1.0/host9/target9:0:0/9:0:0:0/block/sdh
>>> and /sys/devices/pci0000:00/0000:00:02.1/usb1/1-5/1-5:1.0/host8/target
>>> 8:0:0/8:0:0:0/block/sdg
>>> [    2.500826] myhost systemd[1]: Device
>>> dev-disk-by\x2did-usb\x2dUSBDisk_RunDisk_ABCDEFGH\x2d0:0\x2dpart1.device
>>> appeared twice with different sysfs p
>>> aths
>>>
>>> /sys/devices/pci0000:00/0000:00:04.1/usb2/2-5/2-5:1.0/host9/target9:0:0/9:0:0:0/block/sdh/sdh1
>>> and /sys/devices/pci0000:00/0000:00:02.1/usb1/1-5/1-5:1.
>>> 0/host8/target8:0:0/8:0:0:0/block/sdg/sdg1
>>> [    2.632754] myhost kernel: Switched to clocksource tsc
>>> [   91.162986] myhost systemd[1]: Job dev-md0.device/start timed out.
>>> [   91.163138] myhost systemd[1]: Timed out waiting for device
>>> dev-md0.device.
>>> [   91.163251] myhost systemd[1]: Dependency failed for Cryptography
>>> Setup for
>>> luks-md0.
>>> [   91.163360] myhost systemd[1]: Dependency failed for
>>> dev-mapper-luks\x2dmd0.device.
>>> [   91.163474] myhost systemd[1]: Job dev-mapper-luks\x2dmd0.device/start
>>> failed with result 'dependency'.
>>> [   91.163586] myhost systemd[1]: Dependency failed for Encrypted
>>> Volumes.
>>> [   91.163694] myhost systemd[1]: Job cryptsetup.target/start failed with
>>> result 'dependency'.
>>> [   91.163801] myhost systemd[1]: Job
>>> systemd-cryptsetup@luks\x2dmd0.service/start failed with result
>>> 'dependency'.
>>> [   91.163910] myhost systemd[1]: Job dev-md0.device/start failed with
>>> result
>>> 'timeout'.
>>> [   91.164021] myhost systemd[1]: Reached target System Initialization.
>>> [   91.164129] myhost systemd[1]: Starting System Initialization.
>>> [   91.164236] myhost systemd[1]: Reached target Basic System.
>>> [   91.164346] myhost systemd[1]: Starting Basic System.
>>> [  185.740238] myhost dracut-initqueue[340]: Warning: Could not boot.
>>> [  185.741266] myhost systemd[1]: Received SIGRTMIN+20 from PID 341
>>> (plymouthd).
>>> [  185.841257] myhost dracut-initqueue[340]: Warning:
>>> /dev/VolGroup00/root does
>>> not exist
>>> [  185.841403] myhost systemd[1]: Starting Dracut Emergency Shell...
>>> [  185.859366] myhost systemd[1]: Received SIGRTMIN+21 from PID 341
>>> (plymouthd).
>>>
>>> dracut:/# cat "/run/initramfs/rdsosreport.txt"
>>> + cat /lib/dracut/dracut-041-10.fc22.1
>>> dracut-041-10.fc22.1
>>> + cat /proc/cmdline
>>> BOOT_IMAGE=/vmlinuz-4.0.4-301.fc22.x86_64 root=/dev/VolGroup00/root ro
>>> quiet
>>> console=ttyS0,115200n8 rd_NO_PLYMOUTH SYSFONT=latarcyrheb-sun16
>>> LANG=en_US.UTF-
>>> 8 KEYTABLE=de-latin1
>>
>>
>> your kernel cmdline seems to be missing the raid configuration
>>
>> rd.md.uuid=56e9bde4-5cd1-630d-188c-22a54c1c8c37
>> rd.md.uuid=eb295015-e20b-e133-15db-5c9130487300
>> rd.md.uuid=51e8e983-8786-b868-dbc3-87357e1a9534
>>
>> ... whatever is needed to boot your system.
>>
>> # dracut --print-cmdline
>>
>> should tell you what kernel cmdline parameters are needed
>
>
>
> Thank you for the fast reply.
>
> # comment: 3 separate lines!!!!! (maybe a problem)
> dracut --print-cmdline
>  rd.luks.uuid=luks-0c66fc77-a8a0-49e6-b96c-55e886a91f09
> rd.lvm.lv=VolGroup00/root
>  rd.lvm.lv=VolGroup00/swap
>  rd.md.uuid=51e8e983:8786b868:dbc38735:7e1a9534
> rd.md.uuid=56e9bde4:5cd1630d:188c22a5:4c1c8c37
> resume=/dev/mapper/VolGroup00-swap root=/dev/mapper/VolGroup00-root
> rootflags=rw,relatime,data=ordered rootfstype=ext4
>
> dracut --force 4.0.4-301.fc22.x86_64
>
> Still no correct entry in /etc/grub2.cfg

I would be very surprised if dracut made any changes to grub.cfg. As I
understand it, you either build host-specific dracut that will include
this emulated command line or you have to add lines manually to your
boot loader configuration.

> linux16 /vmlinuz-4.0.4-301.fc22.x86_64 root=/dev/VolGroup00/root ro quiet
> console=ttyS0,115200n8 rd_NO_PLYMOUTH SYSFONT=latarcyrheb-sun16
> LANG=en_US.UTF-8 KEYTABLE=de-latin1
>
> Looks like a bug to me.
>
> Thank you.
>
> Ciao,
> Gerhard
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
