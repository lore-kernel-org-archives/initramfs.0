From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH 0/2] (dracut) hwdb needed in early boot
 for some keyboards
Date: Wed, 13 Nov 2013 23:18:41 +0600
Message-ID: <CAN_LGv2H3pDZ+Sp6LpxkN+Ay_4LbZbR4Av1_j0B2WLO=TcxvAw@mail.gmail.com>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>
	<52830E31.30107@gmail.com>
	<CAN_LGv2h3jYopc4xBn+206MpdoeEzB6Hy3iBqPw4eqvcuOPQ-A@mail.gmail.com>
	<5283AEA4.9050209@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=Mj/JlewOfNAvlVLyIEgJ5LtYdUoBWrrWOR3NKW85PQ0=;
	b=GlfIOjnQTLxzu2xjVruJUUacCgCKm7UoCSMmhK+0IZqVRw7GJysNkdGucqrY8BMDlI
	+6VtfvWWxCTtB1D174+h72cB9OYm9YqksNjUlvZB3sKC1DUDupvzUei8xmI+9k1JqxuC
	Qgt1GXXCx8PUz+zl8nJ5pylGvNM/s7E1H3Ths8gium/j0idXVx7ssIBXBV35LD1lk5Ch
	QRPqTE8P0H/gKuzbr9weFxzvreKF8AKfKMtrP5R5Y+PFIBaQUxh3sOr3/3LOyRjXtIvx
	NEvrwBK76dz9W5pRVFgcgqc+77EmJG1iWrSGhjnKy/XNiw1NqbmVpJfqztRBbWPDTY3w
	CZzw==
In-Reply-To: <5283AEA4.9050209@colin.guthr.ie>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces@lists.freedesktop.org
Errors-To: systemd-devel-bounces@lists.freedesktop.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: initramfs@vger.kernel.org, systemd Mailing List <systemd-devel@lists.freedesktop.org>

2013/11/13 Colin Guthrie <gmane@colin.guthr.ie>:
> 'Twas brillig, and Alexander E. Patrakov at 13/11/13 16:49 did gyre and
> gimble:
>> 2013/11/13 Alexander E. Patrakov <patrakov@gmail.com>:
>>> Colin Guthrie wrote:
>>>>
>>>> Hi,
>>>>
>>>> In this bug report https://bugs.mageia.org/show_bug.cgi?id=11645 a user is
>>>> unable to enter their encrypted root password via a wireless keyboard
>>>> connected with a Logitech, Inc. Unifying Receiver.
>>>
>>>
>>> Just in case, I do have the same model of wireless keyboard and will
>>> validate the bug (for the LUKS-password case) later today on my laptop.
>>>
>>> The keyboard does work on my desktop, but there's no initramfs there.
>>
>> I hereby confirm that the wireless Logitech keyboard works for
>> entering the LUKS password on the laptop, if one does not create a
>> host-only initramfs. This is with dracut-031.
>
>
> thanks for that. If it's easy enough for you to test, does it also work
> with a host-only initrd?

It doesn't, because (at least whe creating the initramfs without the
USB keyboard connected) it does not include the usbhid module.

-- 
Alexander E. Patrakov
