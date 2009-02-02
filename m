From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Current status of dracut.
Date: Mon, 2 Feb 2009 11:57:36 -0500
Message-ID: <20090202165736.GB29131@redhat.com>
References: <20090202163708.GA27474@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090202163708.GA27474-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Feb 02, 2009 at 11:37:08AM -0500, Dave Jones wrote:

 > Things that still need doing include, but are not limited to..
 > 

A few more things..

The current Fedora mkinitrd generates initrds in the ~3MB range.
A dracut generated image is ~17MB.
At least part of this problem is that we're including a ton of kernel
modules.  We could probably be smarter about our initial selection,
and trim out the really unlikely cases.
I think it's safe to say no-one cares about root on i2o for example.

The TODO in the git for some other pointed questions.

* NetworkManager vs dhclient for network based roots.
  I think the latter makes more sense, otherwise we end up
  sucking hal and all its dependancies into the image too.
  When the real rootfs starts up NM it should be able to dtrt.

* selinux policy loading.
  I don't think there's any real reason this has to be in the initrd.
  Though it means that either upstart or whatever init you use has to
  do it, or your /sbin/init needs to become

  #!/bin/sh
  /usr/sbin/loadpolicy
  /sbin/realinit

Thoughts?

Finally, the udev rules currently in dracut are kind of hacky.
It'd be good to just have a set of rules provided by the
system udev that we can drop in there.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
