From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Multithreaded programs crashing due to libgcc_s missing
Date: Tue, 22 Jul 2014 14:31:41 +0200
Message-ID: <53CE59AD.6040803@redhat.com>
References: <5391D727.5020907@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5391D727.5020907-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06.06.2014 16:58, Hannes Reinecke wrote:
> Hi Harald,
> 
> I've just uncovered a rather nasty issue with dracut, where for no apparent
> reason a (multithreaded) program was crashing.
> Reason being here that libpthread _requires_ libgcc_s when any program is using
> 'pthread_cancel'. When the library isn't present
> any of those calls will generate a SIGABRT.
> Nasty.
> 
> Best would be to pull libgcc_s in always when libpthread is required. But that
> would be some library detection magic.
> Can you fix this up?
> 
> Cheers,
> 
> Hannes

Thanks! Should be in dracut >= 038
