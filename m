From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Add support for bringing up multipath root devices
Date: Tue, 24 Nov 2009 14:52:54 -0500
Message-ID: <1259092378-14143-1-git-send-email-pjones@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch series adds support for bringing up the root device when it's
on a multipath device.  It suplements the current multipath support which
is provided by device-mapper-multipath by adding logic to scan for
multipaths as configured in multipath.conf .
