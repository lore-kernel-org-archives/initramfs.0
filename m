Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31233E8
	for <initramfs@vger.kernel.org>; Wed, 13 Dec 2023 01:03:09 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id AB58DE80501;
	Wed, 13 Dec 2023 10:03:07 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 54EAF16036B; Wed, 13 Dec 2023 10:03:07 +0100 (CET)
Date: Wed, 13 Dec 2023 10:03:07 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Nils Kattenbeck <nilskemail@gmail.com>
Cc: Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>,
	Yariv Rachmani <yrachman@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXlzSydKiEG_KNzx@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <ZXc4t8ayumo-dhul@itl-email>
 <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>
 <ZXifwMan02j9M3n2@gardel-login>
 <CAKkJDRd8=r+BDacQXO0SaYVKogwBTq6fz_U169GZT25+b0SmJA@mail.gmail.com>
 <ZXjKagDbAWpkKgOz@gardel-login>
 <CAKkJDRcZkcebHKMqgyjRP8Veu1dGjfwE5pUG+smwHfop2biQ0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKkJDRcZkcebHKMqgyjRP8Veu1dGjfwE5pUG+smwHfop2biQ0g@mail.gmail.com>

On Di, 12.12.23 23:01, Nils Kattenbeck (nilskemail@gmail.com) wrote:

> > sysexts are erofs or squashfs file systems with verity backing. Only
> > the sectors you access are decompressed.
>
> Okay I forgot that they were erofs based and mentioned cpio archives
> so I assumed they would be one.
> Do they need to be fully read from disk to generate the cpio archive?

erofs is a file system, cpio is a serialized archive. Two different
things. The discussion here is whether to pass the initrd to the
kernel as one or the other. But noone is suggesting to convert one to
the other at boot time.

Lennart

--
Lennart Poettering, Berlin
