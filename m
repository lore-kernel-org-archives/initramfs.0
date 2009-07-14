From: Doug Ledford <dledford@redhat.com>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Tue, 14 Jul 2009 10:14:35 -0400
Message-ID: <D758972F-0E5A-4860-9011-6B2DA1FA771A@redhat.com>
References: <4A5C6501.3080607@redhat.com> <1955210A-EF27-479F-8C58-BA4FA9018A56@redhat.com> <4A5C9E17.2060106@redhat.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-89-838219897"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <4A5C9E17.2060106@redhat.com>
Sender: linux-hotplug-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: initramfs <initramfs@vger.kernel.org>, linux-hotplug@vger.kernel.org, "Danecki, Jacek" <jacek.danecki@intel.com>, Harald Hoyer <harald@redhat.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-89-838219897
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

On Jul 14, 2009, at 11:02 AM, Hans de Goede wrote:
> Hi,
> On 07/14/2009 03:39 PM, Doug Ledford wrote:
>> On Jul 14, 2009, at 6:59 AM, Hans de Goede wrote:
>>> Hi,
>>>
>>> As you probably know I'm working on making Fedora 12 use mdraid
>>> instead of dmraid for Intel BIOS-RAID setups.
>>>
>>> The installer (anaconda) part is mostly done (needs more testing)
>>> and now I'm looking at implementing support for this in dracut
>>> (the new mkinitrd for Fedora 12).
>>>
>>> So I've been testing how this works for both imsm mdraid sets
>>> and native mdraid metadata sets, in both cases using a 2 disk
>>> mirror, so that the set can also be brought up in degraded mode.
>>>
>>> Currently the udev rules use incremental assembly like this:
>>> mdadm -I /dev/mdraid-member
>>
>> Hmmm...does dracut use udev during initramfs time?
>
> Yes, it uses udev for everything, making discovery of / consistent
> with the discovery of other storage devices.

I'm not sure I like or agree with that philosophy.  I absolutely  
*don't* want my / filesystem or raid device treated like some plug in,  
temporary, roaming raid device.  They *aren't* the same, not in terms  
of importance to the running of the machine and not in terms of  
reliability requirements.  By using mdadm -A in the mkinitrd calls, I  
was able to put in an mdadm.conf file and limit what arrays get  
started to arrays found non-ambiguously in that mdadm.conf file and  
identified by UUID.  When you switch to incremental assembly for root,  
you risk the possibility of name space collisions and non- 
deterministic bring up of your / array.

> <snip>
>
>> Are we going to be totally changing this with
>> dracut and F12? This method very nicely resolves the issues you  
>> posted.
>>
>
> Yes.
>
> Regards,
>
> Hans


--

Doug Ledford <dledford@redhat.com>

GPG KeyID: CFBFF194
http://people.redhat.com/dledford

InfiniBand Specific RPMS
http://people.redhat.com/dledford/Infiniband





--Apple-Mail-89-838219897
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)

iEYEARECAAYFAkpckssACgkQQ9aEs6Ims9i7bACghKl1/eFD6Bx7nYX+e9SUN0bK
ICsAn2c8mwOHmPf7Wl91ZtOvk25HU1+A
=X2Wn
-----END PGP SIGNATURE-----

--Apple-Mail-89-838219897--
