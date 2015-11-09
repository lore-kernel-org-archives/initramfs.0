From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Update FC23 - doesn't boot - ssh preboot not working anymore
Date: Mon, 9 Nov 2015 15:58:04 +0100
Message-ID: <5640B47C.1020101@redhat.com>
References: <5639297E.7050905@wiesinger.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5639297E.7050905-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 03.11.2015 um 22:39 schrieb Gerhard Wiesinger:
> Hello,
> 
> After upgrading one machine it does't boot anymore. Booting the old FC22 kernel
> works well.
> 
> Reached target Basic System.
> Found device /dev/mapper/luks-9fbecd95-508a-45ca-997a-42a613c4e5bf
> Found device /dev/mapper/fedora_hostname-root
> 
> Also integration of ssh preboot authentication is not available anymore.
> 
> blkid:
> /dev/vda2: UUID="f3e2c8a9-51b1-4110-aef5-039cf714425a" TYPE="ext4"
> PARTLABEL="Linux filesystem" PARTUUID="6bc53fb0-771b-4b52-b584-c87735715a47"
> /dev/vda3: UUID="9fbecd95-508a-45ca-997a-42a613c4e5bf" TYPE="crypto_LUKS"
> PARTLABEL="Linux filesystem" PARTUUID="090ffe9b-6791-46df-b9a4-f30adbb95e50"
> /dev/mapper/luks-9fbecd95-508a-45ca-997a-42a613c4e5bf:
> UUID="A3RzKd-F7ym-pN6a-F01g-Q0Gw-DrVr-jhTgbo" TYPE="LVM2_member"
> /dev/mapper/fedora_hostname-swap: UUID="cef5950c-43bc-485c-ae2b-832fcbe752c7"
> TYPE="swap"
> /dev/mapper/fedora_hostname-root: UUID="8f5436a3-28cb-4c7e-91df-e3f9249d17d2"
> TYPE="ext4"
> /dev/vda1: PARTLABEL="BIOS Boot Partition"
> PARTUUID="35685b7e-917c-4cc5-9133-69f00f5a1e2f"
> 
> Any ideas?
> 
> Thank you.
> 
> Ciao,
> Gerhard



https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html#_troubleshooting

please file a bugzilla on the fedora/redhat bugzilla and add rdsosreport.txt
