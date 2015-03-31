From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: hostonly driver/modules specifics
Date: Tue, 31 Mar 2015 15:18:30 +0100
Message-ID: <CALeDE9MSONADNxkow4QYNZBXZfv5vgAOOSHD_7t-Cbc5TQq2Hw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=89IGNu4stX8WP3QZcaBgVPNGstMZZsyTJXfiiI0DWlM=;
        b=TGEXpItRDF8peXtuczaPYKXM11MQrB1xNhNslMItTTA56Y5iHeSHPFlQ8tnGfjr2vK
         1MUVQyz2mPYjZLaGFg9bhYQvMnWmdPbLa2/90zt8eoH0t4bR4HAejEXIuv/nBSSkYvFh
         m5LKoovjS18rVqGRjR89ftZKTbVDN4RybwbOSdYznQfzO6puO/qnimbWhFE6LZwiA2+P
         mktxSYJFOf9Mjre+a7pnARvYYMxfNarIrMDARy0Bs1M3DwA62u3dGgiKrvDAWTbI1tW3
         PaA+PgoCygTg8GKW7SIQ23MGs0kTw6wY9yRDwh3baDFn0IDOYeh1oyhn2FshlZ4YXW2E
         E4xw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi All,

I spent some time digging through dracut repo and google looking for
this answer but never managed to get to the bottom of it.

When doing a host specific initrd a bunch of modules (input, display,
storage, network) and their deps/firmware for core boot are pulled in.
While I see how this works for generic (and have even sent patches)
I'm unsure and can't seem how this is defined for a host specific
initrd.

I see some functions that delve down to work out the storage side of
things but nothing generic for say network/input/display and how you
might possibly extend that. I've got a couple of possible use cases
where I'd like to have a play to extend this (eg usb device mode for
virtual serial/net over usb-g) and while I have bits of it working I
spent a bunch of time last night going down a rabbit hole for host
specific initrd and didn't really come out the other end much more
enlightened so was hoping someone could point me in the right
direction for where the definitions for "ensure this type of host
specific infra module is included in the initrd if there is one
available" are hidden (likely in plain view).

Cheers,
Peter
