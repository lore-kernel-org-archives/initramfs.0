Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D694
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 09:50:06 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id D67DEE8057B;
	Tue, 12 Dec 2023 18:50:04 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 9A76816012B; Tue, 12 Dec 2023 18:50:04 +0100 (CET)
Date: Tue, 12 Dec 2023 18:50:04 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>,
	Yariv Rachmani <yrachman@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXidTEsIj7csT4N0@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <ZXc4t8ayumo-dhul@itl-email>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXc4t8ayumo-dhul@itl-email>

On Mo, 11.12.23 11:28, Demi Marie Obenour (demi@invisiblethingslab.com) wrote:

> I don't think this is "a pretty specific solution to one set of devices"
> _at all_.  To the contrary, it is _exactly_ what I want to see desktop
> systems moving to in the future.
>
> It solves the problem of large firmware images.  It solves the problem
> of device-specific configuration, because one can use a file on the EFI
> system partition that is read by userspace and either treated as
> untrusted or TPM-signed.  It means that one have a complete set of
> recovery tools in the event of a problem, rather than being limited to
> whatever one can squeese into an initramfs.  One can even include a full
> GUI stack (with accessibility support!), rather than just Plymouth.  For
> Qubes OS, one can include enough of the Xen and Qubes toolstack to even
> launch virtual machines, allowing the use of USB devices and networking
> for recovery purposes.  It even means that one can use a FIDO2 token to
> unlock the hard drive without a USB stack on the host.  And because the
> initramfs _only_ needs to load the boot extension volume, it can be
> very, _very_ small, which works great with using Linux as a coreboot
> payload.

systemd's "system extension" concept ("sysexts") already allow you to
do all that. The stuff I was fantasizing about would only change one
thing: instead of sd-stub from uefi mode already putting the sysexts
you installed into memory for the initrd to consume, it would be some
proto-initrd that would do so. This does not really change what you
can do with this, but mostly is just an optimization, reducing iops
and memory use a bit, and thus boot time latency.

> The only problem I can see that this does not solve is network boot, but
> that is very much a niche use case when compared to the millions of
> Fedora or Debian desktop installs, or even the tens of thousands of
> Qubes OS installs.  Furthermore, I would _much_ rather network boot be
> handled by userspace and kexec, rather than the closed source UEFI network
> stack.

Well, somebody's niche is somebody else's common case. In VM/cloud/server
scenarios network booting is not that "niche" as it might be on the desktop.

> It does require some care when upgrading, as the dm-verity image and the
> UKI cannot both be updated atomically, but one can solve that by first
> writing the new dm-verity image to a separate location.  The UKI will
> try both both the old and new locations for the dm-verity image and
> rename the new image over the old one on success.  The wrong image will
> simply fail to mount as its root hash will be wrong.

systemd-sysext already covers this just fine: you can encode in their
"extension-release" file to which base images they match up, and
systemd-syext will then find the right one to apply, and ignore the
others. Thus just make sure you drop in the sysexts fist, and the UKI
last and things should be perfectly robust.

Lennart

--
Lennart Poettering, Berlin
