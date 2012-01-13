From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH usrmove branch] fstab-sys: mount it in initramfs instead
 of newroot if mount point is not found
Date: Fri, 13 Jan 2012 11:51:09 +0100
Message-ID: <4F100C9D.5080408@redhat.com>
References: <20120112080031.GA32416@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120112080031.GA32416-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12.01.2012 09:00, Dave Young wrote:
> fstab-sys now also handles device passed by dracut argument "--mount"
> The "--mount" mount point is possible not exist in $NEWROOT. Thus mount it
> in initramfs if mount point is not exist in real rootfs
> 
> ---
>  modules.d/95fstab-sys/mount-sys.sh |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

applied
