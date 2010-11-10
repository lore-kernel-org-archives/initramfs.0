From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Wed, 10 Nov 2010 16:32:27 +0000
Message-ID: <20101110163227.GS19612@vostochny.stro.at>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com> <4CD9102B.7030702@bfh.ch> <AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu@mail.gmail.com> <20101109125820.GO19612@vostochny.stro.at> <AANLkTinfZNiQ14XD3OAC8WasnGXi6bcD9WJipvKS0f1S@mail.gmail.com> <20101109140028.GP19612@vostochny.stro.at> <AANLkTi=Mc4qBA7yhExb2VCCGyMNCXq+k9BZ=JhZpN4GE@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=Mc4qBA7yhExb2VCCGyMNCXq+k9BZ=JhZpN4GE-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Nov 10, 2010 at 05:21:41PM +0100, Jon Ander Hernandez wrote:
> By now an upgraded version of the patches as a single patch :

ok, this look good to me at first sight.

Please make sure to build this dracut in a chroot
(use sbuild or pbuilder or whatever suits you) in order
to check that it really autobuilds on upload.

thanks.

Acked-by: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
