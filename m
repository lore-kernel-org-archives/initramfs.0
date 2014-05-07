From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Intend of hostonly-cmdline?
Date: Wed, 07 May 2014 15:48:59 +0200
Message-ID: <536A39CB.1050700@redhat.com>
References: <2263850.UM9clb02rz@skinner> <536A19D7.2010405@redhat.com> <1706311.vdFaWiovt6@skinner>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1706311.vdFaWiovt6@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07.05.2014 15:40, Thomas Renninger wrote:
> On Wednesday, May 07, 2014 01:32:39 PM Harald Hoyer wrote:
>> Thoughts?
> 
> Most parameters are unique and if it is ensured that:
> single getarg and friends calls prefer the (real)
> kernel cmdline parameter over the faked one, it should more or less be safe
> and things can still be overridden via kernel cmdline.
> 
> Don't know whether this is the case atm, though.
> 
>     Thomas
> 

Unique parameters are already handled that way...
The problem to solve are the parameters, which can be given multiple times

Hmm, maybe we should also log the parameters in /etc/cmdline.d to let the user
see, what dracut is parsing.
