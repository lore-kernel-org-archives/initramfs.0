X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 02:16:29 PST
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29C8B8
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 02:16:29 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 68F38E801F9;
	Mon, 11 Dec 2023 11:07:04 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id EA1ED160253; Mon, 11 Dec 2023 11:07:03 +0100 (CET)
Date: Mon, 11 Dec 2023 11:07:03 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Eric Curtin <ecurtin@redhat.com>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org,
	Yariv Rachmani <yrachman@redhat.com>,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXbfR6eyL3XXEACe@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXbdJp1Vz8M8c1MS@gardel-login>

On Mo, 11.12.23 10:57, Lennart Poettering (mzerqung@0pointer.de) wrote:

> Which leaves item 1, which is a bit harder to address. We have been
> discussing this off an on internally too. A generic solution to this
> is hard. My current thinking for this could be something like this,
> covering the UEFI world: support sticking a DDI for the main initrd in
> the ESP. The ESP is per definition unencrypted and unauthenticated,
> but otherwise relatively well defined, i.e. known to be vfat and
> discoverable via UUID on a GPT disk. So: build a minimal
> single-process initrd into the kernel (i.e. UKI) that has exactly the
> storage to find a DDI on the ESP, and set it up. i.e. vfat+erofs fs
> drivers, and dm-verity. Then have a PID 1 that does exactly enough to
> jump into the rootfs stored in the ESP. That latter then has proper
> file system drivers, storage drivers, crypto stack, and can unlock the
> real root. This would still be a pretty specific solution to one set
> of devices though, as it could not cover network boots (i.e. where
> there is just no ESP to boot from), but I think this could be kept
> relatively close, as the logic in that case could just fall back into
> loading the DDI that normally would still in the ESP fully into
> memory.

BTW, one thing I would like to emphasize though. i think this item is
really the last thing you should focus on. If your OS never
transitions out of the initrd, and gets its payload merged in via
DDIs, then the root fs should be reasonably small enough and "fully
used at boot" (i.e. every sector read anyway) that doing this extra
work of finding a split-out DDI on the ESP is entirely unnecessary and
just a waste of time (both of developer time and boot time).

Lennart

--
Lennart Poettering, Berlin
