From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut modules
Date: Fri, 25 Jun 2010 15:58:23 +0200
Message-ID: <4C24B5FF.7040803@redhat.com>
References: <loom.20100624T143213-57@post.gmane.org> <4C24911F.4010503@redhat.com> <loom.20100625T153101-235@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20100625T153101-235-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Stone <fsck1234-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/25/2010 03:53 PM, Dave Stone wrote:
> One other question when using rdloaddriver=<drivername>  at what stage of boot
> process does this driver gets loaded?

In the beginning, before udev is started.

>
> Regards,
> -Dave
>
