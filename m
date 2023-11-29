Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="c4AciJeY"
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF510EA
	for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 12:48:29 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2ec9a79bdso121855b6e.3
        for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 12:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1701290908; x=1701895708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1v+1FhoJza0hVDcfRR8tDYf9Yx8kzs5Rekt23c97LDc=;
        b=c4AciJeYO243bITClJqNVEE3IgSnTiPlLDmAP4qiJeEGanWM0wY41qeUYfbF66lvmh
         kMh8U+IX3LyGH+Hrg0QhLe5aJFcdXMt5V+TEHGcNS33tKaBnua2KowU8h7psNakB6o4m
         Dut6r+wjf3M3F2QeKYWH+0XcEsisZyZBzRP9yxI3Bzb12mQfVhtXvtynlcGylV6Vc8n9
         wHLqGPCxq4Zs13psa7Db0UH7zbkCcwcTsE53L54bpkwK663QnR2WP25sNxum6XzYyfYH
         9Mq3USVNXqroaEH5ozfm8l+59mb4pr98uj9aCBVQB+1WqamzcFxadN912COkmdRi1RL+
         ZSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290908; x=1701895708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1v+1FhoJza0hVDcfRR8tDYf9Yx8kzs5Rekt23c97LDc=;
        b=UrJqohSQpuFV5znqSjIQk+CcJv+cxR59bhDjmmRJYxVAiM6PMbuVJySHxPD83YnmCQ
         DvO3Hd9z6a5CZTakM7/nLnDFe/Ly1WR7EqWNk8DaZfMZ6hLBvYp6pSbG9Qq56In/r7ok
         AYxRgUVdmOt3WIRfdu1EpQ9jo1bz5AkOTepFBWqvIInwvT780ZG8wNcHuiQVQkCvfxlk
         odO5Ft82vT7NkBJgECLBVi41ljMBjRQa2NmGxih0pKzw/8dK8CMAIrW8Hr49B+f+wxmC
         qB71BwQ5GQhAZBx1Dnf4RTNrzg8QPCkti0MNqBm9WFKJFsnE+9utTDzr7hD38LeQvIM9
         ljew==
X-Gm-Message-State: AOJu0YzPM2uiETwhaGEvfoXcUhCT+YSQV+sAQfvwMVytbf/amxCAVgiq
	TlpcZgyk2cfskhJOWuAndPFqbA==
X-Google-Smtp-Source: AGHT+IE824OO6l5cx4J+u1tk6rrN9G63yDaKbJXYkTLna8H8Ey0d94iBy5syBwJPPvAl/JfpukJ6PQ==
X-Received: by 2002:a05:6808:1707:b0:3b2:e5cb:8e53 with SMTP id bc7-20020a056808170700b003b2e5cb8e53mr24537348oib.10.1701290908256;
        Wed, 29 Nov 2023 12:48:28 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id bh37-20020a056808182500b003b83464a376sm2349142oib.44.2023.11.29.12.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 12:48:28 -0800 (PST)
Message-ID: <cec90924-e7ec-377c-fb02-e0f25ab9db73@landley.net>
Date: Wed, 29 Nov 2023 14:53:49 -0600
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
To: Emily Shepherd <emily@redcoat.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, initramfs@vger.kernel.org,
 =?UTF-8?Q?Thomas_Str=c3=b6mberg?= <t+github@chainguard.dev>,
 =?UTF-8?Q?Anders_Bj=c3=b6rklund?= <anders.f.bjorklund@gmail.com>,
 Giuseppe Scrivano <giuseppe@scrivano.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
References: <pkyfrfofquliqqxpylzzn5kdnfk4tewo6gx25d5m6pm2femvin@dkxlxm6leegu>
 <fc35ab36-c722-1102-36c5-6a2c015b2620@landley.net>
 <rxh6knvencwjajhgvdgzmrkwmyxwotu3itqyreun3h2pmaujhr@snhuqoq44kkf>
