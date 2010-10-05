From: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Subject: Dracut NFS root rw before pivot but ro after pivot
Date: Tue, 05 Oct 2010 12:42:50 +1100
Message-ID: <20101005124250.12811x7b1hr8g23k@webmail.zoltak.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Guys,

I can boot an NFS root however when Dracut pivots the NFS becomes read-only.

The pxelinux.cfg files:

APPEND bootdev=eth1 ip=dhcp  
root=nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw initrd=initrd-2.6.34-gentoo-r1-dracut  
rw

When I set rdbreak=pre-pivot and I issue a mount command the /sysroot  
is mounted with rw and I can touch a file on the nfs.

Something happens after the pivot occurs and the volume be no longer  
writable as I get permission denied errors as services start-up.

Does anyone have any suggestions on the possible cause?

Thanks



