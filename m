Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539882ECD37
	for <initramfs@vger.kernel.org>; Wed, 19 Nov 2025 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591153; cv=none; b=e92Oz/vDT2Gw3qrnDLKMVyJF2rMxqGw8xjKPRVO6VgpbhfPw4/P8IW4TPd27wt8IzzmkJ7KkugbTneiQxplSAm3lwl/d61y3eihiZWvR0iPSMN98FtIwXaucN8aEx6uni0+MmjNoCrNWxOM3YEtAmlWiMbd9xiH3LWySIYszHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591153; c=relaxed/simple;
	bh=xglFJUSvPG5UXUDya1AhriAXfBb43C1XIg0pBbiWIfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHjwR6oHNZgShuIA6AaDR5K9wWpEvRgB0nF6KTNiWuEYCaMbhUFFZ7QCXmpEbREIKupByQCAwnUPGJGLOklm34J3tcfB76hnXSl52yu37n3ZhM4ZWjBsW0ZsZHvYqCXIQpnpGx4Y466weQUTsEgwWV4cfmGkmpte//rElpeHRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwVt7tpG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwVt7tpG"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37bac34346dso1499911fa.2
        for <initramfs@vger.kernel.org>; Wed, 19 Nov 2025 14:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763591149; x=1764195949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIHrPRGK7VOE478WBP+TOLRFYgGuOjtNsJuovM1QrMk=;
        b=FwVt7tpGUB3pRodX8TxUTfARUWZTskg399VrcJWJbZpDMKOzps+hHvrZXIXB62j2+J
         PajNhy49olLni0/jAbmsfrdBGQ4ojHFmLrHvxCfHFHLFG3b53lNthpn6gV+DfV5435aO
         XxXFg5DpfBuPwaJscm/zXEz+qXhnNwciCIE/0FOd1XI4o3GqKfeL+bJU6zp9s54cv/SH
         QxZHriZ4vMfF42e5VLpA+lx+OwIcKHODG4PfAaU9ivu2J16UaldgyviJqfmAqWGkphVf
         1lE8AIdIEddOjolPI5/ApWNnPayNtCkE/pe0cHqEpzUJkA6hzHkUYaLuahUftWbhmC0A
         axVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763591149; x=1764195949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIHrPRGK7VOE478WBP+TOLRFYgGuOjtNsJuovM1QrMk=;
        b=uR9AFcSptTiyMp9NPv7y3a4gbx7VuC+Okczw6ncPjQFA22m15yhNcOkysp0do0HdVG
         2BMgKdRlQrHBjsl+pBSFNbWUwgWxcAaIeVwVUdVNBQDpUr5n96BDW/qB5S8Mlf+Rw1C5
         g6fGP8POhXq0yBdlLzWUU0Mj5bMrUbpAbpe0ru+bW7GP0O9s1/cumBl9H/JDdG6B+3fV
         zb3nO4QQRPvIytcYCkI4AbhAbfo2t55YHCaBEjqF8n/SyVQG3cdQ5wamXqHvGWEhgk5P
         z76xlwtN+jMLmD0M4naUQEQXDpsH2ua1LcgtJ0V79RmbxCrwJ0v6t+9idwhgizIHmUlo
         B85w==
X-Forwarded-Encrypted: i=1; AJvYcCXdtCv9v3D62TwpQz6Q0sKcjMKNoHE0qyQe5l5bF3PX0fN56bHl49gCxF98Asw7q9jqco028fiUafc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8e30rIrUsls+/OU0ttzpKJ77QHpVLG106puvuR5arxSiaC11
	DwY3pwNGjZkiBcOJ7jtj/BJBq7vg6tdLE39C+Vyc5APy8LmYgFI39+tM
