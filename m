From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] deal with nfs in fstab-sys
Date: Mon, 30 Jan 2012 08:20:03 +0000 (UTC)
Message-ID: <jg5jri$3qk$3@dough.gmane.org>
References: <20120130064451.GA7125@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 30 Jan 2012 at 06:44 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> If we need to mount nonroot nfs in fstab we also need to launch rpc processes
> Add nfs-start-rpc code, also do not check and fsck $_dev in this case

Isn't it nfs module's responsibility to call nfs-start-rpc code?
Why do you put it in fs-systab?
