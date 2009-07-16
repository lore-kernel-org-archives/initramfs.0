From: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Thu, 16 Jul 2009 20:56:27 +1000
Message-ID: <19039.1883.943995.16962@notabene.brown>
References: <4A5C6501.3080607@redhat.com>
	<1247581847.1991.16.camel@localhost.localdomain>
	<e9c3a7c20907151147q3e48e681ufd0916f6e4e390c4@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: message from Dan Williams on Wednesday July 15
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Zeuthen <david-o55+BOBDEFg@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Ledford <dledford-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wednesday July 15, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> 
> mdadm-3.0 has facilities to prevent assembly of certain metadata types
> [1] or arrays with certain uuids [2].  I wonder if we also need a
> facility to prevent auto-assembly of arrays *not* listed in
> mdadm.conf?  So the mdadm.conf file installed in the initramfs would
> only identify the root array and all other randomly identified md
> devices would be ignored (rather than assembled with a foreign name).
> 
> Thoughts?

This is exactly the functionality that the 'AUTO' line provides.
Arrays that are listed in mdadm.conf will always be assembled when they
are found.
Arrays that are not listed may or may not be assembled depending on
their metadata type and the setting of 'AUTO'.

So
  AUTO -all

will disable all auto-assemble of arrays that are not listed in
mdadm.conf.

NeilBrown
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
