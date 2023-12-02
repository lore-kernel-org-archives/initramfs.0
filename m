Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="Wgcf27Pe"
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7D7B3
	for <initramfs@vger.kernel.org>; Fri,  1 Dec 2023 21:35:13 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d858670630so873116a34.0
        for <initramfs@vger.kernel.org>; Fri, 01 Dec 2023 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1701495312; x=1702100112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8jQ3zYr7XhMoDQLsFN6rIM6AbIhqS7rHjcGyi/6ODE=;
        b=Wgcf27PevoA/8CpC+wAmGx1d0KUdyw2lo4+GlVIQ1bXJ+hkbZ07WpOIehZJ30BthLc
         IeTuWcdvu54Jgk2Sc6g512UcWALxYrsuMW8JLGqjQ42wKOqsqnX5Qwo6quBNABelyBqs
         JsYqw4Htg15OoTow0uHqB5sqxRR+optt5uG1eSvQzdHijjcTXRWsV/sf0wbDFP9u8XpJ
         sgPu7SFB/EqjEmn7bBeGxmxBiE9r+6kN+YkgfmLrD8L474x/oA30Gm9UWtyHxQjqMFrc
         NQS+PRW32aIMfQpg43KF6TB6rMLa2MD9pTzjQO8wpH9ILH2DkqnBbVBWN+yMFHjxG4QP
         ajpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701495312; x=1702100112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8jQ3zYr7XhMoDQLsFN6rIM6AbIhqS7rHjcGyi/6ODE=;
        b=K6FzmHudylM9yec+2q8e1fFdAfPeK3LoX25fZ5GHtXK/NIKUVSSBtFFA8+jcURJmQN
         NepU9XoYJd3heHSBtnQN25b/E66czyBAlwiV0qsiMv+9sHpJyqVCxkvaHKcsEDwQBr7+
         u0UGguDRKZ67DZI5ef6OnNpC+GdplDdPpnb0hfuk2+hLLh0p4ozfwrIdnyytn1kKkprK
         vr/l9qvIBJ+q3XajaJ8I7kYD0VvEA7NzPMI2J5SuJhPKjWL1yxk9sxoVHInGFRmEQcfB
         gn9mIWCPqIPUIYErd4zfnIHBRR6X4VuJhmWwnKyL8Ri7/ToP03W7QPWu8Fo9+dMCbVye
         iFbA==
X-Gm-Message-State: AOJu0YyIqHHzanohPPrBrcGYBebIj63aZsoZtnnSF2K/9O9ViZ8MYNPY
	IcUCdAG2Cou0bwBJua+Yk/CIIg==
X-Google-Smtp-Source: AGHT+IF1hYh8/kln3WanaoBfJOJ6Wn81J6lC1fB7Cu5FQ63b97Qspb7iY1e6GIvsmIjsLobPmi14bA==
X-Received: by 2002:a05:6830:439e:b0:6d6:4fed:a21a with SMTP id s30-20020a056830439e00b006d64feda21amr676964otv.6.1701495312260;
        Fri, 01 Dec 2023 21:35:12 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id a23-20020a9d6e97000000b006d857d923e7sm735468otr.9.2023.12.01.21.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 21:35:11 -0800 (PST)
Message-ID: <ec6d7c0f-8408-ba51-f2ed-2bd068a6f673@landley.net>
Date: Fri, 1 Dec 2023 23:40:37 -0600
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
 <dbeb7b4b-b5e6-15ba-7e74-f9ffdd07059b@landley.net>
 <l6s4ngxtj6v7n5z6npcj4gmvr6x6vrvldwsfmyufovrj6teu3r@vajcufu3lltc>
From: Rob Landley <rob@landley.net>
In-Reply-To: <l6s4ngxtj6v7n5z6npcj4gmvr6x6vrvldwsfmyufovrj6teu3r@vajcufu3lltc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/23 17:37, Emily Shepherd wrote:
> I have to say I struggle to understand where to go from here... as I 
> said above, I do like the CLONE_NEWROOTFS suggestion (and it was 
> actually something I was batting around for my own project) but that 
> feels that a _way more_ specialised feature.
> 
> And now you are saying that apparently we _shouldn't_ make a relatively 
> small change to initramfs because its worked fine for years, but we 
> should add a much larger patch to clone() which has also worked for many 
> years?