X-Gm-Gg: ASbGncu6w0UIpdDcPPPwBwIJR2dHPknRpIhOgQDkBSLu++6rw7u30j2mLV99QQ/Sd+4
	iX2xsP/X2n6lu5Xzr2saOE+CTAR+iRhYDikEXuT1x2Qf5HVYaoMq6D1Znbx9jpVjEBbwjtSDKRG
	XvQ45nIYW9IZeeaOz5482WMFOyDrVaEvQ5gZxYcfnR6GskF6Jcpg7YngCiheoeEL5O/xlXSrq87
	ZDkEwf+BcJJ6JMevicnFesAIznkeOKlDYuw6orOWjP+OoaRbZiVqByeHrAcXC7aN5k0JMKKg7lA
	RoZsXAUdFmCNyfyizLjXr2Q8Gmh5CRCLHGgA4iKuBwg7FhmzjTlVwKaNzWzLt+pZKXyXAKPJ6iE
	YIWdgRd7VxmYDCpfSeOiCjWX674j9e/U2rVVInotXt5tYlpyd3ufpDypYuBxW3p2zIc7V74BVJN
	vAW9C6Cq3+Uu1B2iA7awONB0rOOX4DqQ==
X-Google-Smtp-Source: AGHT+IH4N1JSat2pulJqXvhrCb4PBABQ8mFvFLi3pb8dARcuOUHcUR7ZoJ5G2Q7xHRD7Cj2gwMDPSg==
X-Received: by 2002:a05:651c:1112:b0:378:e055:3150 with SMTP id 38308e7fff4ca-37cc7fe85d5mr586601fa.5.1763591149108;
        Wed, 19 Nov 2025 14:25:49 -0800 (PST)
Received: from localhost ([109.167.240.218])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37cc6bbe18dsm1183461fa.33.2025.11.19.14.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:25:48 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v4 0/3] initrd: remove half of classic initrd support
Date: Wed, 19 Nov 2025 22:24:04 +0000
Message-ID: <20251119222407.3333257-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset will not affect anyone, who showed up in these lists.
See [5] for details.

Intro
====
This patchset removes half of classic initrd (initial RAM disk) support,
i. e. linuxrc code path, which was deprecated in 2020.
Initramfs still stays, RAM disk itself (brd) still stays.
And other half of initrd stays, too.
init/do_mounts* are listed in VFS entry in
MAINTAINERS, so I think this patchset should go through VFS tree.
I tested the patchset on 8 (!!!) archs in Qemu (see details below).
If you still use initrd, see below for workaround.

In 2020 deprecation notice was put to linuxrc initrd code path.
In v1 I tried to remove initrd
fully, but Nicolas Schichan reported that he still uses
other code path (root=/dev/ram0 one) on million devices [4].
root=/dev/ram0 code path did not contain deprecation notice.

So, in this version of patchset I remove deprecated code path,
i. e. linuxrc one, while keeping other, i. e. root=/dev/ram0 one.

Also I put deprecation notice to remaining code path, i. e. to
root=/dev/ram0 one. I plan to send patches for full removal
of initrd after one year, i. e. in January 2027 (of course,
initramfs will still work).

Also, I tried to make this patchset small to make sure it
can be reverted easily. I plan to send cleanups later.

Details
====
Other user-visible changes:

- Removed kernel command line parameters "load_ramdisk" and
"prompt_ramdisk", which did nothing and were deprecated
- Removed /proc/sys/kernel/real-root-dev . It was used
for initrd only
- Command line parameters "noinitrd" and "ramdisk_start=" are deprecated

Testing
====
I tested my patchset on many architectures in Qemu using my Rust
program, heavily based on mkroot [1].

I used the following cross-compilers:

aarch64-linux-musleabi
armv4l-linux-musleabihf
armv5l-linux-musleabihf
armv7l-linux-musleabihf
i486-linux-musl
i686-linux-musl
mips-linux-musl
mips64-linux-musl
mipsel-linux-musl
powerpc-linux-musl
powerpc64-linux-musl
powerpc64le-linux-musl
riscv32-linux-musl
riscv64-linux-musl
s390x-linux-musl
sh4-linux-musl
sh4eb-linux-musl
x86_64-linux-musl

taken from this directory [2].

