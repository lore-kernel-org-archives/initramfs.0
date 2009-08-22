From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Thoughts on iscsi and nbd
Date: Sat, 22 Aug 2009 14:04:30 -0500
Message-ID: <FB23ED68-2646-41A7-9E59-66948A61E323@gmail.com>
References: <554CE824-C014-4C07-8449-5E868C0342EB@gmail.com>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:references;
        bh=814yT7k6+pDnGPDy5mRbP8/HztK/iyfO6BR6C33QN7c=;
        b=sKTKv2eKzZIcTXwTMr3llIXmcOtvkkwnrjZm3LkpeFO7hyTsWAu005QFAQdcGxA0LO
         s8knA7c6b/aJazh2EfN4nVdVmY+0DI3rsGuecjry4ma3BOpNMfGk3WYG7TKX2VJAXtr3
         iyMqiSS/KIcApSbTKQHX43/HUqRyWnPEvbx9s=
In-Reply-To: <554CE824-C014-4C07-8449-5E868C0342EB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Aug 22, 2009, at 1:56 PM, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>  
wrote:

> We seem to be doing them wrong -- going by the way we specify using  
> them on the kernel commandline, we appear to only support booting  
> directly to an iscsi or nbd lun, with no possibility of having an  
> lvm or luks layer on top of the iscsi transport.
>
> Am I missing some important doc or piece of code that implies  
> otherwise?

If I am not, it seems like the obvious fix would be to decouple root=  
handling from setting up block devices, and give iscsi and nbd their  
own kernel commandline parameters. This should also make handling  
multipathing with iscsi easier, because we can just pass multiple  
iscsi= parameters to bring up all the luns, and then let multipathing  
do it's thing.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
