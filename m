From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Current status of dracut.
Date: Mon, 2 Feb 2009 11:37:08 -0500
Message-ID: <20090202163708.GA27474@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Things have gotten a little quiet on this front lately, so I thought
I'd drop a state-of-dracut report, and see if that spurs some discussion.

The current code at git://fedorapeople.org/~katzj/dracut.git
is just over 600 lines of shell script, and manages to generate an
initramfs capable of mount root filesystems on raw disk (/dev/sda etc),
and lvm (/dev/mapper/..)

It's also capable of encrypted root, using the plymouth graphical
stuff we have in Fedora.  As can be noted in the FIXME's, this is
currently hardcoded.

If for some reason the root fs cannot be mounted, it drops you
to a bash shell with some tools that may be useful for diagnostics.

Things that still need doing include, but are not limited to..

- thaw from hibernate support
- root on mdraid/dmraid
- get switchroot into util-linux (then nash can die forever)
- test generated initramfs works on other distros
  It'd be great to hear feedback on how people get on trying out
   what's there so far.
  There's definitly still some redhat'isms in there (*cough* libexec *cough*)
  that need to be conditionalised or eradicated.
- network root (nfs/nbd/iscsi)
- get 'make initrd' in the kernel
  My thinking on this one is to get something included fairly soon
  .30/.31 timeframe that just supports the disk based roots,
  and worry about network root later.
  At ~600 lines, it's fairly easy to come up to speed on it quickly.
  As it gets more featureful, this won't be the case.
  Also, going to lkml with "here's a few thousand lines of shell, please merge"
  probably isn't going to be met with a warm reception.

  One noticable change in development after this happens will be new
  changes going into a kernel git tree, instead of dracut.git
  It may still be useful to have the same changes going into a standalone tree,
  but I'll think that over some more when it happens.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