No, "the perfect is the enemy of the good" applies. Blocking a small fix to
force a large fix isn't always reasonable.

I just dislike adding special cases. Right now when you root=/dev/sda1 you
specify what to overmount on rootfs at runtime, so if you're going to overmount
something _else_ that seems the layer to do it at. A CONFIG_BLAH=y option to do
a similar thing (changing the semantics from a different area entirely) seems
painful, especially as a workaround for a self-inflicted issue in a userspace
package.

I would very much like the kernel to get _simpler_ over time. It isn't, and it
won't, and eventually we'll start over with
https://www.youtube.com/watch?v=Ce1pMlZO_mI or something. But I can at least try
to push back a bit to _slow_ the descent. (Unix lasted about 1 billion seconds,
which rolled over Saturday September 8, 2001. The second billion seconds of the
unix clock rolls over Tuesday, May 17 2033, which roughly coincides with Linus
hitting retirement age. Not a profound observation, just a frame of reference...)

Posix outlived Unix v7 and System V and so on because it defined an interface
that could have its implementation swapped out. Posix is a TERRIBLE standard
because if you implement a posix-only system it can't boot (no "init" command)
and can't access filesystems (no "mount" command), but it's the subset people
could agree upon. (Politics: they needed something with holes big enough to
drive OS/360 and Windows NT through or else the big boys couldn't get federal
procurement contracts while FIPS-151-2 was in force if they didn't nominally
comply. Even 1980's Apple came out with A/UX, no really:
https://www.youtube.com/watch?v=nwrTTXOg-KI )

A multiple-choice interface is harder to get test coverage on in a single
implementation, let alone an IETF-style bakeoff where
https://docs.freebsd.org/en/books/handbook/linuxemu/ and
https://learn.microsoft.com/en-us/windows/wsl/ and
https://9to5google.com/2021/02/12/google-fuchsia-os-android-linux-programs-starnix/
and so on all agree on a documented set of interfaces that can run the same
code. There may be some API pruning once everybody young enough to remember when
"the GPL" was a single thing (instead of Samba and Linux being unable to share
code even though they implement two ends of the same protocol and are both GPL)
has aged out of the productive flow, at which point you may not be able to _pay_
enough younguns to touch the modern equivalent of cobol...

(I say this as someone who has reimplemented a gnu-compatible sed implementation
TWICE, once in busybox, once in toybox. And lamented for a standard that
actually MEANS something both times. I have long threads with Bash maintainer
Chet Ramey about weird corner cases of Bash
(http://lists.landley.net/pipermail/toybox-landley.net/2023-June/029616.html)
because I'm implementing a bash compatible shell from scratch in toybox, and the
closest I have to a "standard" is the bash man page which does not always
document what bash actually _does_. (Alas, Chet keeps FIXING things I bring up,
which he considers progress and I consider making bash a moving target...)

Anyway, this sort of thing tends to be on my mind a lot. If you assume an
ABI/API is gonna get extracted from this with a new implementation stuck under
it someday (as has happened before), "which bits will definitely get pruned but
probably cause collateral damage" is a question that comes up. I expect "a
minimal host system capable of running containers" to be a fairly EARLY cloning
target...

> I shouldn't question how initramfs works because you were there 
> when it was written [1], but we should question all the devs who decided 
> on CLONE_NEWNS over CLONE_NEWROOTFS?

Oh no, please question it. Question everything.

And I only started paying attention to this one a little _after_ it was written.
Early adopter, not author. Reported various bugs, wrote the documentation I'd
wanted to read, genericized the userspace tooling a bit... But it was Al Viro's
baby.

Speaking of which, all the http://www.uwsg.iu.edu/ links in said docs still work
if you switch them to https://lkml.iu.edu/ and leave the rest under it. I should
push a patch, but the linux development community chased all the hobbyists who
used to fix that sort of thing away at least ten years ago, sometime before
https://lwn.net/Articles/563578/ so nothing that doesn't affect Red IBM Hat's
bottom line really gets addressed in vanilla these days. They just sort of
linger if it's not worth billable hours for a career engineer to do on the
clock, run through Jira, and check off on the spreadsheet in the standup. Those
links have been broken for YEARS. I fixed my local copy. People occasionally
email me and I tell them the update. But nobody's tried to push a patch through
the signed-off-by in triplicate with the 47 files in Documentation/process
including 873 lines of submitting-patches.rst and a 24 step submit-checklist.rst
which sort of assume you've read contribution-maturity-model.rst and "The
lifecycle of a patch" section out of 2.Process.rst and...

At least until the network admin running kernel.org gets his way and closes down
the open mailing list, replaced by one that only approved people are allowed to
join:

https://social.kernel.org/objects/9b3adb80-4198-4c86-abbd-aa3c58700975

And then they stop taking patches by email:

https://social.kernel.org/objects/fbda91b8-f865-4ee5-9a40-22a2c70479f4

*shrug* See above about me waiting to see what replaces all this when it rolls
to a stop...

> I'm not saying we shouldn't, but help me out here - how can I tell 
> what's "reasonable" to question and what isn't?

Everything is reasonable to question. Not always helpful, but reasonable.

> I merely meant that there 
> are a hell of a lot of different build options and systems within the 
> kernel, and it is perhaps not unreasonable to suggest that it is not a 
> requirement that everyone intimately understands all of them all of the 
> time.

I'm weird enough to still _try_. At least in the parts common to the systems I'm
building on a dozen different architectures. (_Everybody_ has to go through
early boot.)

I'm currently trying to get vanilla u-boot, linux, and devuan debootstrap to run
on the orange pi 3b because I don't trust anything that keeps its repo on
"huaweicloud" to _not_ have spyware in it because Xi Who Must Be Obeyed ordered
it so. The hardware was put together by some very nice engineers, who seem to
have pushed support upstream into the various vanilla projects, so I _should_ be
able to get all-vanilla to work on this. (Unlike raspberry pi which is still
binary blobs as far as the bootloader can see and a forked kernel.) But in order
to build a fully capable u-boot for this board I need an or1k cross-compiler
because the power controller needs firmware, which they provide the source code
to but somebody actually made an openrisc ASIC (really!) to control the power,
so you need to compile it with an or1k cross compiler to make the firmware to
load into it, and if u-boot doesn't initialize this hardware, the Linux kernel
it hands off to can't suspend or reboot the board from software:

  https://github.com/u-boot/u-boot/blob/master/board/sunxi/README.sunxi64#L64

The problem is, if I get distracted by that, and then go "hey, hexagon finally
has qemu-system emulation now" (ala
https://github.com/quic/toolchain_for_hexagon/commit/8a8923bd6c6a) and so on, if
I don't come back to other projects for a couple releases stuff's bit-rotted
behind my back and I have to bisect and reverse engineer it.

The change under discussion here is a case where explaining the design context
behind this distinction, let alone the decision to change it, is multiple
minutes for a domain expert to unpack the backstory for you, and hours if not
days to pick apart yourself. It changes what the design IS. I personally already
_know_ (some of?) the backstory, but I don't expect other people to, and really
don't look forward to having to document it.

>>You are not the first person to use this plumbing. "Everybody _really_ 
>>wants
>>what I think it should always have been like, but nobody's mentioned it in the
>>past 20 years" is a strange position to take. Earlier you said "the fact that
>>the desirable path is" as a universal statement rather than a personal opinion.
>>Desirable to who? Judged as "fact" by who?
> 
> I meant for container runtimes. Most are quite opinionated about not 
> doing mount --move . / && chroot(.), strictly preferring pivot_root 
> instead.

Indeed. They want to start with an empty mount tree, and they don't want to
umount all the stuff they inherited. It's an understandable desire, but
repurposing pivot_root for this was not exactly an elegant solution, as this
thread is just one aspect of.

People get so stuck defending a solution they forget what the problem was.

Rob
