From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] lib: Add early cpio decoder
Date: Tue, 04 Sep 2012 10:00:09 -0700
Message-ID: <50463399.70506@zytor.com>
References: <1346318957-5831-1-git-send-email-trenn@suse.de> <1346318957-5831-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346318957-5831-2-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vojcek-wYtBgQxc//8@public.gmane.org, eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

On 08/30/2012 02:29 AM, Thomas Renninger wrote:
> From: "H. Peter Anvin" <hpa-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>
> Add a simple cpio decoder without library dependencies for the purpose
> of extracting components from the initramfs blob for early kernel
> uses.  Intended consumers so far are microcode and ACPI override.
>
> Signed-off-by: H. Peter Anvin <hpa-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> CC: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> Link: http://lkml.kernel.org/r/201203261651.29640.trenn-l3A5Bk7waGM@public.gmane.org
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

I was trying to figure out if there is a way to do what you want 
(support for multiple files) without the problems of the callback 
interface.  I think it is actually fairly straightforward; we need a 
prefix iterator (so you can give it a string like "kernel/acpi/" rather 
than a full filename) and it needs to be able to accept a "last" pointer 
so it can resume scanning at the point it last left off.  That should be 
a pretty trivial change.

The other thing we presumably want to do -- and this is generic -- is to 
be able to handle multiple sources for the initramfs; at the very least 
there is built in vs provided from the boot loader.  I had originally 
intended to just handle that by calling the earlycpio function once per 
block, but the "last left off" bit makes that a little harder.  Need to 
think about that a little bit.

I am guessing that this may not need to be something we need from the 
very beginning, or am I wrong?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
