Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="ML1jsL75"
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D821FF4
	for <initramfs@vger.kernel.org>; Fri,  1 Dec 2023 13:57:28 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2f4a5ccebso667788b6e.3
        for <initramfs@vger.kernel.org>; Fri, 01 Dec 2023 13:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1701467848; x=1702072648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KDCWdNh4+3/EW/4SDdBX7WaHWg8sAI5TINhdc41b/U=;
        b=ML1jsL758rTLiJC2QmRlXOTr4TWDs2TtOPwTVEx7A7Wqf/lFf971REh0vqmCbW8kTj
         7Rv9lChG9CYg80n/q8QPQrgk7wo3u4CMsgjMi6t15NCvjq63E1lF8hInnVBrZBAlMRpa
         WINqG1EFowyytEpmUFgg0PlZx2759vdc3/Z88jKQtWIffllQbmMBozbkS8jK+60KlEd4
         fj3n6OSdup390xnfRBDyZw3JClT/ru2LcocHxw0Sb/AFV2oJ7RjFnmU3t4atmMrQTgXg
         XKUHwCB24BF3a7pGUSp19v6YQEQOWyrmICVB07fpNOc22dvIcRNH35oP2rnunfgOozfm
         DTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701467848; x=1702072648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KDCWdNh4+3/EW/4SDdBX7WaHWg8sAI5TINhdc41b/U=;
        b=ElCi4ej34CIv9eAkheMeHyN6ZVI/E+TexiF4C7WLiyUIIolKMEVTosUcLwqls7uzNL
         mIzftmoGELkFWsSYFzs7XZ6rivaLcfJHk694nwOSFXjdw7jcgEhz6QbdQ9c+2+0bUmGz
         sx4uE0U0ZmRXDtQPWERfsK4V6YLTXWdaUNI/Z1yt8kvETomLvIZcHTMAJi0+H1wLZqVh
         IcZmJauCGjf1us7j++FLm+Jb+qmMZrwTORd+whddyc8ckCiU0NxaHc78O2pEOlydWXkb
         MtFWpPuzkrjfZE3PcyhnpyjD9Wwv3ACcNwijM8dfFK1f/wWvdczegThZZvPeAcPtM8jb
         cDQA==
X-Gm-Message-State: AOJu0YxCFBEBJonsejo96VenXVr35f+54HBuI160gtYQzjRHeVwwQQsM
	vlQ42gnnt05JT1tmBkct1PKjPbItTwWw0qL0qCK8Hw==
X-Google-Smtp-Source: AGHT+IHGeq2NzPybgz6V4ZbNiMrdeyZePA2+mhVw8rVBD+VRPvNQIktX4MMBlrKH/nwL/I548yp0Kw==
X-Received: by 2002:a05:6808:118d:b0:3b5:8586:b17e with SMTP id j13-20020a056808118d00b003b58586b17emr232988oil.52.1701467847874;
        Fri, 01 Dec 2023 13:57:27 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id b5-20020a056808010500b003af642cf646sm689938oie.37.2023.12.01.13.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 13:57:27 -0800 (PST)
Message-ID: <dbeb7b4b-b5e6-15ba-7e74-f9ffdd07059b@landley.net>
Date: Fri, 1 Dec 2023 16:02:50 -0600
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
 <cec90924-e7ec-377c-fb02-e0f25ab9db73@landley.net>
 <37yuynohcuve46jhgzbz24ip6yb2lqvwcn6gpxwxpw6msgtk4b@7dgqfkdtjngb>