So, as you can see, there are 18 triplets, which correspond to 8 subdirs in arch/.

For every triplet I tested that:
- Initramfs still works (both builtin and external)
- Direct boot from disk still works
- Remaining initrd code path (root=/dev/ram0) still works

Workaround
====
If "retain_initrd" is passed to kernel, then initramfs/initrd,
passed by bootloader, is retained and becomes available after boot
as read-only magic file /sys/firmware/initrd [3].

No copies are involved. I. e. /sys/firmware/initrd is simply
a reference to original blob passed by bootloader.

This works even if initrd/initramfs is not recognized by kernel
in any way, i. e. even if it is not valid cpio archive, nor
a fs image supported by classic initrd.

This works both with my patchset and without it.

This means that you can emulate classic initrd so:
link builtin initramfs to kernel; in /init in this initramfs
copy /sys/firmware/initrd to some file in / and loop-mount it.

This is even better than classic initrd, because:
- You can use fs not supported by classic initrd, for example erofs
- One copy is involved (from /sys/firmware/initrd to some file in /)
as opposed to two when using classic initrd

Still, I don't recommend using this workaround, because
I want everyone to migrate to proper modern initramfs.
But still you can use this workaround if you want.

Also: it is not possible to directly loop-mount
/sys/firmware/initrd . Theoretically kernel can be changed
to allow this (and/or to make it writable), but I think nobody needs this.
And I don't want to implement this.

On Qemu's -initrd and GRUB's initrd
====
Don't panic, this patchset doesn't remove initramfs
(which is used by nearly all Linux distros). And I don't
have plans to remove it.

Qemu's -initrd option and GRUB's initrd command refer
to initrd bootloader mechanism, which is used to
load both initrd and (external) initramfs.

So, if you use Qemu's -initrd or GRUB's initrd,
then you likely use them to pass initramfs, and thus
you are safe.

v1: https://lore.kernel.org/lkml/20250913003842.41944-1-safinaskar@gmail.com/

v1 -> v2 changes:
- A lot. I removed most patches, see cover letter for details

v2: https://lore.kernel.org/lkml/20251010094047.3111495-1-safinaskar@gmail.com/

v2 -> v3 changes:
- Commit messages
- Expanded docs for "noinitrd"
- Added link to /sys/firmware/initrd workaround to pr_warn

v3: https://lore.kernel.org/lkml/20251017060956.1151347-1-safinaskar@gmail.com/

v3 -> v4 changes:
- Changed "September 2026" to "January 2027" (i. e. after 2026 LTS release)

[1] https://github.com/landley/toybox/tree/master/mkroot
[2] https://landley.net/toybox/downloads/binaries/toolchains/latest
[3] https://lore.kernel.org/all/20231207235654.16622-1-graf@amazon.com/
[4] https://lore.kernel.org/lkml/20250918152830.438554-1-nschichan@freebox.fr/
[5] https://lore.kernel.org/lkml/20251022082604.25437-1-safinaskar@gmail.com/

Askar Safin (3):
  init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command
    line parameters
  initrd: remove deprecated code path (linuxrc)
  init: remove /proc/sys/kernel/real-root-dev

 .../admin-guide/kernel-parameters.txt         |  12 +-
 Documentation/admin-guide/sysctl/kernel.rst   |   6 -
 arch/arm/configs/neponset_defconfig           |   2 +-
 fs/init.c                                     |  14 ---
 include/linux/init_syscalls.h                 |   1 -
 include/linux/initrd.h                        |   2 -
 include/uapi/linux/sysctl.h                   |   1 -
 init/do_mounts.c                              |  11 +-
 init/do_mounts.h                              |  18 +--
 init/do_mounts_initrd.c                       | 107 ++----------------
 init/do_mounts_rd.c                           |  24 +---
 11 files changed, 23 insertions(+), 175 deletions(-)


base-commit: 6a23ae0a96a600d1d12557add110e0bb6e32730c (v6.18-rc6)
-- 
2.47.3

