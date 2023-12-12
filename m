Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA9F9F
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 13:02:37 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 05A05E804E8;
	Tue, 12 Dec 2023 22:02:35 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 9E62116012B; Tue, 12 Dec 2023 22:02:34 +0100 (CET)
Date: Tue, 12 Dec 2023 22:02:34 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Nils Kattenbeck <nilskemail@gmail.com>
Cc: Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>,
	Yariv Rachmani <yrachman@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXjKagDbAWpkKgOz@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <ZXc4t8ayumo-dhul@itl-email>
 <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>
 <ZXifwMan02j9M3n2@gardel-login>
 <CAKkJDRd8=r+BDacQXO0SaYVKogwBTq6fz_U169GZT25+b0SmJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKkJDRd8=r+BDacQXO0SaYVKogwBTq6fz_U169GZT25+b0SmJA@mail.gmail.com>

On Di, 12.12.23 21:34, Nils Kattenbeck (nilskemail@gmail.com) wrote:

> Hi, while I have been following this thread passively for now I also
> wanted to chime in.
>
> > (The main reason why sd-stub doesn't actually support erofs-initrds,
> > is that sd-stub also generates initrd cpios on the fly, to pass
> > credentials and system extension images to the kernel, and you can't
> > really mix erofs and cpio initrds into one)
>
> What prevents one from mixing the two (especially given that the
> hypothetical erofs initrd support does not yet exist)?
> Or are you talking about mixing this with your memmap+root=/dev/pmem
> suggestion?

If you have 7 cpio initrds then the kernel will allocate a tmpfs and
unpack them all into it, one after the other, on top of each other,
and then jumps into the result.

if you have an erofs and 7 cpio initds, what are you going to do? You
cannot extract into an erofs, it's immutable. You'd need something
like overlayfs, but that would require (at least for now) an
additional step in userspace, which is something to avoid.

Alternatively (and preferred by me) would support a mode where it
would unpack any cpios it gets into a tmpfs, and then pass an fsopen()
fd to that to the executable it then invokes from the erofs. the
executable could then mount that somewhere if it wants. But this would
require a kenrel patch.

> Even if everything is the same there are codes paths which might not
> be taken during usual operation. An example would be services similar
> to the new systemd-bsod which are only triggered in emergencies.
> Having these in the cpio means that they will always be read and
> decompressed.

systemd-bsod is tiny though, less than 8K compressed here. Not sure it
is a good example.

> Using sysexts also has the drawback that each and every one of them
> has to be decompressed. I might be mistaken but I expect that this
> will be the case even if the extension-release in the sysext results
> in it being discarded which is obviously another big drawback.

sysexts are erofs or squashfs file systems with verity backing. Only
the sectors you access are decompressed.

Lennart

--
Lennart Poettering, Berlin
