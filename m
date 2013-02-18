From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/2] add parameter continue_on_fail
Date: Mon, 18 Feb 2013 11:29:11 +0100
Message-ID: <51220277.1010507@redhat.com>
References: <cover.1361167889.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1361167889.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 18.02.2013 07:21, schrieb Baoquan He:
> v1->v2:
>     Discard previous implementation, take a direct and simpler
>     method.
> 
> By adding pamameter 'continue_on_fail=initqueue|mount_root',
> user can decide if continue after these points timeout. And
> can extend to other delay or loop point later if needed.
> 
> Baoquan He (2):
>   Add parameter continue_on_fail to make dracut continue after
>     initqueue timeout
>   Continue when mount rootfs failed by specifing
>     'continue_on_fail=mount_root'
> 
>  dracut.cmdline.7.asc                    |    3 +++
>  modules.d/98systemd/dracut-initqueue.sh |   10 ++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Why don't you just remove all "finished" scripts and install your own "finished"
checking scripts, when your kdump device is ready?
