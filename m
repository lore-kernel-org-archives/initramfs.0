From: Frank Steiner <fsteiner-mail1-G0GEQqhI7DhYiKXMg8wJIg@public.gmane.org>
Subject: Re: swap device reference causes problem with initramfs for diskless
 clients
Date: Wed, 15 Jul 2015 10:05:01 +0200
Message-ID: <55A6142D.9090508@bio.ifi.lmu.de>
References: <559FDE38.2080808@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559FDE38.2080808-G0GEQqhI7DhYiKXMg8wJIg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Frank Steiner wrote

> dracut will include a lot of references to the swap device of the host
> where we execute this command.

By the way, doesn't this contradict the idea of the host-only mode?

     Host-Only mode: Install only what is needed for booting the local host
     instead of a generic host and generate host-specific configuration.

Thus, including hard-coded, non-overridable UUID references to a local
hard disk doesn't really create a config for a "generic" host as should 
be done without the host-only option? Having a rd.swap parameter really
would help :-)

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