From: Rob Landley <rob@landley.net>
In-Reply-To: <37yuynohcuve46jhgzbz24ip6yb2lqvwcn6gpxwxpw6msgtk4b@7dgqfkdtjngb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/23 21:31, Emily Shepherd wrote:
> On Wed, Nov 29, 2023 at 02:53:49PM -0600, Rob Landley wrote:
>>I'm assuming you can do process-local unmounts to prune what you'd be
>>overmounting? (switch_root didn't _have_ to delete the old initramfs contents,
>>it did it to free space. Containers similarly would remove privileges as part of
>>their setup, and that includes mounts the new context shouldn't have.)
> 
> I think we are talking at cross purposes here, let's get back on track: 
> The aim is to do a pivot_root within a container's mount namespace.

Your aim is. You are starting from your conclusion and reasoning backwards.

> In 
> order to do this, we need at least two layers of "root" in the host 
> mount namespaces. If there is just one (ie rootfs), we can't pivot_root, 
> because rootfs cannot be removed.
> 
> Yes, you can switch_root or chroot or do any number of things, but that 
> is not relevant.

Those approaches have worked fine for many people for many years.

Possibly I'm biased, I thought using pivot_root was silly when I learned
containers were doing it back in 2011:

  https://landley.net/notes-2011.html#02-06-2011

(It's a pity the sourceforge link doesn't work anymore. Cloud rot.)

> That is not the way container runtimes tend to work. 
> The desirable outcome is pivot_root.

Still reasoning backwards from your conclusion. But sure, let's accept for the
sake of argument that you're stuck with a bad legacy decision in userspace. Is a
kernel config option the best way to compensate vs checking root=tmpfs?

>>From reading the link's summary, it seems like "unmount the old 
>>inherited /proc
>>and /sys before you "mount --move newfs /" seems like it would have been a fix?
> 
> It was the patch that was made in the container runtimes at the time, 
> yes. This does not change the fact that the _desirable_ path is 
> pivot_root.

https://en.wikipedia.org/wiki/Proof_by_assertion

>>> This would not occur with pivot_root.
>>
>>It would not occur if the filesystem had been removed from the current mount
>>namespace by other means, either. (Or if the kernel got the test right, which
>>you're saying it does now.)
> 
> You can't remove it if it's rootfs. If your host's root is rootfs, as it 
> would be if you run directly from initramfs, you can't unmount it.

You can't remove rootfs even if you do overmount something on top of it. You can
only delete its contents, it's still a writeable filesystem shared between all
container instances. A userspace tool was provided to delete its contents many
years ago. Said tool has been in util-linux since 2009
(https://github.com/util-linux/util-linux/commit/711ea7307d54) and they copied
the name from https://git.busybox.net/busybox/commit/?id=0f34a821ab99 from 2005.

If "the same rootfs is potentially exposed into every container namespace, which
is a problem even after it's been emptied" is the issue, your patch doesn't
address it. If it's NOT the issue, userspace has been able to achieve the state
you want without your patch since initramfs was created.

Your argument is "I don't want to". Which isn't a deal-breaker, but is the
context in which I'm reacting to the design change.

>>Back when I was trying to get /dev/console to work properly with 
>>init=/bin/sh I
>>didn't ask for a kconfig option to make the initial task be PID 2 with PID 1
>>(and its magic signal-blocking properties and inability to call reboot() and
>>session ID 0 and orphaned zombies reparented to it so on) being a second idle
>>task. I figured out how to make my userspace do the right thing.
>>
>>This really seems like an "init starts as PID 2" solution, which is a weird
>>thing to have a dedicated build-time kernel config option for.
> 
> I am afraid I do not understand this point at all. This change is not 
> requesting anything like this.

If I wanted the kernel to launch an init task for me, but I didn't want that
init task to be on PID 1, and I said that PID 1 has a bunch of strange
properties so it's inappropriate for that to run my code, and I proposed a patch
with a dedicated config option to do that, this would be analogous to the patch
you've presented.

If someone responded "you can call fork()" and I tried to come up with reasons
other than "I don't want to"... at that point we're in a Jim Jeffries routine.

And no this isn't an entirely hypothetical case, this was me scratching my head
for more than a year back in the busybox days, pestering people on IRC while
working out out to write oneit.c:

http://lists.busybox.net/pipermail/busybox/2008-November/067722.html

>>You want to use rootfs but not use rootfs. It's very zen.
> 
> No, I want an initramfs, I just don't want it on rootfs.

There's ways of dealing with that. Have been for a while. I would respond to a
dedicated CONFIG_INIT_ADJUST to have PID 1 be a second idle task and put init=
on PID 2 fairly similarly.

> If I mount a 
> block device as root, that wouldn't be rootfs either.

I am aware of that, yes. I think I suggested it.

You are reasoning backwards from your solution and not thinking about the
design. I don't think you're addressing the real issue.

Right now "separate" container namespaces all share a common rootfs instance.
They do NOT share a common init task, even though before containers that was
universal. You can have your own PID namespace, which starts _empty_.

Your mount tree in a container does NOT start empty. From the clone(2) man page:

  If  CLONE_NEWNS  is  set,  the  cloned child is started in a new
  mount namespace, initialized with a copy of the namespace of the parent.

Defaulting to having everything in it and removing what you don't want to keep
is very different from what PID or UID namespaces do, and is causing you
problems. Doing a chroot is basically an overmount, the other mount points are
still there in your tree and accessable if you try hard enough, and rootfs is
common to all containers. Mitigating this requires cleanup work that isn't
always even possible to fully do (ala rootfs actually being used, which does
happen a lot today and it's always accessible if a static process forking its
own mount namespace does enough umounts, which can then act as a
cifs/nfs/9p/rsync server out to the parent or some such).

Logically, extending the kernel to have a CLONE_NEWROOTFS where it gets a _new_
ramfs or tmpfs instance, unique to that namespace, at the root of a new empty
mount tree, is the logical fix. There is then design work around "so what API do
you use to populate it" which could range from "the first int below child_stack
is the fd of a cpio.gz to extract into it and then it launches an /init out of
there the way the host linux boots" through "the new child starts suspended ala
vfork/ptrace and then the parent process initializes it and unblocks it" to "the
init task is running the executable from the host context that called clone and
has inherited the existing open filehandles from the host context, although
despite the openat() family being in posix-2008 we sadly don't appear to have a
mountat()...". I dunno. That's design work to properly fix the issue.

You don't want to address the design problem, you want to add a special case
workaround for your current issue. You see doing that as a "design fix". I do not.

>>If you'd like to go "I want to have the kernel automatically mount a 
>>freshly
>>formatted ext4 filesystem and then have the kernel extract the cpio archive into
>>that instead, because it's more convenient for me to have the kernel do this for
>>me than doing it in userspace"...
> 
> Not what this patch is suggesting.

Yes, I've noticed.

My objection is "that may not be not the right fix at the design level" and your
response is "my patch didn't implement what you're talking about".

> The kernel already supports mounting a block device, in lieu of a 
> userspace init doing it, via the root= parameter. Are you suggesting its 
> support of that is inappropriate?
> 
>>If you fix the mount --move issues you could bind mount your current 
>>directory,
>>cd $PWD, and then --move mount it to /
>>
>>I think you're addressing the wrong issue.
> 
> No, I'm fixing the fact that container runtimes want to pivot_root, and 
> can't when running directly from initramfs, as this extracts to rootfs.

Which you can already do with switch_root, with initrd, with a static binary
calling mount/mv/chroot, and probably other ways none of which would be you
exclusively reasoning backwards from your conclusion. You don't seem to want to
do that, and only want to talk about your solution not talk about the problem.

Fine. Moving on. I still think a dedicated CONFIG entry is a bad way to do the
silly thing. Specifying the silly thing on the kernel command line seems less bad.

>>As with the trivial patch to have init= launch PID 2, the cognitive 
>>load of
>>explaining to people WHY the config option exists and when somebody might have
>>wanted to use it in the kernel you're trying to forward port in a design you
>>inherited from somebody who isn't around anymore is itself a form of design
>>complexity. It's a special case _adding_ a design wart.
> 
> Is it possible that the reasoning of why this important would be much 
> more apparent to people in the container space?

Are you suggesting I don't understand because I'm not "one of us"?

Personally I think the problem is more likely that I _predate_ you, and had a
small hand in creating this entire area, and thus don't have the same hardwired
assumptions about this being the only possible way it could ever have been done.

In 2011 while working the OpenVZ booth at Scale along with Kir Kolyshkin (the
OpenVZ userspace maintainer, we were coworkers when I did a contract at
Parallels), I came up with the phrase "chroot on steroids" as part of my 30
second pitch explaining the conceptual difference between virtualization and
containerization to attendees who stopped at the booth to ask what we offered.
(I wrote down "chroot on steroids" back in
https://landley.net/notes-2011.html#19-04-2011 and got con crud at scale in
https://landley.livejournal.com/53863.html . Yeah, sometimes I do marketing on
the side. Startups need everybody to do everything. Containers were just SO COOL
and nobody KNEW about them back then.) I also wrote various documentation like
https://landley.net/lxc/ while adding adding container support to things like
CIFS in commit f1d0c998653f.

The team I worked with at at Parallels was porting container technology from
OpenVZ into Linux, which is how vanilla Linux got containers. (The line of
development dated back to a Russian bank moving from mainframes to linux in 1999
and writing in-house mainframe-like extensions to Linux. I asked Kir, who had
worked for said bank before the tech was spun out. Don't ask me the details of
the 12 year old conversation, but he's still around if you want to ask him. He
works at Red Hat these days.)

Later I attended the https://github.com/Fewbytes/rubber-docker talk live at
linuxconf.au in 2017 and have collected links like
https://blog.lizzie.io/linux-containers-in-500-loc.html ever since. I've meant
to add basic container support to toybox but it's been fairly far down on my
todo list, partly because I talked the android developers' ears off about
containers back when they merged toybox in 2015 (ala
http://lists.landley.net/pipermail/toybox-landley.net/2015-February/015135.html)
and a year later they wrote minijail (ala https://lwn.net/Articles/700557/) so
they've got their own plumbing now that I'd have to be compatible with. And once
I implemented unshare+nsenter in toybox and I've mostly just done stuff like
"sudo env -i USER=root TERM=linux SHELL=/bin/bash LANG=$LANG
PATH=/bin:/sbin:/usr/bin:/usr/sbin unshare -Cimnpuf chroot debootstrap" which is
usually good enough for my personal quick and dirty use cases.

I watched the rise of docker, was in the audience at ELC when the systemd guys
announced rocket, still think the initial cgroup filesystem had a better design
than cgroup2 (it could NEST, and why they don't properly instance devtmpfs in
containers I still don't understand). I vaguely followed the multiple variants
of flatpak that emerged because Ulrich Drepper hated static linking and too many
people swallowed that line of nonsense. I remember when /proc/self/exe being
inherited from the host became an exploit vector (an area I had previous
interest in for different reasons ala https://lkml.org/lkml/2017/9/12/175)...

But mostly what I was paying attention to was the checkpoint/restore stuff in
case that was reasonable to implement in toybox, largely because of prior
interest: back in 2002
https://lkml.iu.edu/hypermail/linux/kernel/0206.2/0610.html and
https://lkml.iu.edu/hypermail/linux/kernel/0206.2/0835.html got reblogged a lot
by various lwn.net competitors, so people would ask _me_ about it and it was so
nice when we finally got plumbing that let people _implement_ it. I mean OpenVZ
already had live migration working great at the 2011 SCALE demo, that's what Kir
was showing people at the other end of the table (and what I handed to them to
when I got them spun up on the basic "containers are cool and it's not the same
as VMs, all this 'cloud' stuff they're building from beowulf should pivot from
VM to container ASAP", but it took a LOT of redesign to chip off pieces and get
them into vanilla. (For one thing OpenVZ had added a bunch of new syscalls and
Linus wanted to use synthetic filesystems instead.)

You can argue that I'm _out_of_date_ if you like. (Probably true, on most
things. Jack of all trades, master of none. Usually I know who to ask.) But I
have some familiarity with, and reason to care about, both container
infrastructure and Linux early boot.

> I disagree that this introduces a design wart. On the contrary, I 
> believe it adds the option to make initramfs more consistent with the 
> other root setup methods:

A think it's silly, and think having a dedicated build-time CONFIG option
dedicated to doing something silly is not ideal.

Checking for "root=tmpfs" to trigger the silly thing seems less bad to me,
although I note that init/do_mounts.c function init_rootfs() already _is_
checking for that (and there's a pending patch to tweak it), so... be aware.

> 1. kernel mounted block device via root= results in a nominally empty 
> rootfs and a block device on top with the root file system in it. 
> pivot_root can be used.
> 2. initramfs which performs some init, mounts a block device, then 
> switches root to it. This results in a nominally empty rootfs and a 
> block device on top with the root file system in it. pivot_root can be 
> used.
> 3. initramfs which contains an embedded root filesystem to be used 
> directly. Results in a rootfs with the root file system in it with 
> nothing on top. pivot_root cannot be used.
> 
> This patch simply changes point 3, to be more in line with the others:

I believe I have basic context for Linux early boot.

>>You're asking the kernel to create a second empty ramfs or tmpfs 
>>instance, and
>>instead of checking an existing argument like "root=tmpfs" you're changing the
>>kernel's behavior with a dedicated config option that does a specific thing.
> 
> If we want to set this behaviour via a kernel parameter, we can do that 
> :)

As a convenience feature, a kernel parameter makes more sense to me. I still
think it's a silly thing to want to do, but it means I don't have to teach
people to fish it out of analogous defconfigs when they're learning to do board
bringup. (The hardware vendor usually has a Linux BSP on some variant of a demo
board, otherwise the people speccing the product wouldn't have selected that
chipset for a Linux project. There are exceptions, but sane management doesn't
throw newbies at them.)

>>Whatever your container stuff is
> 
> Love it or hate it, lots of stuff runs on containers now. The kernel has 
> made plenty of changes to better facilitate containers.

Yes. I was there. Helping make that happen was, briefly, my day job.

>>it won't be
>>able to run on any of those existing systems that keeps initramfs populated with
>>files. So again why have it be a config option: if you're going to change the
>>behavior, change it for EVERYBODY or your stuff will need a special kernel
>>configuration in order to run.
> 
> Sure, if we think its more appropriate to just do this always (not via a 
> build option) or gated behind a kernel parameter, we can do that.

I think doing it unconditionally will break existing users. And be unnecessary
for 95% of the existing users of initramfs.

Heck, I didn't expect the CONFIG_DEVTMPFS_MOUNT patch above would break debian's
init ala https://lkml.iu.edu/hypermail/linux/kernel/1705.2/05813.html because
they had a broken error handling path in their init script that had never
triggered before, and when it did trigger it did something stupid and crashed
the system. And yet that blocked the patch, and then adding a workaround for
debian hit
https://lore.kernel.org/linux-input/d6a5ba05-5de2-24e0-49ae-437058001b37@landley.net/
and even though
https://lkml.iu.edu/hypermail/linux/kernel/1709.2/02400.html has almost
certainly happened by now the patch is still maintained out of tree...

Also, my inittmpfs patches in 2013 only used tmpfs instead of ramfs under
specific circumstances, and left it as ramfs in others (mostly determined by the
root= and rootfstype= arguments). Despite that, I got email from somebody who
switched their system to tmpfs and had it break because the cpio.gz they were
extracting ate about 60% of the kernel's memory (which worked fine in their use
case) and the tmpfs mounts default to size=50%, so it worked for ramfs but not
tmpfs. And since ramfs takes no arguments rootflags= was never wired up to be
passed through there to override the size=, and I _still_ haven't bothered to do
it (the bug reporter went back to ramfs, and it's a static variable in
init/do_mounts.c and exporting it over through rootfs_init_fs_context() requires
touching header files so wasn't a 5 minute job... If somebody else wants to,
feel free.)

>>Heck, Debian populates initramfs with a cpio.gz file as part of its normal boot
>>process:
>>
>>$ zcat /boot/initrd.img-4.19.0-22-amd64  | toybox file -
>>-: ASCII cpio archive (SVR4 with no CRC)
>>
>>Has done for over a decade. You're saying debian can clean up but your stuff
>>can't be expected to.
> 
> No, that is not what I'm saying.

That's the part I don't understand. It _seems_ like what you were saying. Not
"this hasn't been working fine for everyone else for the past 15 years already",
but "I think it should have been designed a different way 20 years ago, and
would like to change it to match my opinion".

You're not unlocking a new capability you can't do without this patch. You just
think it should always have worked differently than it does.

I've submitted a few convenience patches myself over the years. Commit
595a22acee26 eventually made it in, and I've maintained
https://lkml.iu.edu/hypermail/linux/kernel/2302.2/05597.html out of tree since
https://lkml.iu.edu/hypermail/linux/kernel/1606.2/05686.html . I am not
conceptually opposed to convenience patches. (Nor am I the final decision maker
here, by the way...)

I'm just not seeing how the old way is _hard_ when the tool for it is in
util-linux (as I said, I may be biased), and I don't think this addresses the
underlying issue of the same rootfs being globally visible in all containers
when the same init task isn't (and is similarly "kernel panics if this exits"
important).

>>If you want a NULLFS, that is a design change. Maybe ask for the design 
>>change
>>so THAT can be discussed. Your config option seems like a partial fix at best,
>>and the kernel has enough abandoned partial fixes needing legacy support.
> 
> We already have what you call a nullfs. It's defined in 
> init/noinitramfs.c and usr/default_cpio_list, and its what you get if 
> you call switch_root within the initramfs.

I mean a filesystem type that maintains no state and _cannot_ be written to,
which your patch doesn't get because the rootfs that's there _can_ still be
written to if you try.

Hiding stuff in undermounts is classic 1970's student shenanigans, at best
you're making it less obvious. The ramfs instance that's always mounted and
never written to is still mapped into every container namespace, and the fact it
_can_ be written to is non-obvious.

Note: that's basically what Linux had before initramfs was invented. The root=
mount was mandatory and there was nothing under it. There _being_ a rootfs
instead was a design decision made 20 years ago by other people, which you seem
to be trying to revert.

> In most runtime situations, rootfs _is_ what you'd call a nullfs.

Where "most" apparently does not include the category of "routers", which are
one of the most numerous types of Linux system in the world. (According to
https://www.bitdefender.com/blog/hotforsecurity/current-routers-use-eol-linux-kernel-chock-full-vulnerabilities/
91% of the routers they tested ran linux, just the residential router market was
$11 billion in 2023, which assuming an average sale price of $200 is 50 million
units. The PC market shipped 68 million units but most of those run windows or
macos.)

LOTS of embedded people have used the existing initramfs, and it's accumulated a
BUNCH of weirdness over the years. Did you know you can concatenate multiple
cpio.gz files and the kernel loader will accept them as one big archive? Except
gnu cpio adds runs of NUL bytes to the end, which broke the parser at one point,
and then the android guys used a tool that reproduced the gnu behavior, and then
I got added to the bug report...

http://lists.landley.net/pipermail/toybox-landley.net/2021-April/028464.html

Every one of those archives was extracted into the initramfs we have now.

There have also been multiple threads about adding xattr support to cpio and the
initramfs extractor (without which selinux bringup is WAY more awkward, and yes
I get cc'd on them ala
https://lkml.iu.edu/hypermail/linux/kernel/1905.2/06559.html), which so far keep
petering out without resolution...

You are not the first person to use this plumbing. "Everybody _really_ wants
what I think it should always have been like, but nobody's mentioned it in the
past 20 years" is a strange position to take. Earlier you said "the fact that
the desirable path is" as a universal statement rather than a personal opinion.
Desirable to who? Judged as "fact" by who?

> So 
> yes, sure: I want a nullfs when my root filesystem lives inside the 
> initramfs too.

You didn't understand what I meant by nullfs, I tried to clarify above.

> Like I'd get if I'm mounting with root= and like I'd get 
> if initramfs calls switch_root.

I.E. like you can already get in multiple ways from userspace without this patch.

A special root=tmpfs or similar workaround to change the behavior is small and
ignoreable enough that I personally wouldn't object to it, if it didn't break
anything else. I still don't think it's the right approach, but you do you.

(For one thing, I can just NOT document "root=tmpfs" and it's invisible, and
doesn't cause a problem. Where CONFIG_THINGY is a thing people see in menuconfig
and I have to explain why they DON'T need it. In a previous life I was (again
briefly) linux-kernel documentation maintainer, and still produce a lot of it in
other contexts. My "oh goddess, not another variant to explain during early
boot" reaction may be unique, I dunno, but... sigh. It is not entirely without
cost.)

Rob
