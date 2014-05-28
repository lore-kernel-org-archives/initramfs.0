From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: Introduce --force-drivers parameter and force_drivers=+
 config option
Date: Wed, 28 May 2014 13:53:56 +0200
Message-ID: <5385CE54.3070009@redhat.com>
References: <2956069.N6upzrOyu5@skinner>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2956069.N6upzrOyu5@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07.05.2014 18:00, Thomas Renninger wrote:
> Which will not only add listed drivers, but also enforce that they are tried
>  to be loaded at early boot time.
> 
> This is needed if drivers which are not autoloaded (e.g. loop and a lot others)
> shall get loaded via initramfs.
> 

Hmm, loop should be autoloaded.

systemd-udev creates device nodes for all modules with the "devname:" alias:

$ modinfo -F alias loop
devname:loop-control
char-major-10-237
block-major-7-*

so the module loading is triggered on access to /dev/loop-control via losetup.

Which other modules do you have problems with?
