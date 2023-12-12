Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkb2UnMq"
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DAFBC
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 12:35:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso6332766a12.3
        for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 12:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702413305; x=1703018105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kVTeo1YQLeOnupnOZfC7wKAv++H7X9q3FyJuUWkBJQ4=;
        b=Qkb2UnMqpsR4EGlKQRHxodU2yxaiRnnoFNT1aIg4oWjshPBJlE/fkUIAD6pHmQ8L1E
         seDIGSX8Iy3tatTvowHeMESCvRGIzIFMBgrA2b8sZQ38Bl0ZTlUSNq9t20eGtRsdR368
         LI0KyTDUj4HYLRxLLLtmZQoquJ4B66J0OwLfqFstxj+fDpA2t/BqdXH+nnU8feFLHvZ9
         9lL2q9ajW/T35wNd/9A5muDRLxV6XZ2nUU94vZr6HmhlG3cxZEIB6gUDP8s3s9m/I/ni
         Ocn2rrtG4GG17z/Siw/OLyeI1o/3Aw4WKp2WF1qFgYxW79D+WxFlujpPoWWAxXCVHopy
         OOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702413305; x=1703018105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVTeo1YQLeOnupnOZfC7wKAv++H7X9q3FyJuUWkBJQ4=;
        b=sK+1Z71x4oNJ88UyTAYwtPLK7bC+oy6RWYmF7lic/Pu6Lmt21VFd+ODLOSQQafSgQi
         4t/W1OWZWHpgp5nQYcs3p9mdmEoyyKoIcFqgv8217ARWVgOtVe6kWvW7650E9TSoQxYs
         6PIHM9ulrPnLSeRaMs7psDAFjR+tpo6+/y99SzmwxRhvOsIM54nRka2QgUSl+kWuxLZf
         BZTpwijgy5VeONoylEe2WrFxvvVeUCq7msOsbRnnq4Gedyaud+qaJaz7jgcQVTjkLXAy
         loQhzQ8PG4bNxKzmoExnioGslOxLCEVkqXNtIsAAuJu+xOm9RHWEBM5fAwEV7R6/3rn8
         GG3g==
X-Gm-Message-State: AOJu0Yzw+SwNnCBOpCL26fK7OZFn78g+05Tb1bcChR+rDh8AA6uOtQWJ
	A4VV7XnmR7x7ymuw4vL3arSOgZv6a42EVRRBE+0=
X-Google-Smtp-Source: AGHT+IGj+kJSGhGI7psAyUDs+KTQ0lusPXk3yYMl+gFJpo4HauQPnAK4eD9e2R9GIL74RAZIWOvwnzVy4H0jdrKnQGE=
X-Received: by 2002:a17:907:1c91:b0:a1d:310f:13f0 with SMTP id
 nb17-20020a1709071c9100b00a1d310f13f0mr4368340ejc.127.1702413304564; Tue, 12
 Dec 2023 12:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <ZXc4t8ayumo-dhul@itl-email>
 <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com> <ZXifwMan02j9M3n2@gardel-login>
In-Reply-To: <ZXifwMan02j9M3n2@gardel-login>
From: Nils Kattenbeck <nilskemail@gmail.com>
Date: Tue, 12 Dec 2023 21:34:47 +0100
Message-ID: <CAKkJDRd8=r+BDacQXO0SaYVKogwBTq6fz_U169GZT25+b0SmJA@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Lennart Poettering <lennart@poettering.net>
Cc: Eric Curtin <ecurtin@redhat.com>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>, Yariv Rachmani <yrachman@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi, while I have been following this thread passively for now I also
wanted to chime in.

> (The main reason why sd-stub doesn't actually support erofs-initrds,
> is that sd-stub also generates initrd cpios on the fly, to pass
> credentials and system extension images to the kernel, and you can't
> really mix erofs and cpio initrds into one)

What prevents one from mixing the two (especially given that the
hypothetical erofs initrd support does not yet exist)?
Or are you talking about mixing this with your memmap+root=/dev/pmem suggestion?

> The try to optimize the initrd a bit by making it an erofs/memmap
> thing and so on. And make sure the initrd only contains stuff you
> always need, so that reading it all into memory is necessary anyway,
> and hence any approach that tries to run even the initrd off a disk
> image won't be necessary becuase you need to read everything anyway.

Having to ensure that the initrd is as small as possible is definitely
no easy task.
Furthermore unless one has total control over the devices, or even if
there are only a few hardware revisions, parts of the initrd might not
be used.
Even if everything is the same there are codes paths which might not
be taken during usual operation. An example would be services similar
to the new systemd-bsod which are only triggered in emergencies.
Having these in the cpio means that they will always be read and
decompressed.
Using sysexts also has the drawback that each and every one of them
has to be decompressed. I might be mistaken but I expect that this
will be the case even if the extension-release in the sysext results
in it being discarded which is obviously another big drawback.

Regardless, even if every single file within the cpio archive (and
potential sysexts) is used, erofs still has a distinct advantage over
cpio!
With cpio everything has to be decompressed and read up front. With
erofs this is not the case.
Only the fs header has to be read at first as files are decompressed on demand.
This means that critical stuff can be started earlier as it does not
have to wait for decompression of stuff only needed later on.
For example an initrd-only (i.e. not pivolint root), graphical system
could start all background services long before the UI starts and
accesses large asset files.

I agree that this splitting up into another micro-initrd just for some
storage stuff etc (which I still have not groked completely) does not
seem to offer any advantages to what we have today. *However*, I
certainly think that standardizing and supporting some kind of erofs
based initrd would gain some advantages.

On the other hand this feels like going back to an old ramdisk again.
This goes beyond my knowledge but based on the kernel docs most
drawbacks of ramdisks would not apply to an approach with erofs. Also
maybe the more flexible loopback devices could be used(?) which might
alleviate some problems.

-- This block device was of fixed size, so the filesystem mounted on
it was of fixed size.
   -> Should not be of concern as it is readonly anyhow.
-- Using a ram disk also required unnecessarily copying memory from
the fake block device into the page cache (and copying changes back
out), as well as creating and destroying dentries.
   -> (?) This one I am actually not too sure about and supersedes my
knowledge on tmpfs, vfs (and its cache layers), erofs caching, and
loopback devices).
-- Plus it needed a filesystem driver (such as ext2) to format and
interpret this data.
   -> erofs is already included in most initrds (and is not too big if
it is not)

Regards, Nils
