Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5BF10E
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 07:26:30 -0800 (PST)
Received: from [141.14.17.248] (handsomejack.molgen.mpg.de [141.14.17.248])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F0EF961E5FE09;
	Tue, 12 Dec 2023 16:26:04 +0100 (CET)
Message-ID: <ab8cbdf1-d724-43b2-b101-c4a8ff8f2f8f@molgen.mpg.de>
Date: Tue, 12 Dec 2023 16:26:01 +0100
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel+systemd-devel@molgen.mpg.de>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Luca Boccassi <bluca@debian.org>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>,
 initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org,
 Eric Curtin <ecurtin@redhat.com>, Yariv Rachmani <yrachman@redhat.com>,
 Lennart Poettering <mzerqung@0pointer.de>,
 Douglas Landgraf <dlandgra@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <ZXc4t8ayumo-dhul@itl-email>
 <CAMw=ZnQafP4n8SjdJa7tYFwHMEu21Pqiz-3VamZj0-10ykTF5g@mail.gmail.com>
 <ZXd0bNQRgJO-Wgeb@itl-email>
 <CAMw=ZnT20EB3Cn=6PHsZJUJku=b5As+OBBFXgU+ZK2Tsy7o8Qg@mail.gmail.com>
 <ZXd9EVT494r0tuC_@itl-email>
 <CAMw=ZnTTaMK1S6HCm3FL8YkgbYFuvZNQmbPjSC=kfc98=j7MJw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMw=ZnTTaMK1S6HCm3FL8YkgbYFuvZNQmbPjSC=kfc98=j7MJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[Sorry for the spam to the people in Cc. Now the real address.]

Dear Luca,


Am 11.12.23 um 22:45 schrieb Luca Boccassi:
> On Mon, 11 Dec 2023 at 21:20, Demi Marie Obenour wrote:
>>
>> On Mon, Dec 11, 2023 at 08:58:58PM +0000, Luca Boccassi wrote:
>>> On Mon, 11 Dec 2023 at 20:43, Demi Marie Obenour wrote:

>>>> On Mon, Dec 11, 2023 at 08:15:27PM +0000, Luca Boccassi wrote:
>>>>> On Mon, 11 Dec 2023 at 17:30, Demi Marie Obenour

>>>>>> On Mon, Dec 11, 2023 at 10:57:58AM +0100, Lennart Poettering wrote:
>>>>>>> On Fr, 08.12.23 17:59, Eric Curtin (ecurtin@redhat.com) wrote:

[…]

>>>>> And for ancient, legacy platforms that do not support modern APIs, the
>>>>> old ways will still be there, and can be used. Nobody is going to take
>>>>> away grub and dracut from the internet, if you got some special corner
>>>>> case where you want to use it it will still be there, but the fact
>>>>> that such corner cases exist cannot stop the rest of the ecosystem
>>>>> that is targeted to modern hardware from evolving into something
>>>>> better, more maintainable and more straightforward.
>>>>
>>>> The problem is not that UEFI is not usable in automotive systems.  The
>>>> problem is that U-Boot (or any other UEFI implementation) is an extra
>>>> stage in the boot process, slows things down, and has more attack
>>>> surface.
>>>
>>> Whatever firmware you use will have an attack surface, the interface
>>> it provides - whether legacy bios or uefi-based - is irrelevant for
>>> that. Skipping or reimplementing all the verity, tpm, etc logic also
>>> increases the attack surface, as does adding initrd-only code that is
>>> never tested and exercised outside of that limited context. If you are
>>> running with legacy bios on ancient hardware you also will likely lack
>>> tpm, secure boot, and so on, so it's all moot, any security argument
>>> goes out of the window. If anybody cares about platform security, then
>>> a tpm-capable and secureboot-capable firmware with a modern, usable
>>> interface like uefi, running the same code in initrd and full system,
>>> using dm-verity everywhere, is pretty much the best one can do.
>>
>> Neither Chrome OS devices nor Macs with Apple silicon use UEFI, and both
>> have better platform security than any UEFI-based device on the market I
>> am aware of.
> 
> We are talking about Linux distributions here. If one wants to use
> proprietary systems, sure, there are better things out there, but
> that's off topic.

In what way is ChromeOS more proprietary than the other GNU/Linux 
distributions, that allow to install the Chrome browser?


Kind regards,

Paul
