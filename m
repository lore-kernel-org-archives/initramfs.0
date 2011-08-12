From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: small updates for dmsquash-live module
Date: Fri, 12 Aug 2011 08:06:33 +0200
Message-ID: <4E44C2E9.3080201@redhat.com>
References: <1312230069-10674-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312230069-10674-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01.08.2011 22:21, Will Woods wrote:
> These are just some smallish updates for dmsquash-live.
> 
> Patch 1/3 is just a few cleanups - inessential, but nice to have.
> 
> Patch 2/3 makes dmsquash-live-root determine the image type (i.e.
> squashed or unsquashed) by mounting it and checking the filesystem
> type, rather than requiring a specific filename. This is important for
> the livenet module (which will be appearing in a later email).
> 
> Patch 3/3 is simple and useful - it adds a pre-pivot hook which will
> copy any files found in /updates in the initramfs into the live
> filesystem. This allows hotfixes to live images. Whee!
> 
>  modules.d/90dmsquash-live/apply-live-updates.sh |    7 ++++++
>  modules.d/90dmsquash-live/dmsquash-live-root    |   27 ++++++++++++++--------
>  modules.d/90dmsquash-live/module-setup.sh       |    1 +
>  3 files changed, 25 insertions(+), 10 deletions(-)
> 
> -w
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

pushed
