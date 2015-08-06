From: Frank Steiner <fsteiner-mail1-G0GEQqhI7DhYiKXMg8wJIg@public.gmane.org>
Subject: Re: swap device reference causes problem with initramfs for diskless
 clients
Date: Thu, 06 Aug 2015 12:46:43 +0200
Message-ID: <55C33B13.8040301@bio.ifi.lmu.de>
References: <559FDE38.2080808@bio.ifi.lmu.de> <55A6142D.9090508@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55A6142D.9090508-G0GEQqhI7DhYiKXMg8wJIg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Frank Steiner wrote

> Frank Steiner wrote
> 
>> dracut will include a lot of references to the swap device of the host
>> where we execute this command.
> 
> By the way, doesn't this contradict the idea of the host-only mode?
> 
>      Host-Only mode: Install only what is needed for booting the local host
>      instead of a generic host and generate host-specific configuration.
> 
> Thus, including hard-coded, non-overridable UUID references to a local
> hard disk doesn't really create a config for a "generic" host as should 
> be done without the host-only option? Having a rd.swap parameter really
> would help :-)

The SuSE support pointed me to the -no-hostonly option that solved my
problem. I really wasn't aware that there are three modes in dracut:
a host-only, a non-host-only and a something-in-between mode. Seems
strange to me. Why does it make sense to create a initrd by default,
that is more generic than a host-only one but not generic enough to run 
on other hosts by missing e.g. modules like lvm or iscsi and by including 
host-only references to the swap device?

At least the man page should be changed because the explanation
of the host-only mode indicates that without this option a generic
initrd is created which is not true.

cu,
Frank


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
