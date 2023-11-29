Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redcoat-dev.20230601.gappssmtp.com header.i=@redcoat-dev.20230601.gappssmtp.com header.b="CjuzqTH1"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B919BA
	for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 09:48:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b4c2ef5cdso27385e9.2
        for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 09:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redcoat-dev.20230601.gappssmtp.com; s=20230601; t=1701280124; x=1701884924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSFO0YpvZ2ifItm4R+1GCZRZ0pGLXkMBInXQS6srvRk=;
        b=CjuzqTH1exuZPVPty41DrbMlQWkemC06Z8Jzah9XAD058pMZX4G7mIO3nbzSSVbI8L
         c8436RvRv85/YwdqMYz4XomKD/mU0Tmb+oZ9/A2+n8TqIJJwsqImWSF4KLrl3WAs1buq
         MXhZA/bs5EuZzohBNzmjpwVLfVTqYXw4gDU0UtqiCdObUyIkTMY2l349NCQ3ORujSbO6
         sih15DLiEbvwgI1wjhjFiZYdbe6c5aYogq2BnaoJsaTKmuzO1JFoNwCOJYDl1iutY7AZ
         DdCMzq1zKLUQDzGIlWtX/Fut72sFrq+xNV6z4U/FhzCqffUmRvoMSIQ7ha8+X+dhARPG
         zS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701280124; x=1701884924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSFO0YpvZ2ifItm4R+1GCZRZ0pGLXkMBInXQS6srvRk=;
        b=GVszOe/CmiT8ga/z8ugh6cuX1I581aW0s/LzcuqeEH/DXZ4aYmDg0G9H6Ff2+0qqrH
         iiJ8CvDMHKEni9IRfNaLhpO6okSWZkkIEjdlSF052RFmj0Dx7SXYT8TthdoVl3fa49Ao
         8PJYlVykxTjgEeRN9RbodnE2EmxfCnNQuNN5zUJLTtoclcs5LQ6pFsHHtm8wYUX4Lt4Z
         pbxRclP60T5fYgkfSYjhNMSZf9EU86SEGO4x2SckTKZyZeRoAi26I6oLWKJ/U/FMaFHp
         yXqB3zMCEf+FjzznrODTWiesnwajm+aCaYjVV0JwtGtKEv+q0aUiciEJPRfRYBWlaNpG
         J7mA==
X-Gm-Message-State: AOJu0YywJdbAGMrEBt5sGJjiCWty3dJI2+++e982KxuS36lEbbZ39NWe
	sTIoiIcO6Ru5a0yh5iNbqwGrJsz+KlQbsLJ990/TYw==
X-Google-Smtp-Source: AGHT+IFBZD26oTxJYV54Th1XVx2224HowT9SapSb91mSz6k/auVMEoEDj5SU+6KZKpkBjTmclK5v3A==
X-Received: by 2002:adf:edc7:0:b0:332:e61e:43c3 with SMTP id v7-20020adfedc7000000b00332e61e43c3mr14074068wro.16.1701280123820;
        Wed, 29 Nov 2023 09:48:43 -0800 (PST)
Received: from test ([2a00:23c7:1fab:4e01:4915:193d:c8fb:a42c])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b003316b38c625sm18574453wro.99.2023.11.29.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:48:43 -0800 (PST)
Date: Wed, 29 Nov 2023 17:48:42 +0000
From: Emily Shepherd <emily@redcoat.dev>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, initramfs@vger.kernel.org, 
	Thomas =?utf-8?Q?Str=C3=B6mberg?= <t+github@chainguard.dev>, Anders =?utf-8?Q?Bj=C3=B6rklund?= <anders.f.bjorklund@gmail.com>, 
	Giuseppe Scrivano <giuseppe@scrivano.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] initramfs: Support unpacking directly to tmpfs
Message-ID: <rxh6knvencwjajhgvdgzmrkwmyxwotu3itqyreun3h2pmaujhr@snhuqoq44kkf>
References: <pkyfrfofquliqqxpylzzn5kdnfk4tewo6gx25d5m6pm2femvin@dkxlxm6leegu>
 <fc35ab36-c722-1102-36c5-6a2c015b2620@landley.net>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fc35ab36-c722-1102-36c5-6a2c015b2620@landley.net>

On Wed, Nov 29, 2023 at 10:38:48AM -0600, Rob Landley wrote:
>Because nobody's ever wanted to fix chroot() so mkdir("sub", 0777);
>chroot("sub"); chdir("../../../../.."); chroot("."); wouldn't escape it
>
>I
>would have thought you could use "mount --move . /" to nerf the cd ../../.. but
>for some reason it didn't work (I forget why) and nobody wanted to fix that either.

Actually move mounting the desired new root over the top of the old does 
mitigate the chroot & chdir attack. The main reason, I believe, that the 
runtime maintainers don't like that option is that, despite being 
"inaccessible", the old mount tree still exists in the container's mount 
namespace. This has led to issues such as the sysfs/procfs issue [1]: In 
summary, that attack worked by a process within a container creating a 
new userns, and giving that CAP_SYS_ADMIN.

In such cases, the kernel had protections in place to ensure that, even 
with the SYS_ADMIN capability, the process in the new userns wasn't 
allowed to mount proc or sysfs, unless a fully visible mount of 
proc/sysfs already exists in the process' mount namespace.

There was a bug in the kernel's visibility check - it checked if each 
instance of proc/sysfs in the mount namespace had been over mounted, or 
any of this subdirectories had, but forgot to check if any of its root 
directories had. This resulted in the original root's /proc / /sys 
mounts counting as visible, even though they weren't, which allowed the 
child userns to mount a fully unmasked instance and gain access to 
things it shouldn't.

