From: Jeremy Katz <katzj@redhat.com>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Wed, 15 Jul 2009 20:16:52 -0400
Message-ID: <20090716001651.GB45537@redhat.com>
References: <4A5C6501.3080607@redhat.com> <1247581847.1991.16.camel@localhost.localdomain> <e9c3a7c20907151147q3e48e681ufd0916f6e4e390c4@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hotplug-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e9c3a7c20907151147q3e48e681ufd0916f6e4e390c4@mail.gmail.com>
Sender: linux-hotplug-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Zeuthen <david@fubar.dk>, Hans de Goede <hdegoede@redhat.com>, initramfs <initramfs@vger.kernel.org>, linux-hotplug@vger.kernel.org, "Danecki, Jacek" <jacek.danecki@intel.com>, Harald Hoyer <harald@redhat.com>, Doug Ledford <dledford@redhat.com>, NeilBrown <neilb@suse.de>

On Wednesday, July 15 2009, Dan Williams said:
> mdadm-3.0 has facilities to prevent assembly of certain metadata types
> [1] or arrays with certain uuids [2].  I wonder if we also need a
> facility to prevent auto-assembly of arrays *not* listed in
> mdadm.conf?  So the mdadm.conf file installed in the initramfs would
> only identify the root array and all other randomly identified md
> devices would be ignored (rather than assembled with a foreign name).
> 
> Thoughts?

There is no mdadm.conf in the initramfs -- in fact, the initramfs may
not even be generated on the system that you're booting and instead be
"generic" for the kernel in question

Jeremy
