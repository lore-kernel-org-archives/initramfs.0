Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redcoat-dev.20230601.gappssmtp.com header.i=@redcoat-dev.20230601.gappssmtp.com header.b="Qf1S6rFN"
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBBF1B3
	for <initramfs@vger.kernel.org>; Fri,  1 Dec 2023 15:37:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332f4ad27d4so1797329f8f.2
        for <initramfs@vger.kernel.org>; Fri, 01 Dec 2023 15:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redcoat-dev.20230601.gappssmtp.com; s=20230601; t=1701473865; x=1702078665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul3H2ilnHanteXiNcPoBdUJMk4CjPQyHnXwl528pyMU=;
        b=Qf1S6rFNhqEOkhs7+dou6YBMOU1T6iLGIb1BET2ksSx5BwOqR+sQU+3Luh/FlRtcQI
         dTgkwimjgDR2mX2xyDUT6pXMiHFYgj5ZZ013Slg7C6p1rqxdJ+KoKpLHsn/npaZDUvJI
         H6jNJtiKS7KAxKIB6aUbaB0PHMrLoOluPQ5JxWzCz5km5ajIKW+OWcMYxYNvM9k1qU8X
         eNWYIKPGmwUk23mSretHIkLqRDe4pZyZUpcj7SEYctcFvNzeIvk3v6oQGsya32QXLbm/
         vBjA9C24q9tZtQyXVjIiL+U60o2uGKSl6d9bw/4joEUlYsXIEencl14q2xqaDt0gP4tc
         lGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701473865; x=1702078665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul3H2ilnHanteXiNcPoBdUJMk4CjPQyHnXwl528pyMU=;
        b=dBaqTWE7mZYNOueygLDEWi82pdRsrSXr+7ngBCjt0sdzDVv9WSRUBCvXGl857d2yI/
         cnT5pqi2IOtnRc//Dc9I6X1zeBTo/FKi5DPAfyUmtqQ19ah4U+qzdsOSWcNtZqshTrqL
         ClY4Xhy0rReTfIJ8RgiAB9/vUKyrHdC67X+uOZXJljYC0uWhK29m15Zo4WfNlJSEHKXK
         JvpZA01a+D1AYDy8JX3TN1TqoXWOMk5UynRQ3YGGSSBT9kPK7172xLkaMRPf0catv0IC
         BrGr6FdNJTI7dJg/UVIwc7gcMp9wVg/38Wx6gpYsoAhYSOF7e7YNh45atEJ9ANd/2o2K
         6twA==
X-Gm-Message-State: AOJu0YykNddU5ExFPyAKuAE33sb6oPjrDP0UT5O2CM6Am5M5nwI0Etqd
	29XhyiS364n/on716EVzWAKCmg==
X-Google-Smtp-Source: AGHT+IF31J7AtVOZcjG36n0p6k6idBhVsZxlJERkQNSnSlV8krszTvZL1nl8KLpRcf2Z9k99sT7dGQ==
X-Received: by 2002:adf:a1c3:0:b0:333:2ad1:17eb with SMTP id v3-20020adfa1c3000000b003332ad117ebmr1300225wrv.69.1701473865102;
        Fri, 01 Dec 2023 15:37:45 -0800 (PST)
Received: from test ([2a00:23c7:1fab:4e01:4915:193d:c8fb:a42c])
        by smtp.gmail.com with ESMTPSA id e12-20020adfe38c000000b00332fd9b2b52sm5328385wrm.104.2023.12.01.15.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:37:44 -0800 (PST)
Date: Fri, 1 Dec 2023 23:37:43 +0000
From: Emily Shepherd <emily@redcoat.dev>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, initramfs@vger.kernel.org, 
	Thomas =?utf-8?Q?Str=C3=B6mberg?= <t+github@chainguard.dev>, Anders =?utf-8?Q?Bj=C3=B6rklund?= <anders.f.bjorklund@gmail.com>, 
	Giuseppe Scrivano <giuseppe@scrivano.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] initramfs: Support unpacking directly to tmpfs
Message-ID: <l6s4ngxtj6v7n5z6npcj4gmvr6x6vrvldwsfmyufovrj6teu3r@vajcufu3lltc>
References: <pkyfrfofquliqqxpylzzn5kdnfk4tewo6gx25d5m6pm2femvin@dkxlxm6leegu>
 <fc35ab36-c722-1102-36c5-6a2c015b2620@landley.net>
 <rxh6knvencwjajhgvdgzmrkwmyxwotu3itqyreun3h2pmaujhr@snhuqoq44kkf>
 <cec90924-e7ec-377c-fb02-e0f25ab9db73@landley.net>
 <37yuynohcuve46jhgzbz24ip6yb2lqvwcn6gpxwxpw6msgtk4b@7dgqfkdtjngb>
 <dbeb7b4b-b5e6-15ba-7e74-f9ffdd07059b@landley.net>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dbeb7b4b-b5e6-15ba-7e74-f9ffdd07059b@landley.net>

