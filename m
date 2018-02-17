From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v3 01/15] Documentation: add newcx initramfs format
 description
Date: Sat, 17 Feb 2018 11:32:51 -0600
Message-ID: <bbafa536-7732-8b89-47ba-5cd31e958ef1@landley.net>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
 <1518813234-5874-2-git-send-email-takondra@cisco.com>
 <d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com>
 <72480de8-e6d6-5125-e647-08815eb9f6a7@landley.net>
 <alpine.LRH.2.00.1802161336350.22409@sjc-ads-6991.cisco.com>
 <A5A0727C-B932-49F6-A7D7-AA7CAECECF96@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d0ee9QzTlwFvXutFTFlRkfJA4T+LgNPaoqY8g03PyTw=;
        b=Msf+7QLQrFzxKeWZpAT2l8XyBUgCNl7ehPEGc96WaRTVisZvMShP/+qCk/V/8f2OF5
         u34O60I934ApYgH4iLVECpB6F/q1QQyS8SBbptQiCjja3zTuwRfJ2k5OoDQAGbOqKLVs
         xL7hEatfZ5BjnP59re8RmxGlmpRqAiVFfeFvQB5bN63rizjfWDPprZkA1h/yh17/TVmJ
         MQiJBCRUeoPKIFEApX74WADIbXWVdDi/+zzJXcVudoEGvteYf0YLU6YYWyLVk22jk0Ub
         UNJlUqBGu1X9+KsKjq7QOC58euz0w2CKWeR9VEz0uhKNFIREPGD9cADa6/ti5GeSqw9B
         huTA==
In-Reply-To: <A5A0727C-B932-49F6-A7D7-AA7CAECECF96@zytor.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: hpa@zytor.com, Victor Kamensky <kamensky@cisco.com>
Cc: Taras Kondratiuk <takondra@cisco.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

On 02/16/2018 06:00 PM, hpa@zytor.com wrote:
> Introducing new, incompatible data formats is an inherently *very*
> costly operation; unfortunately many engineers don't seem to have a good =
grip
> of just *how* expensive it is (see "silly embedded nonsense hacks", "too
> little, too soon".)

So your argument is we should use the _existing_ cpio format that supports =
xattrs?

You keep bringing up the embedded world as a thing you don't understand and=
 is
thus bad. I remember when you dismissed "I would like to constrain my
cross-compiling dependencies to a minimal set" as a... what did you call it=
, a
silly academic exercise? (Googles...)

https://lkml.org/lkml/2008/2/15/548

> Cpio itself is a great horror show of just how bad this gets:

That's not what you said last time?

http://lkml.iu.edu/hypermail/linux/kernel/0112.2/1540.html

> Introducing a new incompatible data format without strong justification

Here's you suggesting a new format when initramfs first went in, because you
disliked _both_ tar and cpio:

http://lkml.iu.edu/hypermail/linux/kernel/0112.2/1587.html

Seriously, there is a "why cpio rather than tar" section of
https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs=
.txt
with links to the messages. (www.uwsg became lkml in the links, I should su=
bmit
a patch fixing that, it redirected 6 months ago...)

We've _had_ this argument already. You are not bringing up _new_ arguments.

This patch set is because people want xattrs in initramfs. I still don't
personally understand why they want this, but they do. We need to still sup=
port
the existing file format for the forseeable future, and we might as well fix
y2038 while we're there (treating it as unsigned buys us a lot of decades, =
but
as long as we're bumping the version number anyway...).

Otherwise it tries to be the minimal set of changes to get us there. (My fi=
rst
stab at this was dealing with sparse files, but runs of zeroes gzip pretty =
well
and tmpfs could always make itself sparse after the fact...)

> Doing it under the non-justification of expedience ("oh, we can share mos=
t>
> of the code") is aggravated engineering malpractice.

Coming from the guy who added perl as a build dependency to every project he
maintained simultaneously (the linux kernel, your bootloader, klibc), that =
seems
a lot more like an opinion than an objective metric.

> It is entirely possible that the modern posix tar/pax format is too compl=
ex

In the link above you declared it too complex in 2001. Partly because the g=
nu
tar and pax formats aren't really the same format.

> to be practical in this case =E2=80=93 that would be justifying a new for=
mat.  But
> then you are taking the fundamental cost of breakage, and then the new fo=
rmat
> definitely should not be replicating known defects of another format and
> without at least some thought about how to avoid it in the future.

Didn't Linus flame more than one developer for ripping things out and repla=
cing
them with a new untested thing rather than leaving a trail of breadcrumbs f=
rom a
known working thing to another known working thing? Or has the right way to=
 do
it changed since the 2.5 development cycle?

Strangely the poor souls suffering under the burden of cpio to use initramfs
today haven't been screaming out their agony in a detectable way. (They're =
mad
the kernel doesn't give better feedback about why init failed to launch and=
 it
either paniced or fell through to the fallback ROOT=3D, my patch to make
devtmpfs_mount work for initramfs was trying to fix the "you pointed the ke=
rnel
at a root filesystem directory which it cpio'd up but there was /dev/consol=
e in
it so your init has no stdin/stdout/stderr and dies immediately because of =
it"
problem. And the recent thread about "please don't add a third knob to make
initramfs be tmpfs instead of ramfs" was another corner case of that). And I
have half an INITRAMFS_VERBOSE patch around here somewhere to printk() a lot
more status (and I need to update the initramfs documentation I wrote to he=
lp
people have an easier time using it...)

But that's not about archive format. That's kernel userspace bringup being
persnickety. The silent majority you speak for on this archive format issue=
 is
pretty darn silent.

Was this recorded as a problem for you before somebody suggested changing i=
t? I
tend to be public about https://twitter.com/landley/status/9646206480509829=
12
and collect links to other people's concerns when I notice...

Or is this just your opinion?

Rob
