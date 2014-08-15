From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Adding support for read/write filesystem images
Date: Fri, 15 Aug 2014 12:26:51 +0200
Message-ID: <53EDE06B.80900@redhat.com>
References: <53DFAB14.1020201@mhtx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53DFAB14.1020201-rCS72UCksqc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Major Hayden <major-rCS72UCksqc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 04.08.2014 17:47, Major Hayden wrote:
> A user can provide a filesystem image (rootfs.img) inside a compressed
> tarball and that filesystem image will be mounted read/write.  This provides
> some benefits over a device mapper snapshot overlay, especially when the
> live system becomes full.  The boot command line simple needs
> "rd.writable.fsimg" added to utilize this feature.
> 
> Signed-off-by: Major Hayden <major-rCS72UCksqc@public.gmane.org>
> ---
>  modules.d/90dmsquash-live/dmsquash-live-root.sh | 16 ++++++++++++++--
>  modules.d/90dmsquash-live/module-setup.sh       |  2 +-
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 

Looks simple enough.

Can you add documentation to the man pages? And if you are really nice add
documentation about the other dmsquash parameters, too. :)
