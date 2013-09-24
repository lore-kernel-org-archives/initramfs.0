From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Implement ACPI table overriding via initramfs
Date: Tue, 24 Sep 2013 19:02:54 +0200
Message-ID: <1380042177-66221-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This code generalizes the early_cpio parts of the early microcode
implementation.
Then the acpi table overriding parts are added in the last patch.

Successfully tested.

Please consider to apply if people agree with the code.

Thanks,

        Thomas

[PATCH 1/3] dracut: Generlize microcode early cpio usage
[PATCH 2/3] dracut: Do not create early_cpio if no suitable
[PATCH 3/3] dracut: Implement ACPI table overriding
