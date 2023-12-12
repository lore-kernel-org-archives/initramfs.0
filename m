Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9718F
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 09:37:57 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id B29B9E801F8;
	Tue, 12 Dec 2023 18:37:54 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 4121216012B; Tue, 12 Dec 2023 18:37:54 +0100 (CET)
Date: Tue, 12 Dec 2023 18:37:54 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Eric Curtin <ecurtin@redhat.com>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org,
	Yariv Rachmani <yrachman@redhat.com>,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXiacj2XYYRvaZ9A@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <CAOgh=Fxy8pKipkfKvk62_WfBVUrkM865a9TRLF=oHC2u_jjZKQ@mail.gmail.com>
 <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>
 <ZXb3xhSswgjQAwlL@gardel-login>
 <CAOgh=FxHsOpDA7izWEd=eA886op17gdTFJPebxnvEwNOmWEyKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=FxHsOpDA7izWEd=eA886op17gdTFJPebxnvEwNOmWEyKQ@mail.gmail.com>

On Mo, 11.12.23 12:48, Eric Curtin (ecurtin@redhat.com) wrote:

> Sort of yes, but preferably using that __initramfs_start /
> initrd_start buffer as is without copying any bytes anywhere else and
> without teaching the bootloaders to do things.
>
> The "memmap=" approach you suggested sounds like what we are thinking,
> but do you think we could do this without teaching bootloaders to do
> new things?

Well, in a standard UEFI world it would suffice to teach the memmap=
logic to the stub that is glued in front of the kernel. For example,
make sd-stub find the erofs initrd in the UKI, then trivially
synthesize a memmap= switch and append it to the kernel command line.

but of course, you don't believe in UEFI or good boot loaders, so you
kinda dug your own grave here...

(The main reason why sd-stub doesn't actually support erofs-initrds,
is that sd-stub also generates initrd cpios on the fly, to pass
credentials and system extension images to the kernel, and you can't
really mix erofs and cpio initrds into one)

Lennart

--
Lennart Poettering, Berlin
