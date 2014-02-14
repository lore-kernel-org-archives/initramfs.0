From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add fsck passno to dracut --mount args
Date: Fri, 14 Feb 2014 11:05:54 +0800
Message-ID: <20140214030554.GA8125@dhcp-16-126.nay.redhat.com>
References: <20140212072229.GA15908@dhcp-16-126.nay.redhat.com>
 <20140213144222.GG30844@redhat.com>
 <52FCDBB0.8080509@redhat.com>
 <20140213150808.GH30844@redhat.com>
 <20140214024031.GE4225@dhcp-16-126.nay.redhat.com>
 <20140214025452.GG4225@dhcp-16-126.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140214025452.GG4225-je1gSBvt1TcFLmT5oZ11vB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> > > Ok, so you don't mind being passed in fs_freq and fs_passno as last fields
> > > of --mount option.
> > > 
> > > In that case, Dave can you please also post a patch to modify dracut to
> > > parse these fields and use default of "0 0" only if use did not pass those.
> > 
> > Sure, will do
> 
> Hmm, what Harald mentioned is already in dracut code. I think we only need to
> pass them in kdump module.

Rechecking it, dracut still need a fix to parse the extra options because it only
add "0 0" unconditionally.

The previous testing passed of this patch because dracut just regard the "0 2"
as mount options and later fstab-sys mount.sh parse the "2" as pass_no.

Thanks
Dave
