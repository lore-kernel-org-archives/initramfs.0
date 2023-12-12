Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853FB9
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 10:00:34 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 892D6E801F8;
	Tue, 12 Dec 2023 19:00:32 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 442AC16012B; Tue, 12 Dec 2023 19:00:32 +0100 (CET)
Date: Tue, 12 Dec 2023 19:00:32 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Eric Curtin <ecurtin@redhat.com>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>,
	Yariv Rachmani <yrachman@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>,
	Qubes OS Development Mailing List <qubes-devel@googlegroups.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXifwMan02j9M3n2@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <ZXc4t8ayumo-dhul@itl-email>
 <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=Fzd-BcBCKzL419iOxbE=+uZWp6oYSV8+VDJ9w8vWG_L-g@mail.gmail.com>

On Mo, 11.12.23 17:03, Eric Curtin (ecurtin@redhat.com) wrote:

> A generic approach is hard, I think it's worth discussing which type of boots
> you should actually care about milliseconds of performance for. It would be nice
> if we had an init system that contained the binary data to do the minimum for
> standard Fedora, Debian installs and everything else was an extension whether
> that's sysexts, dlopen, a new binary to execute etc.
>
> If the network is ingrained in your boot stack like this, I'm
> guessing you probably don't care about boot performance.

Uh, I am not sure that's really true. People boot up VMs on demand,
based on network traffic. They sure care about latency and boot
times. I mean people care about firecracker and these things precisely
because it brings the of off-to-IP to a minimum.

> Automotive has an expectation for really fast boots, like 2 seconds, in standard
> desktops installs there's some expectation as you interface directly
> with a human,
> but for other installs how much expectation is there?

AFAIR in particular in cars there's quite som functionality you
probaly want to move very early in boot. Which yells to me that you
want a service manager super early. Which again suggests to me that
the first initrd that runs should probably already cover that.

If I were you I'd probably focus on a design like this: ship a basic
systemd in an initrd. Complete enough to find the harddisk, and to run
the other services that are absolutely necessary this early. Then,
once you found the disk, look for sysext images on it, and apply them
all on top of the initrd's root fs you are already running with. Never
transition anywhere else.

The try to optimize the initrd a bit by making it an erofs/memmap
thing and so on. And make sure the initrd only contains stuff you
always need, so that reading it all into memory is necessary anyway,
and hence any approach that tries to run even the initrd off a disk
image won't be necessary becuase you need to read everything anyway.

Lennart

--
Lennart Poettering, Berlin
