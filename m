From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Add support for bringing up multipath root devices [version 2]
Date: Wed, 25 Nov 2009 10:25:48 -0500
Message-ID: <1259162752-22372-1-git-send-email-pjones@redhat.com>
References: <4B0D4A9F.1090606@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B0D4A9F.1090606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

This patch series adds support for bringing up the root device when it's
on a multipath device.  It suplements the current multipath support which
is provided by device-mapper-multipath by adding logic to scan for
multipaths as configured in multipath.conf .

This revision includes changes suggested by Hans De Goede.
