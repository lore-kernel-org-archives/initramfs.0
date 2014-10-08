From: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Subject: Re: [systemd-devel] LUKS passphrase asked twice when using plain
 device names
Date: Wed, 8 Oct 2014 23:35:35 +0200
Message-ID: <20141008213535.GB27889@gardel-login>
References: <1411452408.5121.15.camel@users.sourceforge.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411452408.5121.15.camel-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: systemd-devel <systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 23.09.14 08:06, Paul Menzel (paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) wrote:

> Dear systemd and dracut folks,
> 
> 
> with Debian Sid/unstable, using plain device names like `/dev/sda1` in
> `/etc/fstab` and `/etc/crypttab` the LUKS passphrase has to be entered
> twice. Once it asked by dracut and once by systemd. I did not yet try
> with UUIDs and ask first if that is an error?

Hmm, plain crypt devices are difficult to recognize. 

Do you have both fstab and crypttab in the initrd in the exact same
version as on the host?

Lennart

-- 
Lennart Poettering, Red Hat
