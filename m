From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] rootfs-block: avoid remount when options don't change
Date: Thu, 19 Apr 2012 12:14:24 +0200
Message-ID: <4F8FE580.5010506@redhat.com>
References: <20120411220043.883609D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120411220043.883609D401E-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 12.04.2012 00:00, schrieb Daniel Drake:
> Mounting, unmounting and then mounting a disk partition takes some
> time.
> 
> On embedded systems such as OLPC XO where we disable fsck and fstab
> reading, the root options are not going to change throughout the
> mount_root() function, so remounting is time consuming and without
> change.
> 
> Detect and optimize for this case so that the filesystem is only
> mounted once.
> ---
>  modules.d/95rootfs-block/mount-root.sh |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 

pushed
