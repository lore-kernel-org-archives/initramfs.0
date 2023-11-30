Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redcoat-dev.20230601.gappssmtp.com header.i=@redcoat-dev.20230601.gappssmtp.com header.b="uwpCyGp6"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3911B3
	for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 19:31:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b30308c67so3775865e9.0
        for <initramfs@vger.kernel.org>; Wed, 29 Nov 2023 19:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redcoat-dev.20230601.gappssmtp.com; s=20230601; t=1701315101; x=1701919901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIN8iA6iBqyuGM6E5QDFbM+HzGRmBvz35Suk2LdeXbI=;
        b=uwpCyGp6M8PLHnIi4lLbTyYu+s90TTykAAia6LYE+vHi2ESIsAl2JOlMX5oQizGs8M
         gF6NK6bWEsspChCxxxWpET1LceeHpMVk8AGOuscl3KG7pIYjU4y8tN6eYRfeGJWjZO1D
         DnvccQffTb8U5UODgfdfWjdVZAI1O43viEKf6u0eAxMfLyUWKWMQfVYNQIjGK7RfynrH
         +IWbVM3BwkQYH/JzquvCqloT9fXZAk8teGzu29eoqOSFTJtPNyEKe20/sJ90jn3EJmsH
         m0S2t6hlAeFmHfPomRedl1wheAR04hzaoij1IBx6Vdin8bv4HRAYzCHvbGjZgMCCwz4t
         5S5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701315101; x=1701919901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIN8iA6iBqyuGM6E5QDFbM+HzGRmBvz35Suk2LdeXbI=;
        b=B3toHN1BzYKwxDYQdTVUHP4TYUH/f54UBqQHorE75DLz0zPZtbvaKhQqs/MBn4wT4G
         hNf/jnb7gVP/Fj1jguaKJVvOOEw3H72qpbYcBd2XEjCBhzGBX5EN9R/ip9gkzPD5N9wQ
         QpllCDj6ECrTRxsvexHj1qAmxWOmbuT5/63mdO2aw5jXxWiQPbEYKm6PtG/N3l477Wyg
         iQ42c/ymKCLuj3j2XIRl9th9yWJ6iQuS6Ta2Nolwc0w1rtFe0fJfD2VquNXNVXhiOpTb
         DB60j6+YG7DGIA9EGAVX7OM/eGoskSh06+G/oTE/koaHBo+Klq7/CPgsp/BpVotZmzfW
         bqOw==
X-Gm-Message-State: AOJu0YxC7ORHT8ekDye+3r9vNZus4tt4iUe7dqN132vHEWTtNuq2T5iP
	lSdp72wI9nDSk2jCLf5Sb0Iu9g==
X-Google-Smtp-Source: AGHT+IGrygtMR/F/gp95k9bZ4UBPLKWUW7VTjTmwVBv1+yNE3vFByXQPVoduryQ2hBYQrwga/eqElA==
X-Received: by 2002:a05:600c:1f91:b0:40b:578d:2496 with SMTP id je17-20020a05600c1f9100b0040b578d2496mr551602wmb.27.1701315100474;
        Wed, 29 Nov 2023 19:31:40 -0800 (PST)
Received: from test ([2a00:23c7:1fab:4e01:4915:193d:c8fb:a42c])
        by smtp.gmail.com with ESMTPSA id m40-20020a05600c3b2800b004042dbb8925sm4085275wms.38.2023.11.29.19.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 19:31:39 -0800 (PST)
Date: Thu, 30 Nov 2023 03:31:38 +0000
From: Emily Shepherd <emily@redcoat.dev>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, initramfs@vger.kernel.org, 
	Thomas =?utf-8?Q?Str=C3=B6mberg?= <t+github@chainguard.dev>, Anders =?utf-8?Q?Bj=C3=B6rklund?= <anders.f.bjorklund@gmail.com>, 
	Giuseppe Scrivano <giuseppe@scrivano.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] initramfs: Support unpacking directly to tmpfs
