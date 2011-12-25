From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4 branch usrmove] add ssh client module
Date: Sun, 25 Dec 2011 12:11:11 +0000 (UTC)
Message-ID: <jd73sv$rf9$4@dough.gmane.org>
References: <20111223080416.GA12662@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi,
>
> This is a ssh-client module for dracut. The first user could be kdump
> because kdump need to scp vmcore to remote machine.
>

Nitpick: why not call it "ssh" module instead of "ssh-client" module?

>
> I rebased his patch to usrmove branch of Harald, post along with ssh patches
>

I will pick your patches into my tree, because:

1) So that we can test them as a whole
2) Both your patches and mine are mainly for kdump
3) Harald is on vacation these days

my tree is located at:

  git://github.com/congwang/dracut.git #kdump

Thanks.
