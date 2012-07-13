From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Further specfile changes
Date: Fri, 13 Jul 2012 15:33:55 +0200
Message-ID: <201207131533.56617.trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Frederic Crozat <FCrozat-IBi9RG/b67k@public.gmane.org>

Hi,

this is a patch of a modified working Version 020 specfile,
diffed against latest git specfile (with my changes I sent today
already applied).

I guess the systemd changes in the %file section can be ignored
and are version 20 -> master changes.

The rest is more or less necessary to get dracut building on
the openSUSE Build Service and it would be great to get these
changes into the mainline repo in some form.

I do not know what dash is and some other parts I am not sure
whether they are needed or not.
If somenone could review these changes, the I would submit
these changes in logical, tiny portions to get them in.

Thanks,

  Thomas
