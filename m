From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] allow ifup bring up network manually even without
 netroot
Date: Tue, 10 Jan 2012 15:41:14 +0000 (UTC)
Message-ID: <jehm6n$7q8$1@dough.gmane.org>
References: <20111230083858.GA13018@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 30 Dec 2011 at 08:38 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> For kdump we need scp vmcore to remote machine, the nic to be used is
> not limited to netroot one. we need a feature for manually bringing up
>  network interface. Also it is useful for emergency shell with
> ssh-client for recovery or test purpose
>
> I implement this by adding one argument to ifup script, user can use
> `/sbin/ifup eth0 -m` to bring up eth0, note ifup will regard it a
> manual operation for the nic specified in 1st argument if there's
> the 2nd argument.
>
> If same nic is used for netroot the 2nd argument will be ignored,
> in this case we will leave netroot bring up it automatically to
> avoid side effect. And in this case hooks such as kdump will need to
> execute after netroot mounted.
>
> `ifup eth0 -m` will create /tmp/net.eth0.manualup stamp file,
> later dhclient-script can check this and pass $2 to netroot,
> then netroot script will bring eth0 up
>

As we talked on IRC, we still need to discuss if this is really
needed, from kdump perspective. If we need to invoke `ifup` by
ourselves, then we also need to determine which NIC we should bring
up, this will make kdump code larger.

So, I hope, we can have some kernel cmdline (like ip=...) to tell
dracut which NIC we want to bring up in the second kernel, provided by
either ssh-client module or nfs module.

Let's see what Harald thinks...
