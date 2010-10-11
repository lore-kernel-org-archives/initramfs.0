From: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Subject: Re: Dracut NFS root DHCP timeouts
Date: Tue, 12 Oct 2010 09:59:07 +1100
Message-ID: <20101012095907.67957er3t0oyr2bk@webmail.zoltak.com>
References: <20101011133718.205549hmcnjzr3a8@webmail.zoltak.com>
 <4CB30231.80803@bfh.ch>
 <20101012094412.14125sp7tc6dj7r4@webmail.zoltak.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101012094412.14125sp7tc6dj7r4-2RFepEojUI3Y3UUic/vCjNBPR1lH4CV8@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> Quoting Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>:

>> BTW: If you are using a recent pxelinux, why don't you try  
>> IPAPPEND=3 and remove all ip-options from dracut? (See

I tried IPAPPEND=2 and everything works correctly. The initial DHCP  
requests do not occur and then prior to pivot it gets the address on  
the boot interface and boots!

So the pxelinux.cfg looks like:

                 IPAPPEND 2 # initially tried 3 without success
                 APPEND  
root=10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nfsvers=3,nointr,actimeo=3600,noacl,rw,tcp,sec=sys initrd=initrd-2.6.34-gentoo-r1-dracut  
rw


