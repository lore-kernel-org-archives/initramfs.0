Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="yc0peZh0"
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE1D5E
	for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 08:33:27 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b84e328327so3828033b6e.2
        for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1701275607; x=1701880407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgVLi9wz2v7Dv5QW6wz6r5V/I0koY5gXa7xm0mXVocM=;
        b=yc0peZh0FznR91nSmGJdqnUo43JCeTr3jN5N312tIyop0unOm4JYODR9wDYlno9uTA
         eoRucWSSJSD1gMutNQRV4Fo5PDgNZRlfTzZfWqrf0gjlck9wt40UPboOGi3wnY8nain/
         61Fh7RkKSGlpV94y6/GyagvGrDTeWN0DUUd1IV4stnYHBMD89WUk1Leb811KKFRmSBaY
         rIEgXtPefiDI2O4StxVMk2DsSs41EdBRIyl6e7MeIr9bQKZeo7jDGrgXpmcs/GAcIVTQ
         vuY8nLYAIkv1Kh3ru385+1bHkvJOV4RwYFCOfEFP17o7j+zuWY5Cp4cDK2xinUizgAEX
         BzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275607; x=1701880407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgVLi9wz2v7Dv5QW6wz6r5V/I0koY5gXa7xm0mXVocM=;
        b=YfylQA/1JOiF36gFlS3ggAQKrAJTUc0JTpgp4E1iGh3k6TwhjyVj0h2nxoHqOCxPoB
         G3SH8zp29oD/j1aMDyEBwibUfjHYi3ZfsCmut1+M/w1zIwKeVIq/IpG5l+RYpiOTcL3U
         BlQ6LKOW0Xf6M6lYnCt5E5Cpt1ePA43x/V4JcRlFd+eu6xNVl1G1u0g5S8UGxLI0iuSJ
         eoYzNkYCx5ZFQL+9qpPS+7gBoIn93sxxpXX6yZD4Y80xt0hfBh+okm5eCHj2WhJHofD6
         s37eS1vptsap8QC3qGfD9beL8+dIkhWT/kFP9+uQSJaQCl2IJzgGy9E2wrZAi7PXziDX
         Tkew==
X-Gm-Message-State: AOJu0YzddjJ15E86gnGU27iV0a7OYiDUnvr3CahIdnlHPKDRLTrM4OvB
	Mvw0VIGjBbZ7xRSmK561v37Evg==
X-Google-Smtp-Source: AGHT+IH5jntLWIxMc5064mX2kaq/5gLtXVTvyXt/0MPbjZYvIeR6zF9+OR/FZzsVIsqgJiKxunDaFw==
X-Received: by 2002:a05:6808:189c:b0:3b8:4482:16f4 with SMTP id bi28-20020a056808189c00b003b8448216f4mr27362088oib.52.1701275607158;
        Wed, 29 Nov 2023 08:33:27 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id s27-20020a0568080b1b00b003a3860b375esm2288708oij.34.2023.11.29.08.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 08:33:26 -0800 (PST)
Message-ID: <fc35ab36-c722-1102-36c5-6a2c015b2620@landley.net>
Date: Wed, 29 Nov 2023 10:38:48 -0600
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] initramfs: Support unpacking directly to tmpfs
Content-Language: en-US
To: Emily Shepherd <emily@redcoat.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: initramfs@vger.kernel.org, =?UTF-8?Q?Thomas_Str=c3=b6mberg?=
 <t+github@chainguard.dev>, =?UTF-8?Q?Anders_Bj=c3=b6rklund?=
 <anders.f.bjorklund@gmail.com>, Giuseppe Scrivano <giuseppe@scrivano.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
References: <pkyfrfofquliqqxpylzzn5kdnfk4tewo6gx25d5m6pm2femvin@dkxlxm6leegu>
From: Rob Landley <rob@landley.net>
In-Reply-To: <pkyfrfofquliqqxpylzzn5kdnfk4tewo6gx25d5m6pm2femvin@dkxlxm6leegu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/23 03:00, Emily Shepherd wrote:
> For systems which run directly from initramfs, it is not possible to use
> pivot_root without first changing root. This is because of the
> intentional design choice that rootfs, which is where initramfs is
> unpacked to, cannot be unmounted.
> 
> pivot_root is an important feature for creating containers

