From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: inst not installing library dependencies of shared objects
Date: Tue, 25 Jan 2011 03:59:28 +0100
Message-ID: <AANLkTimXftdnoFMyoHHKF3H4B+x46Hpf8tJbYBEz5QwC@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ew1WgaEOlCL+tvd/I0yYb0jBuba5TP6xeCbyj6IbmRc=;
        b=vl/EXPWjEokcQa14FDgFfGIiHywladHy60fV44EHT+yQOYxZKrEBgNgYkLaxLFeCkZ
         thnhKh4BrVYT/ID4vDuYxTiCBK1kQ3LcGFG6RloCRiMbPFioJHfMCZXSZcNblbZ6iKCK
         PjTvMR0wocfUTerrICgKCCrnOjncw4F/AkPzg=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I'm trying to add plymouth support to dracut on Ubuntu, and I'm having
some troubles because some files
(/lib/plymouth/{script.so,renderers/drm.so,...}) are not executable
(as Fedora does for example), and that makes inst not install some
libraries as libpng, libply-splash-graphics.so.2...

Any suggestions?

Thanks in advance,

JonAn.
