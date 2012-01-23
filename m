From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch] fix rpm build error after adding ssh-client module
Date: Mon, 23 Jan 2012 12:05:59 +0100
Message-ID: <4F1D3F17.5010006@redhat.com>
References: <1326207135-21594-1-git-send-email-xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326207135-21594-1-git-send-email-xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 10.01.2012 15:52, schrieb xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org:
> From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date:   Tue Jan 10 11:42:33 2012 +0800
> 
> This patch fixes the following error when building rpm,
>     
>       error: Installed (but unpackaged) file(s) found:
>        /usr/lib/dracut/modules.d/95ssh-client/module-setup.sh
>     
> Based on my kdump tree.
> 
> Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

pushed
