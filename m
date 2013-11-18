From: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] deb-pkg: Inhibit initramfs builders if
	CONFIG_BLK_DEV_INITRD is not set
Date: Mon, 18 Nov 2013 15:09:20 +0100
Message-ID: <20131118140920.GA31395@pobox.suse.cz>
References: <1384484605.2771.13.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384484605.2771.13.camel-nDn/Rdv9kqW9Jme8/bJn5UCKIB8iOfG2tUK59QYPAWc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Cc: Petr Baudis <pasky-+ZI9xUNit7I@public.gmane.org>, linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Lange <lange-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Nov 15, 2013 at 03:03:25AM +0000, Ben Hutchings wrote:
> The kernel postinst hook for initramfs-tools will build an initramfs
> on installation unless $INITRD is set to 'No'.  make-kpkg generates a
> postinst script that sets this variable appropriately, but we don't.
> Set it based on CONFIG_BLK_DEV_INITRD.
> 
> This should also work with dracut when <http://bugs.debian.org/729622>
> is fixed.
> 
> Signed-off-by: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
> ---

Applied to kbuild.git#misc, thanks.

Michal
