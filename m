From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] auto setup network without netroot
Date: Mon, 30 Jan 2012 08:33:40 +0000 (UTC)
Message-ID: <jg5kl4$3qk$4@dough.gmane.org>
References: <20120130064305.GA7108@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 30 Jan 2012 at 06:43 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Current dracut network only will be setup when netroot is used. But there are
> some cases we need network even without netroot. For example kdump will need
> copy vmcore to remote machine via scp or nfs mount. OTOH, if we use dracut as
> a recovery system the network is helpful even root is not a network device.
>
> This implementation is based on the manually bring up method. Here add a kernel
> cmdline argument rd.neednet. If rd.neednet is set dracut will bring up network
> with ifup $INTERFACE -m. If netroot is used we still keep original behavior.
>

I don't think we really need to introduce a new cmdline, I think we
can re-use ip= cmdline. Currently, if ip= is specified but netroot is
not, ip= will be ignored. We can change this, let dracut bring up
network as long as we have ip=, even we don't have netroot.
