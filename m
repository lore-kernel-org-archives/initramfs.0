Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5F1CF
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 03:58:26 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 7B460E80203;
	Mon, 11 Dec 2023 12:58:24 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 07C59160253; Mon, 11 Dec 2023 12:58:23 +0100 (CET)
Date: Mon, 11 Dec 2023 12:58:23 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Eric Curtin <ecurtin@redhat.com>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org,
	Yariv Rachmani <yrachman@redhat.com>,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXb5X3GMbVMUtGWU@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <CAOgh=Fxy8pKipkfKvk62_WfBVUrkM865a9TRLF=oHC2u_jjZKQ@mail.gmail.com>
 <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>
 <CAOgh=FwacNaw0MqAtK=wjRt5TyM369-4+22eNvowFR_yoet-Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=FwacNaw0MqAtK=wjRt5TyM369-4+22eNvowFR_yoet-Xw@mail.gmail.com>

On Mo, 11.12.23 11:42, Eric Curtin (ecurtin@redhat.com) wrote:

> I am also thinking, what is the difference between "make the
> bootloader load the erofs into contiguous memory" part and doing
> something like storage-init.

Well, from my PoV there's value in reducing the stages of the boot
process, and reducing the amount of storage stacks you need in the
mix. Hence, the boot loader can load stuff from disk into memory
anyway, it always has done that, typically the kernel and the
initrd. just swapping out the format of the initrd to get better
behaviour is relatively cheap there, means no additional storage
logic, no additional stage of the boot. You basically only have "boot
loader" (which loads kernel and initrd), and the "host os" (which runs
of the final rootfs).

Otoh if you let your storage-init load the initrd, then you basically
have a third step in the middle, which shares a lot of props with the
last step, but also is distinct. I mean, you probably would reinvent
your own udev and DM stack for that, to get verity in the mix (because
that depends on DM, and udev, to some degree)

In my ideal model, initrds are just part of the UKI btw, so they end
up being loaded together with the rest of the kernel, and need no
verity becaused signed along with the UKI itself.

Lennart

--
Lennart Poettering, Berlin
