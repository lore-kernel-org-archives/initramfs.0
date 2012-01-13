From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Q: mount initramfs as the final root fs
Date: Fri, 13 Jan 2012 17:00:53 +0000 (UTC)
Message-ID: <jepo04$nc5$1@dough.gmane.org>
References: <CAADET=cG8mdu-Je_MUGyKOP_G9sfU6sR3KHxybFMREjvexrKmg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 12 Jan 2012 at 00:54 GMT, David Li <w.david.li-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Everyone,
>
> I need to let the kernel to mount the initramfs (created by dracut)
> as the final root filesystem. No disk and no NFS either!
>
> I tried kernel option root=/dev/ram0 (the initrd way to mount init ram
> disk) but dracut didn't recognize this option. What should I use to
> accomplish this?
>

AFAIK, drauct doesn't support this currently. Think about that, who
will mkfs your /dev/ram0? Dracut has to do that if you want this
working. It would not be hard to make a patch for this, I think.

