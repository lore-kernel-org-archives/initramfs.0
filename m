From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Mon, 8 Nov 2010 21:27:53 +0000
Message-ID: <20101108212753.GL19612@vostochny.stro.at>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Nov 08, 2010 at 07:50:59PM +0100, Jon Ander Hernandez wrote:
> Hello,
> 
> I post the patches as I promised :-)
> 
> - When a new kernel is installed or uninstalled dracut based initramfs
> is not automatically created/deleted. Ubuntu's kernel package's post
> script executes update-initramfs directly, and the update-initramfs
> trigger is never fired.
> Another solution is to install a postinst and a postrm script under
> /etc/kernel/{postrm.d,prerm.d}.
> 
> http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_kernel_prerm_postinst.diff

please send such patches inside of an email, aboves is pointless.

thanks.
