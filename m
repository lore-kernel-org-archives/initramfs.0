From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/6] Allow to add mount points even not in hostonly mode
Date: Fri, 13 Jan 2012 11:25:30 +0100
Message-ID: <4F10069A.40002@redhat.com>
References: <1324361401-6908-1-git-send-email-amwang@redhat.com> <1324361401-6908-2-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1324361401-6908-2-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 20.12.2011 07:09, Cong Wang wrote:
> From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Don't force --mount only working in hostonly mode, let users decide.
> With this patch, people can still combine -H --mount '...' if they
> want to use it in hostonly mode.
> 
> Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  dracut |   77 +++++++++++++++++++++++++++++++--------------------------------
>  1 files changed, 38 insertions(+), 39 deletions(-)

applied