On Fri, Dec 01, 2023 at 04:02:50PM -0600, Rob Landley wrote:
>You are reasoning backwards from your solution and not thinking about 
>the
>design. I don't think you're addressing the real issue.
>
>Right now "separate" container namespaces all share a common rootfs instance.
>They do NOT share a common init task, even though before containers that was
>universal. You can have your own PID namespace, which starts _empty_.
>
>Your mount tree in a container does NOT start empty. From the clone(2) man page:
>
>  If  CLONE_NEWNS  is  set,  the  cloned child is started in a new
>  mount namespace, initialized with a copy of the namespace of the parent.
>
>Defaulting to having everything in it and removing what you don't want to keep
>is very different from what PID or UID namespaces do, and is causing you
>problems. Doing a chroot is basically an overmount, the other mount points are
>still there in your tree and accessable if you try hard enough, and rootfs is
>common to all containers. Mitigating this requires cleanup work that isn't
>always even possible to fully do (ala rootfs actually being used, which does
>happen a lot today and it's always accessible if a static process forking its
>own mount namespace does enough umounts, which can then act as a
>cifs/nfs/9p/rsync server out to the parent or some such).
>
>Logically, extending the kernel to have a CLONE_NEWROOTFS where it gets a _new_
>ramfs or tmpfs instance, unique to that namespace, at the root of a new empty
>mount tree, is the logical fix. There is then design work around "so what API do
>you use to populate it" which could range from "the first int below child_stack
>is the fd of a cpio.gz to extract into it and then it launches an /init out of
>there the way the host linux boots" through "the new child starts suspended ala
>vfork/ptrace and then the parent process initializes it and unblocks it" to "the
>init task is running the executable from the host context that called clone and
>has inherited the existing open filehandles from the host context, although
>despite the openat() family being in posix-2008 we sadly don't appear to have a
>mountat()...". I dunno. That's design work to properly fix the issue.
>
>You don't want to address the design problem, you want to add a special case
>workaround for your current issue. You see doing that as a "design fix". I do not.

I think this is a good point - I definitely agree that the weird 
hackiness that runtimes have to do to setup their mount namespaces 
properly is suboptimal.

The hypothetical CLONE_NEWROOTFS that you suggest is a superior 
suggestion - not least because it would better do what containers 
actually want, but it would also do it with less syscalls and flapping!

As an aside: I take your point RE rootfs being shared. The general 
concern is normally that information from the host might leak if 
containers can read the host root, so sharing an empty rootfs is less of 
a concern, but again the theoretical case of information sharing between 
containers by writing to the shared rootfs is an interesting one too.

>Fine. Moving on. I still think a dedicated CONFIG entry is a bad way to do the
>silly thing. Specifying the silly thing on the kernel command line seems less bad.
>
>Checking for "root=tmpfs" to trigger the silly thing seems less bad to 
>me,
>although I note that init/do_mounts.c function init_rootfs() already _is_
>checking for that (and there's a pending patch to tweak it), so... be aware.

My original reasoning for having it as a built option was that, in the 
case of running directly from initramfs, that's often something that's 
done if you're embedding the initfamfs to create a unified kernel. As a 
result, it is something that you'd only really care to turn on or off at 
build time.

Having said that, I have no strong opinion on that.

>That's the part I don't understand. It _seems_ like what you were 
>saying. Not
>"this hasn't been working fine for everyone else for the past 15 years already",
>but "I think it should have been designed a different way 20 years ago, and
>would like to change it to match my opinion".

I have to say I struggle to understand where to go from here... as I 
said above, I do like the CLONE_NEWROOTFS suggestion (and it was 
actually something I was batting around for my own project) but that 
feels that a _way more_ specialised feature.

And now you are saying that apparently we _shouldn't_ make a relatively 
small change to initramfs because its worked fine for years, but we 
should add a much larger patch to clone() which has also worked for many 
years? I shouldn't question how initramfs works because you were there 
when it was written [1], but we should question all the devs who decided 
on CLONE_NEWNS over CLONE_NEWROOTFS?

I'm not saying we shouldn't, but help me out here - how can I tell 
what's "reasonable" to question and what isn't?

[1]: https://media.tenor.com/lR9rjwXjL50AAAAC/deep-magic-lion.gif

>LOTS of embedded people have used the existing initramfs, and it's accumulated a
>BUNCH of weirdness over the years. Did you know you can concatenate multiple
>cpio.gz files and the kernel loader will accept them as one big 
>archive?

I did, yes.

>Are you suggesting I don't understand because I'm not "one of us"?

No, and I am sorry that I phrased that poorly. I merely meant that there 
are a hell of a lot of different build options and systems within the 
kernel, and it is perhaps not unreasonable to suggest that it is not a 
requirement that everyone intimately understands all of them all of the 
time.

>You are not the first person to use this plumbing. "Everybody _really_ 
>wants
>what I think it should always have been like, but nobody's mentioned it in the
>past 20 years" is a strange position to take. Earlier you said "the fact that
>the desirable path is" as a universal statement rather than a personal opinion.
>Desirable to who? Judged as "fact" by who?

I meant for container runtimes. Most are quite opinionated about not 
doing mount --move . / && chroot(.), strictly preferring pivot_root 
instead.

-- 
Emily Shepherd

Red Coat Development Limited
