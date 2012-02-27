From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: Testers wanted: dracut lazy install with cpio
Date: Mon, 27 Feb 2012 13:55:34 -0800
Message-ID: <4F4BFBD6.9050908@bitwagon.com>
References: <4F4BA634.5070804@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4BA634.5070804-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> $ time sudo make testimage
> $ time sudo make hostimage
> 
> Both with and without the patch.

I get (for Fedora 16):

            with patch (lazy)     without patch
   testimage:  24.3 real            25.8 real
               30.2 user            30.7 user
                4.5 sys              4.9 sys

   hostimage:   8.4 real             9.3 real
                8.1 user             8.4 user
                1.5 sys              1.9 real

Did the cpio run in parallel?  cpio reads from a pipe just fine.

cpio needs enhancement: a flag argument for "no overwrite",
and another for "clone the ownership and permissions on
created directories" [else a copied path "a/b/c/d/e" which
must create any of a, b, c, or d will not reproduce the
existing ownership and permissions on those directories.]

-- 
