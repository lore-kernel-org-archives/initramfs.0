From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut now in Gentoo
Date: Tue, 29 Sep 2009 19:29:55 +0200
Message-ID: <4AC24413.7080506@redhat.com>
References: <4AC2379F.2080409@osuosl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AC2379F.2080409-CJG/fkoVOTIdnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lance Albertson <lance-CJG/fkoVOTIdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/29/2009 06:36 PM, Lance Albertson wrote:
> I recently attended Linux Plumbers Conf and saw Harald's talk on dracut
> which got me interested in getting it into Gentoo. I just committed a
> working ebuild for the latest version into the tree [1]. We had to make
> a few patches in order to get it to work for us, so I created a branch
> of the patches on github [2] for you guys to look at. If you prefer, I
> can send the patches directly here. I wasn't the original author for
> some of the patches, but you can see the discussion in the original bug
> [3]. Specifically 3649a19207 needs some more work to make it more distro
> agnostic.
>
> I tested an image on a Gentoo machine and it worked but I haven't fully
> tested all of the capabilities yet (I'm planning on doing that soon). If
> you have any comments or suggestions for the Gentoo package, please
> direct them to me since I'm the new maintainer.
>
> Cheers-
>
> [1] http://packages.gentoo.org/package/sys-kernel/dracut
> [2] http://github.com/ramereth/dracut/tree/gentoo-002
> [3] http://bugs.gentoo.org/show_bug.cgi?id=278442
>

Very nice, I will try merge your changes from the git :)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