Now, this was fixed in 7e96c1b0e0f495 however my assumption, and I don't 
want to speak on behalf of all runtime maintainers here, is that the 
advice to prefer pivot_root is because of the increased risk of bugs 
like these. When using pivot_root, the old root is able to be completely 
unmounted from the container's mount namespace after the pivot which, 
from a security perspective, gives better peace of mind.

There is at least one other fringe exploit that I am aware of when 
running in containers not using pivot root - this involves process 1 
within a container unmounting its root with MNT_DETACH. While this 
doesn't always allow that process itself to break out fully, it does 
allow subsequent calls to exec within the container to leak information 
about the host's root file system. This would not occur with pivot_root.

[1]: https://github.com/opencontainers/runc/pull/1962

>If you don't use rootfs you don't have to empty it, yes.

The point I meant was that this brings the initramfs flow in line with 
the other root approaches: for initrd, kernel handled root= mounts, and 
initramfs switch_root setups, rootfs exists because it has to at the top 
of the stack. For initramfs embedded systems, rootfs exists because it 
is the root - embedded linux actually using the rootfs as a root is the 
outlying behaviour.

>You could use an old-style initrd which would be mounted over the root
>filesystem and which you could switch_root away from and then 
>unmount.

You could, but isn't initramfs a more modern way to pack files than the 
initrd? And is it not reasonable to bring (or at least give the option 
for) the initramfs flow to be a bit more like the initrd flow? (Ie, with 
an empty rootfs).

>pivot_root() could actually perform its as-designed function, although 
>last I
>checked it wasn't fully container-aware so tended to have fairly awkward global
>impact if you ran it inside a container without being VERY careful. (Maybe it's
>been fixed since?)

Most container runtimes that I am aware of would run a container within 
their own mount namespace so pivot_root should be safe from the rest of 
the system's point of view. Indeed pivot_root is the preferred option 
for container runtimes but cannot be used when running directly from 
rootfs.

>
>You could also have your own tar.xz in rootfs with a tiny busybox/toybox root to
>extract it into the subdir so "cp -ax" didn't have a 2X memory high water mark.
>You could even have a little static binary to call so you don't even need a
>shell. Off the top of my head:
>
>void main(void)
>{
>  mkdir("blah", 0777);
>  mount("newroot", "blah", "tmpfs", 0, "noswap,size=37%,huge=within_size");
>  if (!fork()) exec("tar", "tar", "xpC", "blah", "blah.txz", NULL);
>  else wait();
>  if (!fork()) exec("rm", "rm", "blah.txz", "init", "tar", "xzcat", NULL);
>  else wait();
>  if (chdir("/blah") || chroot(".") || exec("/init")) complain_and_hang();
>}
>
>Statically linked against musl-libc that's not likely to be more than 32k, it's
>all syscalls. The tar and xzcat binaries are a bit bigger, but not unreasonable
>in either busybox or toybox...

Yep, I completely get this - and it is a good point. This is definitely 
a gray area on the "what should the kernel do vs what should we let 
userspace init handle". My reasoning for including it in the kernel is 
that all of the userspace init options to handle this (ie untaring 
something, or copying everything over straight away) amount to "double 
zipping" or moving something that the kernel has just extracted. This is 
a bit of a shame to require userspace to do, especially when it is a 
trivial patch to just have the kernel extract the initramfs to where we 
want it in the first place.

>
>Or you could petition to add -x to mv I suppose. I could add it to toybox
>tomorrow if you like? (And probably send a patch to Denys for busybox?)

I'm not sure how adding it to busybox would help - as you have already 
show, there are existing userspace workarounds (and I referred to two 
others in the patch's changelog: the tiny core linux and minikube init 
examples) so I'm not sure we need more?

>How is it a "workaround"? The userspace tool is as old as initramfs.

Because it takes a thing that has just been extracted and moves it 
somewhere else. That is a workaround for it not being in the right 
place.

>Your real complaint seems to be that a single ramfs instance is shared 
>between
>container instances, even when the PID 1 init process isn't.

Well, when rootfs is empty, it doesn't really matter that it's shared 
with all mount namespaces. My issue isn't with that, it's that the 
embedded initramfs flow is the one and only time that rootfs can't be 
relied upon to be empty.

>What you're
>"working around" is incomplete container namespace separation, and you're doing
>so by adding yet another kernel config option. You are _adding_ a workaround to
>the kernel.

What you are calling incomplete container namespace separation is the 
kernel's inability to unmount rootfs ever? I don't think that's a flaw - 
the logic for it makes perfect sense, you always have a rootfs so that 
you don't accidentally empty the mount tree. What doesn't make sense is 
then using that rootfs for anything more than that "stopper" under a 
"real" root - that's where the problems come in when attempting to swap 
roots for containers.

>If you still need to complicate the kernel, wouldn't it make more sense 
>to add a
>runtime check for rootfstype=redundant or some such, and have _that_ do the
>overmount (without needing a config symbol to micromanage a weird corner case
>behavior)? If it's _init code it should be freed before launching PID 1...

The context that I'm talking about is situations where the init process 
within initramfs doesn't hand over to another init. This is for embedded 
initramfs situations.

I could do another version of the patch to check in the kernel for a 
rootfstype parameter if you like and work off of that rather than a 
build flag? Or would you not want that check within the kernel at all?

-- 
Emily Shepherd

Red Coat Development Limited