Message-ID: <37yuynohcuve46jhgzbz24ip6yb2lqvwcn6gpxwxpw6msgtk4b@7dgqfkdtjngb>
References: <pkyfrfofquliqqxpylzzn5kdnfk4tewo6gx25d5m6pm2femvin@dkxlxm6leegu>
 <fc35ab36-c722-1102-36c5-6a2c015b2620@landley.net>
 <rxh6knvencwjajhgvdgzmrkwmyxwotu3itqyreun3h2pmaujhr@snhuqoq44kkf>
 <cec90924-e7ec-377c-fb02-e0f25ab9db73@landley.net>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cec90924-e7ec-377c-fb02-e0f25ab9db73@landley.net>

On Wed, Nov 29, 2023 at 02:53:49PM -0600, Rob Landley wrote:
>I'm assuming you can do process-local unmounts to prune what you'd be
>overmounting? (switch_root didn't _have_ to delete the old initramfs contents,
>it did it to free space. Containers similarly would remove privileges as part of
>their setup, and that includes mounts the new context shouldn't have.)

I think we are talking at cross purposes here, let's get back on track: 
The aim is to do a pivot_root within a container's mount namespace. In 
order to do this, we need at least two layers of "root" in the host 
mount namespaces. If there is just one (ie rootfs), we can't pivot_root, 
because rootfs cannot be removed.

Yes, you can switch_root or chroot or do any number of things, but that 
is not relevant. That is not the way container runtimes tend to work. 
The desirable outcome is pivot_root.

>From reading the link's summary, it seems like "unmount the old 
>inherited /proc
>and /sys before you "mount --move newfs /" seems like it would have been a fix?

It was the patch that was made in the container runtimes at the time, 
yes. This does not change the fact that the _desirable_ path is 
pivot_root.

>Lazy unmount it (which never affects a process's open files, including 
>the "/"
>and "." symlinks in each process), then mount --move so the visibility hides it,
>then teach the kernel that "overmounted" lets lazy unmounts go. (Which it
>_might_ already do if the reference count falls to 0 because of "." and "/"
>leaving, although you'd have to make sure no other open file descriptors
>referenced it in your current namespace from /dev entries and just plain
>inherited filehandles...)
>
>But it seems doable?

You can unmount child mounts, sure, but if your root is rootfs, you 
can't unmount it. The aim of this change is to make unmounting the host 
root more convenient, by ensuring there is a blank rootfs below it.

>Lemme guess, the child does something like:
>
>for (i = 0; i<32767; i++) close(i);
>mkdir("sub/blah")
>mount("sub", "sub", "tmpfs");
>chdir("sub");
>umount(".", MNT_DETACH);
>chroot("blah");
>chdir("../../../..");
>chroot(".")
>readdir();

I have told you already that the chroot, chdir .. trick does not work 
within containers. This code snippet has nothing to do with this patch 
or this discussion at all.

>
>> This would not occur with pivot_root.
>
>It would not occur if the filesystem had been removed from the current mount
>namespace by other means, either. (Or if the kernel got the test right, which
>you're saying it does now.)

You can't remove it if it's rootfs. If your host's root is rootfs, as it 
would be if you run directly from initramfs, you can't unmount it.

>Back when I was trying to get /dev/console to work properly with 
>init=/bin/sh I
>didn't ask for a kconfig option to make the initial task be PID 2 with PID 1
>(and its magic signal-blocking properties and inability to call reboot() and
>session ID 0 and orphaned zombies reparented to it so on) being a second idle
>task. I figured out how to make my userspace do the right thing.
>
>This really seems like an "init starts as PID 2" solution, which is a weird
>thing to have a dedicated build-time kernel config option for.

I am afraid I do not understand this point at all. This change is not 
requesting anything like this.

>You want to use rootfs but not use rootfs. It's very zen.

No, I want an initramfs, I just don't want it on rootfs. If I mount a 
block device as root, that wouldn't be rootfs either.

>If you'd like to go "I want to have the kernel automatically mount a 
>freshly
>formatted ext4 filesystem and then have the kernel extract the cpio archive into
>that instead, because it's more convenient for me to have the kernel do this for
>me than doing it in userspace"...

Not what this patch is suggesting.

The kernel already supports mounting a block device, in lieu of a 
userspace init doing it, via the root= parameter. Are you suggesting its 
support of that is inappropriate?

>If you fix the mount --move issues you could bind mount your current 
>directory,
>cd $PWD, and then --move mount it to /
>
>I think you're addressing the wrong issue.

No, I'm fixing the fact that container runtimes want to pivot_root, and 
can't when running directly from initramfs, as this extracts to rootfs.

>As with the trivial patch to have init= launch PID 2, the cognitive 
>load of
>explaining to people WHY the config option exists and when somebody might have
>wanted to use it in the kernel you're trying to forward port in a design you
>inherited from somebody who isn't around anymore is itself a form of design
>complexity. It's a special case _adding_ a design wart.

Is it possible that the reasoning of why this important would be much 
more apparent to people in the container space?

I disagree that this introduces a design wart. On the contrary, I 
believe it adds the option to make initramfs more consistent with the 
other root setup methods:

1. kernel mounted block device via root= results in a nominally empty 
rootfs and a block device on top with the root file system in it. 
pivot_root can be used.
2. initramfs which performs some init, mounts a block device, then 
switches root to it. This results in a nominally empty rootfs and a 
block device on top with the root file system in it. pivot_root can be 
used.
3. initramfs which contains an embedded root filesystem to be used 
directly. Results in a rootfs with the root file system in it with 
nothing on top. pivot_root cannot be used.

This patch simply changes point 3, to be more in line with the others:

3. initramfs which contains an embedded root filesystem to be used 
directly. Would result in a nominally empty rootfs with tmpfs on top 
with the root filesystem in it. pivot_root can be used.

>You're asking the kernel to create a second empty ramfs or tmpfs 
>instance, and
>instead of checking an existing argument like "root=tmpfs" you're changing the
>kernel's behavior with a dedicated config option that does a specific thing.

If we want to set this behaviour via a kernel parameter, we can do that 
:)

>What happens if somebody sets that config option and then goes 
>root=/dev/sda2
>
>In theory making the rootfs directory neither readable nor executable to the PID
>you've mapped root to in the container is anther approach.

Incorrect, please reread the patch.

>Your "one and only time" is an awful lot of embedded systems. It's a 
>common use
>case. The point of having initramfs be tmpfs is you can _persist_ in using it as
>your root filesystem without an errant log file filling up memory and hanging
>the system (a problem with ramfs).

We are not in disagreement on this point. In fact the irony is that we 
are actually in strong agreement here. Leaving the root in the initramfs 
_is_ a useful and commonly used flow - this change simply means to make 
that flow more compatible with container runtimes.

>Whatever your container stuff is

Love it or hate it, lots of stuff runs on containers now. The kernel has 
made plenty of changes to better facilitate containers.

>it won't be
>able to run on any of those existing systems that keeps initramfs populated with
>files. So again why have it be a config option: if you're going to change the
>behavior, change it for EVERYBODY or your stuff will need a special kernel
>configuration in order to run.

Sure, if we think its more appropriate to just do this always (not via a 
build option) or gated behind a kernel parameter, we can do that.

>
>Heck, Debian populates initramfs with a cpio.gz file as part of its normal boot
>process:
>
>$ zcat /boot/initrd.img-4.19.0-22-amd64  | toybox file -
>-: ASCII cpio archive (SVR4 with no CRC)
>
>Has done for over a decade. You're saying debian can clean up but your stuff
>can't be expected to.

No, that is not what I'm saying.

>If you want a NULLFS, that is a design change. Maybe ask for the design 
>change
>so THAT can be discussed. Your config option seems like a partial fix at best,
>and the kernel has enough abandoned partial fixes needing legacy support.

We already have what you call a nullfs. It's defined in 
init/noinitramfs.c and usr/default_cpio_list, and its what you get if 
you call switch_root within the initramfs.

In most runtime situations, rootfs _is_ what you'd call a nullfs. So 
yes, sure: I want a nullfs when my root filesystem lives inside the 
initramfs too. Like I'd get if I'm mounting with root= and like I'd get 
if initramfs calls switch_root.

-- 
Emily Shepherd

Red Coat Development Limited
