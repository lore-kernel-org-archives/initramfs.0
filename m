From: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Subject: Re: Dracut NFS root rw before pivot but ro after pivot
Date: Tue, 05 Oct 2010 17:48:17 +1100
Message-ID: <20101005174817.98833aq1pzqn2cds@webmail.zoltak.com>
References: <20101005124250.12811x7b1hr8g23k@webmail.zoltak.com>
 <20101005165245.12962kslvxq6cmyo@webmail.zoltak.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101005165245.12962kslvxq6cmyo-2RFepEojUI3Y3UUic/vCjNBPR1lH4CV8@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> Quoting daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org:
> I'm running Gentoo. Just wondering if dracut is meant to start  
> rpc.statd before Gentoo does?
>
> I've set rpc.statd to start however I think it needs to start prior  
> to the Root filesystem mounting.

I have determine the NFS mount is rw until udev runs!

Does anyone know how to debug this?
