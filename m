From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH] vconsole: properly set terminal UTF-8
 mode
Date: Fri, 18 Feb 2011 09:13:33 +0100
Message-ID: <4D5E2A2D.4060703@redhat.com>
References: <1288967715-3513-1-git-send-email-arvidjaar@gmail.com>	<AANLkTik9bv1U5_y6QV1jCJB5mj-DT3zZUucdsVmo+6Vy@mail.gmail.com>	<AANLkTi=GFHnhnagJ-7ZfGB62oQxVeT+YOZH003CA16Rf@mail.gmail.com>	<AANLkTi=_uDMFudNq4+jcojgGgoKvU0f2ySb+_7fTaZj7@mail.gmail.com>	<AANLkTi=8q8K3ST5_QXyHQuUCM=W0u060wcBmBRRBWm+9@mail.gmail.com>	<20101110224457.GE319@tango.0pointer.de> <AANLkTinvswsHGgEjnLf_dF+RPvc8pZH+Ku+o-2guyzsa@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinvswsHGgEjnLf_dF+RPvc8pZH+Ku+o-2guyzsa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Am 17.02.2011 19:52, schrieb Andrey Borzenkov:
> As it stands now, dracut 008 in generic (not hostonly) mode explicitly
> disables UTF-8 because UNICODE is not set:
> 
> modules.d/10i18n/console_init:
> 
> set_keyboard() {
>     local param
> 
>     [ "${UNICODE}" = 1 ] && param=-u || param=-a
>     kbd_mode ${param}
> }
> 
> The problem is, you do not know whether UNICODE is not set because
> system is configured for non-UNICODE or because we do not know yet.

You are right... UNICODE should default to 1 in dracut. Will change.
