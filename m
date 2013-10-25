From: EatDirt <dirteat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Fri, 25 Oct 2013 16:40:17 +0200
Message-ID: <l4dvs8$g48$1@ger.gmane.org>
References: <5253DD0C.7050506@redhat.com> <l4dk8e$fv8$1@ger.gmane.org> <526A7412.8030804@redhat.com> <l4dsjp$20r$1@ger.gmane.org> <526A80D9.4060907@gmail.com>
Reply-To: dirteat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <526A80D9.4060907-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 25/10/13 16:31, Harald Hoyer wrote:

>
> What's the output of:
>
> # readlink -f /sbin/init
>
> ??
>
readlink -f /sbin/init
/usr/lib/systemd/systemd

looks good; but usrmount does not get included (and is not banned in 
/etc/dracut.conf neither in /etc/drakcut.conf.d/*)
