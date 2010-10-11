From: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Subject: Re: Dracut NFS root DHCP timeouts
Date: Tue, 12 Oct 2010 09:44:12 +1100
Message-ID: <20101012094412.14125sp7tc6dj7r4@webmail.zoltak.com>
References: <20101011133718.205549hmcnjzr3a8@webmail.zoltak.com>
 <4CB30231.80803@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CB30231.80803-omB+W0Dpw2o@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Thanks Seewer!

Quoting Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>:

> Ummm... Just so that I understand this. The logs for Attempt 1 and 2  
> are after the dracut pivot from the dhcp requests inside the  
> nfs-rooted system and the logs and the last one above is from dhcp  
> inside dracut. correct?

All attempts are pre-pivot. The first 2 happen early in boot and then  
the final appears to happen as the final step  prior to the pivot to  
the NFS root.

> BTW: If you are using a recent pxelinux, why don't you try  
> IPAPPEND=3 and remove all ip-options from dracut? (See  
> http://syslinux.zytor.com/wiki/index.php/SYSLINUX#IPAPPEND_flag_val_.5BPXELINUX_only.5D). This should cause dracut not to issue any dhcp requests at all. Sorry I haven't thought about this  
> earlier.

I tried with IPAPPEND=3 and Dracut fails to boot. It appears to get an  
IP but dies with an error:

[snip]
IP-Config: Got DHCP answer from 10.197.170.42, my address is 10.197.170.30
IP-Config: Complete:
        device=eth1, addr=10.197.170.30, mask=255.255.255.0,  
gw=255.255.255.255,
        host=test.test.com, domain=test.com, nis-domain=(none),
        bootserver=10.197.170.42, rootserver=10.197.170.42, rootpath=
Freeing unused kernel memory: 452k freed
dracut: FATAL: Mixing BOOTIF and ip= lines is dangerous
dracut: Refusing to continue
dracut: FATAL: Mixing BOOTIF and ip= lines is dangerous
dracut: Refusing to continue


Signal caught!

Boot has failed, sleeping forever
[/snip]

The initial DHCP request no longer occur, dracut appears to get an  
address however it then fails to pivot?