From: Rob Landley <rob@landley.net>
In-Reply-To: <rxh6knvencwjajhgvdgzmrkwmyxwotu3itqyreun3h2pmaujhr@snhuqoq44kkf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/23 11:48, Emily Shepherd wrote:
> On Wed, Nov 29, 2023 at 10:38:48AM -0600, Rob Landley wrote:
>>Because nobody's ever wanted to fix chroot() so mkdir("sub", 0777);
>>chroot("sub"); chdir("../../../../.."); chroot("."); wouldn't escape it
>>
>>I
>>would have thought you could use "mount --move . /" to nerf the cd ../../.. but
>>for some reason it didn't work (I forget why) and nobody wanted to fix that either.
> 
> Actually move mounting the desired new root over the top of the old does 
> mitigate the chroot & chdir attack. The main reason, I believe, that the 
> runtime maintainers don't like that option is that, despite being 
> "inaccessible", the old mount tree still exists in the container's mount 
> namespace.

I'm assuming you can do process-local unmounts to prune what you'd be
overmounting? (switch_root didn't _have_ to delete the old initramfs contents,
it did it to free space. Containers similarly would remove privileges as part of
their setup, and that includes mounts the new context shouldn't have.)

Alas, mount separation was implemented in multiple stages with MS_SHARED
predating CLONE_NEWNS, plus fun with --bind mounts and /proc and /sys leaking
various forms of weird (and an explicit refusal to have namespace aware devtmpfs
instances which just seems _sad_), and I'm never confident there isn't some new
thing I'm missing or old thing I've forgotten/missed...

> This has led to issues such as the sysfs/procfs issue [1]: In 
> summary, that attack worked by a process within a container creating a 
> new userns, and giving that CAP_SYS_ADMIN.

From reading the link's summary, it seems like "unmount the old inherited /proc
and /sys before you "mount --move newfs /" seems like it would have been a fix?
Dunno, wasn't following it...

> In such cases, the kernel had protections in place to ensure that, even 
> with the SYS_ADMIN capability, the process in the new userns wasn't 
> allowed to mount proc or sysfs, unless a fully visible mount of 
> proc/sysfs already exists in the process' mount namespace.
> 
> There was a bug in the kernel's visibility check - it checked if each 
> instance of proc/sysfs in the mount namespace had been over mounted, or 
> any of this subdirectories had, but forgot to check if any of its root 
> directories had. This resulted in the original root's /proc / /sys 
> mounts counting as visible, even though they weren't, which allowed the 
> child userns to mount a fully unmasked instance and gain access to 
> things it shouldn't.
> 
> Now, this was fixed in 7e96c1b0e0f495 however my assumption, and I don't 
> want to speak on behalf of all runtime maintainers here, is that the 
> advice to prefer pivot_root is because of the increased risk of bugs 
> like these. When using pivot_root, the old root is able to be completely 
> unmounted from the container's mount namespace after the pivot which, 
> from a security perspective, gives better peace of mind.

Lazy unmount it (which never affects a process's open files, including the "/"
and "." symlinks in each process), then mount --move so the visibility hides it,
then teach the kernel that "overmounted" lets lazy unmounts go. (Which it
_might_ already do if the reference count falls to 0 because of "." and "/"
leaving, although you'd have to make sure no other open file descriptors
referenced it in your current namespace from /dev entries and just plain
inherited filehandles...)

But it seems doable?

> There is at least one other fringe exploit that I am aware of when 
> running in containers not using pivot root - this involves process 1 
> within a container unmounting its root with MNT_DETACH. While this 
> doesn't always allow that process itself to break out fully, it does 
> allow subsequent calls to exec within the container to leak information 
> about the host's root file system.

Lemme guess, the child does something like:

for (i = 0; i<32767; i++) close(i);
mkdir("sub/blah")
mount("sub", "sub", "tmpfs");
chdir("sub");
umount(".", MNT_DETACH);
chroot("blah");
chdir("../../../..");
chroot(".")
readdir();

> This would not occur with pivot_root.

It would not occur if the filesystem had been removed from the current mount
namespace by other means, either. (Or if the kernel got the test right, which
you're saying it does now.)

> [1]: https://github.com/opencontainers/runc/pull/1962
> 
>>If you don't use rootfs you don't have to empty it, yes.
> 
> The point I meant was that this brings the initramfs flow in line with 
> the other root approaches: for initrd, kernel handled root= mounts, and 
> initramfs switch_root setups, rootfs exists because it has to at the top 
> of the stack. For initramfs embedded systems, rootfs exists because it 
> is the root - embedded linux actually using the rootfs as a root is the 
> outlying behaviour.

Back when I was trying to get /dev/console to work properly with init=/bin/sh I
didn't ask for a kconfig option to make the initial task be PID 2 with PID 1
(and its magic signal-blocking properties and inability to call reboot() and
session ID 0 and orphaned zombies reparented to it so on) being a second idle
task. I figured out how to make my userspace do the right thing.

This really seems like an "init starts as PID 2" solution, which is a weird
thing to have a dedicated build-time kernel config option for.

>>You could use an old-style initrd which would be mounted over the root
>>filesystem and which you could switch_root away from and then 
>>unmount.
> 
> You could,

So there's already a(nother) fix.

> but isn't initramfs a more modern way to pack files than the 
> initrd?

It's a different archive format. Feed it a squashfs if you're just gonna pivot
away soon, that's created like an archiver.

> And is it not reasonable to bring (or at least give the option 
> for) the initramfs flow to be a bit more like the initrd flow? (Ie, with 
> an empty rootfs).

You want to use rootfs but not use rootfs. It's very zen.

"initramfs" is an extractor to populate "rootfs" before launching PID 1. That
was the design. (From Al Viro I think.)

If you'd like to go "I want to have the kernel automatically mount a freshly
formatted ext4 filesystem and then have the kernel extract the cpio archive into
that instead, because it's more convenient for me to have the kernel do this for
me than doing it in userspace"...

*shrug* It's not my call and I can't predict what the kernel devs will do these
days, but... ow?

>>pivot_root() could actually perform its as-designed function, although 
>>last I
>>checked it wasn't fully container-aware so tended to have fairly awkward global
>>impact if you ran it inside a container without being VERY careful. (Maybe it's
>>been fixed since?)
> 
> Most container runtimes that I am aware of would run a container within 
> their own mount namespace so pivot_root should be safe from the rest of 
> the system's point of view.

The first time I ran pivot_root within a CLONE_NEWNS it chrooted all the
processes in the entire system from / into the new root, because I hadn't run it
in a CLONE_NEWPID namespace and it didn't have a filter for the fact those
processes couldn't SEE the new root because they weren't in its namespace. (I
mean I _think_ that's what happened, the system hung pretty fast and I had to
reboot it.)

Hopefully it's less brittle now, but I haven't retried recently.

> Indeed pivot_root is the preferred option 
> for container runtimes but cannot be used when running directly from 
> rootfs.

If you fix the mount --move issues you could bind mount your current directory,
cd $PWD, and then --move mount it to /.

I think you're addressing the wrong issue.

>>Statically linked against musl-libc that's not likely to be more than 32k, it's
>>all syscalls. The tar and xzcat binaries are a bit bigger, but not unre asonable
>>in either busybox or toybox...
> 
> Yep, I completely get this - and it is a good point. This is definitely 
> a gray area on the "what should the kernel do vs what should we let 
> userspace init handle".

Back in the day I wrote busybox's switch_root and
Documentation/filesystems/ramfs-rootfs-initramfs.txt and I recently had a long
argument with somebody about how my 310 line bash script
(https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh) that builds
Linux systems from source for a dozen architectures and boots them to a shell
prompt under qemu was using (for one of the architectures) a static cpio.gz
linked into the KERNEL IMAGE to populate initramfs and this was just a CRAZY
thing that NOBODY EVER DOES... (No really,
https://landley.net/notes-2023.html#12-05-2023).

So my perspective is apparently a bit skewed. Maybe I"m too close to the problem
to see it...

> My reasoning for including it in the kernel is 
> that all of the userspace init options to handle this (ie untaring 
> something, or copying everything over straight away) amount to "double 
> zipping" or moving something that the kernel has just extracted. This is 
> a bit of a shame to require userspace to do, especially when it is a 
> trivial patch to just have the kernel extract the initramfs to where we 
> want it in the first place.

As with the trivial patch to have init= launch PID 2, the cognitive load of
explaining to people WHY the config option exists and when somebody might have
wanted to use it in the kernel you're trying to forward port in a design you
inherited from somebody who isn't around anymore is itself a form of design
complexity. It's a special case _adding_ a design wart.

Different kernels working different ways with a bunch of special cases replacing
design don't get _better_ over time. "This is what that's for. Except not really..."

>>Or you could petition to add -x to mv I suppose. I could add it to toybox
>>tomorrow if you like? (And probably send a patch to Denys for busybox?)
> 
> I'm not sure how adding it to busybox would help - as you have already 
> show, there are existing userspace workarounds (and I referred to two 
> others in the patch's changelog: the tiny core linux and minikube init 
> examples) so I'm not sure we need more?

Because mv doesn't extact twice and the memory high water mark isn't
significantly higher. If you cp -a and then rm -r the memory usage high water
mark is "all the files briefly exist twice". With mv across filesystems, only
the largest single file existing twice is the memory usage high water mark.

A couple years after I taught initramfs to mount tmpfs instead of just ramfs
(which was in 2013), somebody came to me needing to force it BACK to ramfs
because their cpio wouldn't extract into tmpfs... because if you don't specify
arguments to tmpfs then the "size=" defaults to 50% of available memory and
their cpio.gz extracted to a little over 60%. (But the system still worked
fine... with ramfs. With tmpfs the cpio.gz extract aborted when the filesystem
refused further writes, and since I hadn't wired up the rootflags= plumbing
(ramfs didn't take any flags) there was no way to tell the tmpfs instance to
allow a larger size.

Alas, that's another one of the patches that I couldn't get the linux-kernel
bureaucracy to notice. I don't think it ever did go upstream. Yeah, in
init/do_mounts.c() it looks like  root_mount_data is only ever used in
mount_root_generic()'s call to do_mount_root() but not passed through to
rootfs_init_fs_context() and the call to shmem_init_fs_context().

*shrug* The usual...

>>How is it a "workaround"? The userspace tool is as old as initramfs.
> 
> Because it takes a thing that has just been extracted and moves it 
> somewhere else. That is a workaround for it not being in the right 
> place.

You're asking the kernel to create a second empty ramfs or tmpfs instance, and
instead of checking an existing argument like "root=tmpfs" you're changing the
kernel's behavior with a dedicated config option that does a specific thing.

What happens if somebody sets that config option and then goes root=/dev/sda2

In theory making the rootfs directory neither readable nor executable to the PID
you've mapped root to in the container is anther approach. There's a LOT you can
already do in userspace about this...

>>Your real complaint seems to be that a single ramfs instance is shared 
>>between
>>container instances, even when the PID 1 init process isn't.
> 
> Well, when rootfs is empty, it doesn't really matter that it's shared 
> with all mount namespaces.

Yes, that is your "workaround" to the real problem.

> My issue isn't with that, it's that the 
> embedded initramfs flow is the one and only time that rootfs can't be 
> relied upon to be empty.
Your "one and only time" is an awful lot of embedded systems. It's a common use
case. The point of having initramfs be tmpfs is you can _persist_ in using it as
your root filesystem without an errant log file filling up memory and hanging
the system (a problem with ramfs). Whatever your container stuff is, it won't be
able to run on any of those existing systems that keeps initramfs populated with
files. So again why have it be a config option: if you're going to change the
behavior, change it for EVERYBODY or your stuff will need a special kernel
configuration in order to run.

Heck, Debian populates initramfs with a cpio.gz file as part of its normal boot
process:

$ zcat /boot/initrd.img-4.19.0-22-amd64  | toybox file -
-: ASCII cpio archive (SVR4 with no CRC)

Has done for over a decade. You're saying debian can clean up but your stuff
can't be expected to.

You want rootfs to be a NULLFS instead of ramfs. You don't seem to want it to
actually _be_ a filesystem. Even with your "fix", containers could communicate
with each _other_ through it if it becomes accessible. If a container can get
access to an empty initramfs and write into it, it can ask/answer the question
"Are there any other containers on this machine running stux24" and then coordinate.

Really seems to me like you're addressing the wrong issue. You want a design
change to Linux, and you're phrasing it as a config option. The design change
has side effects and "support both modes, forever" is the proposed answer to that.

>>What you're
>>"working around" is incomplete container namespace separation, and you're doing
>>so by adding yet another kernel config option. You are _adding_ a workaround to
>>the kernel.
> 
> What you are calling incomplete container namespace separation is the 
> kernel's inability to unmount rootfs ever? I don't think that's a flaw - 
> the logic for it makes perfect sense, you always have a rootfs so that 
> you don't accidentally empty the mount tree. What doesn't make sense is 
> then using that rootfs for anything more than that "stopper" under a 
> "real" root - that's where the problems come in when attempting to swap 
> roots for containers.

If you want a NULLFS, that is a design change. Maybe ask for the design change
so THAT can be discussed. Your config option seems like a partial fix at best,
and the kernel has enough abandoned partial fixes needing legacy support.

>>If you still need to complicate the kernel, wouldn't it make more sense 
>>to add a
>>runtime check for rootfstype=redundant or some such, and have _that_ do the
>>overmount (without needing a config symbol to micromanage a weird corner case
>>behavior)? If it's _init code it should be freed before launching PID 1...
> 
> The context that I'm talking about is situations where the init process 
> within initramfs doesn't hand over to another init. This is for embedded 
> initramfs situations.

If your package grows a dependency on a new kernel symbol, then it can only be
installed into certain kernels, and it's the _explaining_why_ that's the problem
for me.

Embedded initramfs situations are actually quite common in my (admittedly weird)
experience.

For context, my mkroot script above builds systems that boot to a shell prompt
mostly[1] under qemu running out of initmpfs, which means I deal with "system
runs out of rootfs" pretty much every day. I even ship them, extract any of
https://landley.net/bin/mkroot/latest/ and ./run-qemu.sh for example.

I then run https://github.com/landley/toybox/blob/master/mkroot/testroot.sh
against the results which launches them all for basic regression smoketesting
that the network and block devices and so on work (on each new toolchain, linux,
toybox, and qemu version). That part works today.

Next up I'm trying to get it to run the full toybox regression test suite (make
tests) but I need to do more work on the toybox shell for it to be a proper bash
replacement, and then there's a lot of "how _do_ I test insmod, how _do_ I test
ps" design work that I can't properly start until I have a known environment
running as root... that can run the test suite. (The toybox shell isn't quite
finished yet, and nerfing a test suite bash can already run seems
counterproductive. Working on it...)

And THEN I'm trying to get it to build Linux From Scratch in an automated
fashion using the native compilers that scripts/mcm-buildall.sh produces (the
*-native.sqf squashfs images in https://landley.net/bin/toolchains/latest/),
which I actually already DID in a previous life...

Back when I was maintaining busybox, I was working to get Linux From Scratch to
build natively under a busybox-based system built from seven packages (gcc,
binutils, linux, make, busybox, uClibc, bash), and I succeeded (with LFS 6.8):

https://landley.net/aboriginal/about.html
https://github.com/landley/control-images/tree/master/images/lfs-bootstrap

After I got that working, distributions like Alpine Linux built themselves
around busybox, because now a simple busybox-based system can provide a full
build environment you can add arbitrary packages to by building them from
source. Trying to make that work is _why_ I wound up maintaining busybox back in
the day. It's also why I got into initramfs early, because my old "append the
root filesystem and teach lilo to load the initrd image from a file starting at
an offset" hack for getting the kernel and root filesystem into the same file
back in the https://landley.net/aboriginal/old/ days was... well for one thing
the lilo maintainer wouldn't take my "offset=" argument patch upstream, and grub
was already replacing lilo, and I needed a DIFFERENT hack for User Mode Linux...

Now I'm trying to do it all again with toybox instead of busybox, and also with
80% of the earlier project replaced by a 300 line bash script because I figured
out how to do it in a simpler way. Along the way I switched from uClibc to
musl-libc, user mode linux to qemu, from a zisofs root filesystem to initramfs
(and the implemented initmpfs because somebody needed to)...

Anyway, if you're wondering why I popped up in your cc: list... :)

[1]  The exception is the sh2eb board which builds a kernel for actual hardware,
a j-core FPGA with a ROM bootloader that knows how to run a vmlinux but does NOT
know how to load an external cpio.gz the way qemu's built-in bootloader does, so
I statically linked the cpio.gz into the kernel, that's what the BUILTIN=1 in
that build script does. (Which that person I was arguing with kind of bounced
off when he saw it, as against the natural order of things, or something? The
thing is that board had use cases that needed to do a chain-of-custody thing,
the hardware will cryptographically validate the vmlinux it loads but then the
running linux system has to validate anything else it loads and having the
cpio.gz built in to only one "kernel" image saved a step in a small ROM, and the
potential problem of detecting out-of-sync files if there's more than one. New
kernel with old userspace or vice versa, dunno if it's an attack vector but not
going there.)

> I could do another version of the patch to check in the kernel for a 
> rootfstype parameter if you like and work off of that rather than a 
> build flag? Or would you not want that check within the kernel at all?

I think checking root=tmpfs or rootfstype=overlay or whatever user interface
seems natural to you is a better approach, yes.

Adding a special purpose config option that requires a lot of backstory is a
potential additional cognitive load on everyone learning to configure Linux
beyond the "ignore everything you don't recognize" level (let alone modify that
part of the code). The embedded people especially are the ones who have to learn
why they don't need it.

Runtime flags can be flipped later, build time flags you have to get right
before you ship.

I personally care because if you look at (for example)
https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh#L232 everything
it knows about the s390x platform is on those three lines. The KCONF= is CSV
symbols that get expanded into the device-specific CONFIG_BLAH=y (or
CONFIG_BLAH="whatever" if the CSV symbol already has an = in it, which are
appended to the generic config symbols on
https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh#L270 that apply
to all boards (BLK_DEV_LOOP and EXT4_FS and so on), which is expanded into a
miniconfig, ala:

https://landley.net/aboriginal/FAQ.html#dev_miniconfig
https://lwn.net/Articles/161086/

Which is then expanded into a full kernel .config via "make allnoconfig
KCONFIG_ALLCONFIG=mini.conf".

Which means that when I'm adding support for a new board, I do look at every
symbol that's set to try to understand what it does and whether it's needed. I
have some tools to help (like
https://github.com/landley/aboriginal/blob/master/more/miniconfig.sh to convert
a big .config file into a miniconfig in an ugly but automated fashion (yank each
line and feed it back through allnoconfig to see if the result changes or not;
if it doesn't change the line wasn't needed). A miniconfig is literally just the
list of symbols that you'd have to set if you started from allnoconfig and let
the dependency resolver do its thing.

Again, I may be weird. But I mostly hang out in the embedded space, where there
are an awful lot of weird people who do work in this space. (And sadly most of
them literally cannot be PAID to interact with what the linux-kernel community
has become over the past ~15 years, so the viewpoint tends to be a bit
chronically under-represented here.)

Rob
