From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: /etc/passwd thoughts
Date: Fri, 12 Jun 2009 16:20:46 -0400
Message-ID: <20090612202045.GA30968@nostromo.devel.redhat.com>
References: <4A32B84E.8090603@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A32B84E.8090603-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami (wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) said: 
> [warren@newcaprica dracut]$ grep -r \/etc\/passwd *
> modules.d/95nfs/install:dracut_install /etc/netconfig /etc/passwd  
> /etc/services
> modules.d/95nfs/install:#echo  
> "rpc:x:32:32:Rpcbind:/var/lib/rpcbind:/bin/false" >> 
> "$initdir/etc/passwd"
> modules.d/90mdraid/install:inst /etc/passwd
>
> It seems that we want an /etc/passwd for certain things in the initrd  
> image, but is it really necessary for it to copy whatever users are on  
> the generating system into the image?

If daemons we want/need to start want to drop privleges... yes.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
