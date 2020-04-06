From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Date: Mon, 6 Apr 2020 10:47:38 +0200
Message-ID: <20200406084738.GA2520@zn.tnic>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan>
 <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan>
 <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586162863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LtQeVXhd6t1VNfge4oRaGKt5hUgdeZfgTsbHMVc4gxI=;
        b=T6JsH00Bl/7vxIiN+7jxEKxwrZtDHcvOIuls/u6wabFbREOPT8cntND7Nq1pMhie5G5Uvv
        pI9pNanN0F+G7ajsjHG4QdQwl7iRAnzzQm41lPZBVFefHLTve7GSgkZ1WcrarQh8PAouPt
        WkQXUGp6jehPSDYnfAqYglHTSz+lmHM=
Content-Disposition: inline
In-Reply-To: <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Sergey Shatunov <me@prok.pw>, hpa@zytor.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>, initramfs@vger.kernel.org, Donovan Tremura <neurognostic@protonmail.ch>, Harald Hoyer <harald@hoyer.xyz>

On Mon, Apr 06, 2020 at 09:32:47AM +0200, Ard Biesheuvel wrote:
> The EFI handover protocol strikes again :-(
> 
> It seems we did not include any guidance in the documentation in
> Documentation/x86/boot.rst regarding zero-initializing BSS, and come
> to think of it, we don't include any other requirements either, i.e.,
> regarding placement wrt section alignment etc. This is a serious bug.
> Even though EFI usually lays out PE/COFF images in files the exact way
> they appear in memory, this is not actually required by the spec. Most
> notably, the virtual size can be smaller than the file size, and the
> loader is expected to zero-initialize the difference as well.

Is that expectation stated explicitly somewhere?

> Since the EFI handover protocol should be considered deprecated at
> this point (and is never going to be supported in upstream GRUB
> either, for instance), I would recommend the systemd-boot developers
> to start looking into deprecating this as well, and switch to the
> ordinary PE/COFF entry point, and use the new initrd callback protocol
> for initrd loading.

Any pointers to that new initrd callback protocol?

In any case, I'd really appreciate a patch to boot.rst formulating those
requirements so that they're written down and people can find them.

> On the Linux/x86 side, we should at least add some code to the EFI
> handover protocol entry point to zero initialize BSS, and ensure that
> it is either not needed in other places, or add the code to deal with
> those as well.

Sounds like a simple fix, if that would fix it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