Because nobody's ever wanted to fix chroot() so mkdir("sub", 0777);
chroot("sub"); chdir("../../../../.."); chroot("."); wouldn't escape it, so they
repurposed a syscall intended to dispose of initial ramdisks that does things
like traverse the process list and close/reopen all the open files pointing to
the old filesystem (including "." and "/") so they point to the new filesystem.

Personally, I always found THAT a bit awkward, but there wasn't a "clean" system
call that _only_ did what the container guys wanted (patch the mount tree). I
would have thought you could use "mount --move . /" to nerf the cd ../../.. but
for some reason it didn't work (I forget why) and nobody wanted to fix that either.

(By the way, I used pivot_root() on ramfs back when it DID move it, which then
allowed you to unmount it, at which point the kernel locked up as the doubly
linked list traversal kept going until they hit the initramfs entry that was
"always there" and thus reliably terminated the list... Yeah, that got fixed,
now the pivot_root returns an error. Being an initramfs early adopter was
"interesting"...)

> and the
> alternative (mounting the new root over the top of the old with MS_MOVE
> and then calling chroot) is not favoured by most container runtimes
> [1][2] as it does not completely remove the host system mounts from the
> mount namespace.
> 
> The general work around, when running directly from initramfs, is to
> have init mount a new tmpfs, copy everything out of rootfs, and then
> switch_root [3][4].

Which is why I added switch_root to busybox 18 years ago, yes. (I thought I got
the idea from klibc but I'm not finding it in their git repo. I didn't invent
it, there was an existing one somewhere, my 2005 busybox commit comment credits
run_init.c from "kconfig" which can't be right. I did rename it to be more
obviously analogous to pivot_root...)

> This is only required when running directly from the
> initramfs as all other methods of acquiring a root device (having the
> kernel mount a root device directly via the root= parameter, or using
> initramfs to mount and then switch_root to a new root) leave an empty
> rootfs at the top of the mount stack.

If you don't use rootfs you don't have to empty it, yes.

You could use an old-style initrd which would be mounted over the root
filesystem and which you could switch_root away from and then unmount. Then
pivot_root() could actually perform its as-designed function, although last I
checked it wasn't fully container-aware so tended to have fairly awkward global
impact if you ran it inside a container without being VERY careful. (Maybe it's
been fixed since?)

You could also have your own tar.xz in rootfs with a tiny busybox/toybox root to
extract it into the subdir so "cp -ax" didn't have a 2X memory high water mark.
You could even have a little static binary to call so you don't even need a
shell. Off the top of my head:

void main(void)
{
  mkdir("blah", 0777);
  mount("newroot", "blah", "tmpfs", 0, "noswap,size=37%,huge=within_size");
  if (!fork()) exec("tar", "tar", "xpC", "blah", "blah.txz", NULL);
  else wait();
  if (!fork()) exec("rm", "rm", "blah.txz", "init", "tar", "xzcat", NULL);
  else wait();
  if (chdir("/blah") || chroot(".") || exec("/init")) complain_and_hang();
}

Statically linked against musl-libc that's not likely to be more than 32k, it's
all syscalls. The tar and xzcat binaries are a bit bigger, but not unreasonable
in either busybox or toybox...

Or you could petition to add -x to mv I suppose. I could add it to toybox
tomorrow if you like? (And probably send a patch to Denys for busybox?)

> This commit adds a new build option - EMPTY_ROOTFS, available when
> initrd/initramfs is enabled. When selected, rather than unpacking the
> inbuilt / bootloader provided initramfs directly into rootfs, the kernel
> will mount a new tmpfs/ramfs over the top of the rootfs and unpack to
> that instead, leaving an empty rootfs at the top of the stack. This
> removes the need to have init copy everything as a workaround.

How is it a "workaround"? The userspace tool is as old as initramfs.

Your real complaint seems to be that a single ramfs instance is shared between
container instances, even when the PID 1 init process isn't. What you're
"working around" is incomplete container namespace separation, and you're doing
so by adding yet another kernel config option. You are _adding_ a workaround to
the kernel.

If you still need to complicate the kernel, wouldn't it make more sense to add a
runtime check for rootfstype=redundant or some such, and have _that_ do the
overmount (without needing a config symbol to micromanage a weird corner case
behavior)? If it's _init code it should be freed before launching PID 1...

Rob
