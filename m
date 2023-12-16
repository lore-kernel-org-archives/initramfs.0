Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969E13FF1
	for <initramfs@vger.kernel.org>; Sat, 16 Dec 2023 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 3C32DE80406;
	Sat, 16 Dec 2023 15:34:03 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id EA87516036B; Sat, 16 Dec 2023 15:34:02 +0100 (CET)
Date: Sat, 16 Dec 2023 15:34:02 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Nils Kattenbeck <nilskemail@gmail.com>
Cc: Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Yariv Rachmani <yrachman@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZX21WssWfN-4fF_a@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <ZXc4t8ayumo-dhul@itl-email>
 <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>
 <ZXifwMan02j9M3n2@gardel-login>
 <CAKkJDRd8=r+BDacQXO0SaYVKogwBTq6fz_U169GZT25+b0SmJA@mail.gmail.com>
 <ZXjKagDbAWpkKgOz@gardel-login>
 <CAKkJDRcZkcebHKMqgyjRP8Veu1dGjfwE5pUG+smwHfop2biQ0g@mail.gmail.com>
 <ZXlzSydKiEG_KNzx@gardel-login>
 <CAKkJDReTmx2pn61+BQyhmo2=g1b3y0nyO00rZ7JwpOwRT9Wzgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKkJDReTmx2pn61+BQyhmo2=g1b3y0nyO00rZ7JwpOwRT9Wzgw@mail.gmail.com>

On Do, 14.12.23 02:17, Nils Kattenbeck (nilskemail@gmail.com) wrote:

> On Wed, Dec 13, 2023 at 10:03 AM Lennart Poettering
> <lennart@poettering.net> wrote:
> >
> > On Di, 12.12.23 23:01, Nils Kattenbeck (nilskemail@gmail.com) wrote:
> >
> > > > sysexts are erofs or squashfs file systems with verity backing. Only
> > > > the sectors you access are decompressed.
> > >
> > > Okay I forgot that they were erofs based and mentioned cpio archives
> > > so I assumed they would be one.
> > > Do they need to be fully read from disk to generate the cpio archive?
> >
> > erofs is a file system, cpio is a serialized archive. Two different
> > things. The discussion here is whether to pass the initrd to the
> > kernel as one or the other. But noone is suggesting to convert one to
> > the other at boot time.
>
> I was referring to the following line from sd-stub's man page: "The
> following resources are passed as initrd cpio archives to the booted
> kernel: [...] /.extra/sysext/*.raw [...]". I assume the initrd
> containing the sysexts has to be created at some point?

These cpios are created on-the-fly and placed into memory and passed
to the invoked kernel. And yes, for that the data they contian needs
to be read off disk first.

Lennart

--
Lennart Poettering, Berlin
