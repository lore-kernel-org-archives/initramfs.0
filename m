From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH v2 01/15] Documentation: add newcx initramfs format
 description
Date: Fri, 26 Jan 2018 16:15:13 -0200
Message-ID: <20180126181512.hnotac2lpxkj4ruv@khazad-dum.debian.net>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
 <1516850875-25066-2-git-send-email-takondra@cisco.com>
 <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
 <0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
 <20180126103132.7szs5lj5ppm7eyy6@khazad-dum.debian.net>
 <alpine.LRH.2.00.1801260739120.8259@sjc-ads-6991.cisco.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=NJf2f0Upq0CAamppuwilhVef/PhApJxPh+LJtE3oLGU=; b=hkxheyaK
        gcDFev/ok7+8W/xGRb0M+tgfJ/1WvFmrFquXiAMIdE5zmPKt77GyHu2pyfSfMGDr
        yTch2A2i+SRRRipziHFErjTUoIXul71tCccbLUGgOWkQkAuLkJwAAOe74wRY2VI8
        MI7w5wAg+3eP45lRTc5738LTOmvs3eVPjDaitAgP+crtHPiKSeIWSL7s9/c9bAz9
        gdTsAE5ntujWlYgB8MAk1xdWLaMzaj5syMw0Ha7tU19HaOG0995eVdifkGPmNvyi
        F3IVfWAUkgUlgx7c8gY5ZXA/hoIuOgWreFsDSze9RJWtqWQqTdXjhUuouECuC3rb
        ZoQ0+iDWgJEM3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=NJf2f0Upq0CAamppuwilhVef/PhAp
        JxPh+LJtE3oLGU=; b=W7Dm3v5wiOxGoSs0Y5wI1jyfsLN2htFKbvstl/J713vcC
        XD+EqzSeMX7QOpy74rs6SgEv9XBcZUTlHCpjY8mhoLGeglL+xYPnRNz3pLETGGtf
        hed7uKEvQZiN9zbRuD8s9PxGgdDsTwJ/3+8oEMUqeB4zepQUC9Mu4atw9NUZwJGE
        zA6+r/LkUUYE3IDcN70Jrej6rWxJjFouH58zPyTZHB6vJHSg6n6bldsxDelZueT/
        EXQqaAEL/8vqbs//bdRk4sALYlxDE56uzVWRNb41NYiGRTvmXis63Ai+WWBJoUAR
        TsySlVnimYXSGbkORN3WecMGPA64u4hY05fT6tGOQ==
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1801260739120.8259-fZ7xe+6E5F8pLdfb+Kaa2CW4+XlvGpQz@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, James McMechan <james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LSM List <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, xe-linux-external-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org


On Fri, 26 Jan 2018, Victor Kamensky wrote:
> On Fri, 26 Jan 2018, Henrique de Moraes Holschuh wrote:
> > On Thu, 25 Jan 2018, Rob Landley wrote:
> > > That said, I don't think -h newcx should emit (or recognize) the
> > > "TRAILER!!!1!" entry. That's kinda silly in-band signaling for 2018:
> > > files have a length, pipes provide EOF, and each cpiox entry starts with
> > > 6 bytes of c_magic anyway.
> 
> My understanding that TRAILER is really used on tape devices,
> there is no notion of file end in this case, it is just a stream of bytes
> from char device.

TRAILER is really used anywhere you can have several cpio archives
concatenated, which is the exact case of a Linux initramfs, not just
tape.

The initramfs format takes *one or more* cpio archives, concatenated.
Each archive may be independently compressed (using whatever supported
compression method), or uncompressed[1].  EOF or size information can
only tell you where the entire concatenated archive ends, not where each
"segment" (independent cpio archive that was concatenated into the
whole) ends.

TRAILER is the only decent way to know the concatenation points.
Knowing where these points are is necessary for the kernel, due to the
way hardlink encoding is done on cpio archives: one has to reset the
state of the hardlink-tracking table between cpio archives that were
concatenated, for safety (and sysadmin sanity) reasons.

[1] for the special case when one includes an "early initramfs" section
for firmware (microcode, etc) updates, the archive(s) containing the
firmware data must be uncompressed, and these archives must come before
compressed archives in the concatenation.

-- 
  Henrique Holschuh
