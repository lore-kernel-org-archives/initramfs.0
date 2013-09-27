From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [RESEND] Implement ACPI table overriding via initramfs
Date: Fri, 27 Sep 2013 20:10:36 +0200
Message-ID: <1380305440-63843-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org

Modification to the first series:
  - Add
    Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
  - Add ACPI table override documentation

Would be great if these can get pushed in.

Thanks,

      Thomas

[PATCH 1/4] dracut: Generlize microcode early cpio usage
[PATCH 2/4] dracut: Do not create early_cpio if no suitable
[PATCH 3/4] dracut: Implement ACPI table overriding
[PATCH 4/4] dracut.conf.5.asc: Add ACPI table override and
