From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Issues with dracut and network device naming
Date: Mon, 31 Aug 2009 08:32:15 -0500
Message-ID: <1251725535.8731.30.camel@sentry-no>
References: <4A97CA1A.5080606@redhat.com>
	 <1251470171.1305.144.camel@perihelion.bos.jonmasters.org>
	 <4A9BB155.8020106@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:content-transfer-encoding:date
         :message-id:mime-version:x-mailer;
        bh=bvbASXPdJd1Otw/LBAYRlpciUcgxTeeTpqKKiuoGLT0=;
        b=O9ne/Pp4fy81NCgWl1PzPiqxVX6vsI6RdoR3fZNiRWpY9q+ExgIEXMa1Xj6e1ZPRUb
         vRXsnzxVywqdK9Rs/ksjf7IV610xrqkTtZQh96VNwR7gAECylGHXoBi8TbQ2tuKKqrI3
         k7CT7Hh5grvzI617LTsGZPjr46/Qub+nlajDA=
In-Reply-To: <4A9BB155.8020106-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-08-31 at 13:17 +0200, Hans de Goede wrote:
> Hi all,
> But in the future it could also be something like for example:
> ifname=eth0:/sys/devices/bus/pci/00:00:00:01.5

Hmmm... what guarantee is there that PCI device ordering is stable?

MAC addresses have the advantage of not being subject to change because
you flashed the system BIOS and things are enumerated in a different
order, or you decided to add a multifunction card that adds its own
brand-new set of PCI busses, and your dodgy BIOS decides to renumber
everything.

> Regards,
> 
> Hans
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
