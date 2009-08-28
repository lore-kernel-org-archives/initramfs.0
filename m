From: Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Issues with dracut and network device naming
Date: Fri, 28 Aug 2009 10:36:11 -0400
Message-ID: <1251470171.1305.144.camel@perihelion.bos.jonmasters.org>
References: <4A97CA1A.5080606@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A97CA1A.5080606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-08-28 at 14:14 +0200, Hans de Goede wrote:

> When using iscsi for example, an interface name (usually eth#) is
> specified on the dracut cmdline, but if a machine has multiple nics
> the probe order done by dracut may very well differ as the one
> which was used during install when the dracut cmdline gets generated.

It's worth talking to Prarit about this stuff because he's looking into
persistent network device naming issues in general. I'm sure you know,
but there's a generic DMI extension that allows you to determine from
the system what the PCI slot->device name mapping should be so that e.g.
moving the disk from one system to another doesn't affect the naming.

Of course this only works on systems with the requisite SMBUS/DMI
extension *but* it will (eventually) be a nice solution to the naming
issues and worth working with him on if you're not already.

Jon.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
