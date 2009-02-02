From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Current status of dracut.
Date: Mon, 2 Feb 2009 14:50:09 -0500
Message-ID: <20090202195008.GA23229@redhat.com>
References: <20090202163708.GA27474@redhat.com> <20090202165736.GB29131@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090202165736.GB29131-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Monday, February 02 2009, Dave Jones said:

> On Mon, Feb 02, 2009 at 11:37:08AM -0500, Dave Jones wrote:
>  > Things that still need doing include, but are not limited to..
>  > 
> 
> A few more things..
> 
> The current Fedora mkinitrd generates initrds in the ~3MB range.
> A dracut generated image is ~17MB.

17?  I'm seeing along the lines of 7 on my box

> The TODO in the git for some other pointed questions.
> 
> * NetworkManager vs dhclient for network based roots.
>   I think the latter makes more sense, otherwise we end up
>   sucking hal and all its dependancies into the image too.
>   When the real rootfs starts up NM it should be able to dtrt.

The reason to use NetworkManager is so that the same configuration
engine, etc can be used as on the real system.  Otherwise, we're
Inventing Something Else (tm).

That said, I don't think that NetworkManager or its stack of deps are to
where they can sanely be used in the initramfs yet and it may be quite
some time before they are.
 
> * selinux policy loading.
>   I don't think there's any real reason this has to be in the initrd.
>   Though it means that either upstart or whatever init you use has to
>   do it, or your /sbin/init needs to become

Right.  /sbin/init had it with sysvinit, but Scott was against adding it
in upstart.  Feel free to restart that discussion

> Finally, the udev rules currently in dracut are kind of hacky.
> It'd be good to just have a set of rules provided by the
> system udev that we can drop in there.

Yep.  Kay and I had a very brief discussion about it before the
holidays.  And, eg, the dm/lvm rules that are there are almost entirely
there because those tools don't ship sane rules themselves.  If they
did, we could just suck them in.

I do think that there needs to be /lib/udev/initrules.d or similar to
say "these rules matter for booting" as opposed to the full set of rules
in /lib/udev or the hard-coded list of rules files currently present

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
