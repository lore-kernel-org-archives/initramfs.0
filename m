From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: dracut broken on Fedora 10 (udevd)
Date: Mon, 01 Jun 2009 01:17:11 -0400
Message-ID: <1243833431.3844.4.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Victor, commit 5033486389038516acc04403e9e2c3ba9653a98e broke dracut on
F10, as the udev there does not understand the --resolve-names option.

Perhaps we can find a way to let dracut populate /etc/passwd
and /etc/group with some default user/group names to satisfy older
udevs? I realize this is a workaround for older utilities, so I don't
expect anyone to go for it, but I'll ask anyways.

I need an 'rpc' user for rpcbind anyways, so we could just put dummies
in for that, since I don't care who really owns that data -- it'll be
thrown away anyways.

Thanks,
Dave

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
