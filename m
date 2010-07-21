From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: patches
Date: Wed, 21 Jul 2010 13:33:05 +0200
Message-ID: <4C46DAF1.1090603@redhat.com>
References: <201007140205.35944.maarten.vanraes@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201007140205.35944.maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/14/2010 02:05 AM, Maarten Vanraes wrote:
> Hi,
>
> Here are some patches, some that were used as patches in the mandriva builds,
> and a first one from me, to fix nfs hostonly on chrooted installs.
>
> Kind regards,
>
> Maarten Vanraes

-[ "$1" = "-h" ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && exit 1
+[ "$1" = "-h" ] && ! egrep -q '\s/\s+nfs[34]?\s' /etc/fstab && exit 1

Hmm, I think "hostonly" should be really "hostonly", so the check is valid.

You can always force the addition of nfs, if you are building a special image 
for an NFS client. Or just boot with the generic (non-hostonly) one, and build 
the hostonly one on the client.
