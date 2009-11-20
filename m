From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] switch_root: a better approach to subroots
Date: Fri, 20 Nov 2009 15:30:17 +0100
Message-ID: <20091120143017.GA29950@nb.net.home>
References: <20091118153312.16E989D404F@zog.reactivated.net> <20091118184706.GB23977@nb.net.home> <4B045586.1090906@redhat.com> <20091118153312.16E989D404F@zog.reactivated.net>
Mime-Version: 1.0
Return-path: <util-linux-ng-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091118153312.16E989D404F-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: util-linux-ng-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: util-linux-ng-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, Nov 18, 2009 at 03:33:12PM +0000, Daniel Drake wrote:
> This reverts commit a692a8745941a192528c5e2a05de97155ba586f9.

 Revered and man page updated. switch_root does not support subroots
 from now.

On Wed, Nov 18, 2009 at 03:13:58PM -0500, Peter Jones wrote:
> On 11/18/2009 01:47 PM, Karel Zak wrote:
> > On Wed, Nov 18, 2009 at 03:33:12PM +0000, Daniel Drake wrote:
> >> +.SH NOTES
> >> +switch_root will fail to function if
> >> +.B newroot
> >> +is not the root of a mount. If you want to switch root into a directory that
> >> +does not meet this requirement then you can first use a bind-mounting trick to
> >> +turn any directory into a mount point:
> >> +.sp
> >> +.nf
> >> +.RS
> >> +mount --bind $DIR $DIR
> > 
> >  Cannot we add this functionality directly to the switch_root command?
> >  I mean call:
> > 
> >     mount --bind /newroot/subroot /newroot/subroot 
> >     mount --move /newroot/subroot /
> > 
> >  Now we have:
> > 
> >     mount --move newroot /
> >     chroot /newroot/subroot
> 
> That certainly seems preferable to reverting the patch, especially if, as

 I agree. People (IMHO OLPC project only) who need subroots can easily
 add "mount --bind" to their initrd. 

    Karel


-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe util-linux-ng" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
