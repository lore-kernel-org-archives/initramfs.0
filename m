From: Kay Sievers <kay@vrfy.org>
Subject: Re: [PATCH 0/2] (dracut) hwdb needed in early boot
	for some keyboards
Date: Tue, 12 Nov 2013 11:28:47 +0100
Message-ID: <CAPXgP13EujKcEgsc_1N-_VbsYOdOw2jLZHHaxiRWQv1tL1ECcA@mail.gmail.com>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vrfy.org; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=V/L5x3AyLBDfqXZ5Ux4wdAY8eXMoszDV6LArPMUXvXA=;
	b=ZaFi0hf6WQbmOw3ZQe63EjlqUSe1htxo3LZsfmJk40aMYMHEXU8i1Mg9IvFy+MYTnd
	8VirCA3dXLTBZy0D18qDV5hOk/ui+BRtcDo+w/Vv1vmZkc/LKFNQOQ2qRrE3al8pHf+F
	eA5AtBUaM8MjNLam3QXNXPI2ih+hv/2ye96rI=
In-Reply-To: <1384249140-20683-1-git-send-email-colin@mageia.org>
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
To: Colin Guthrie <colin@mageia.org>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org

On Tue, Nov 12, 2013 at 10:38 AM, Colin Guthrie <colin@mageia.org> wrote:
> In this bug report https://bugs.mageia.org/show_bug.cgi?id=11645 a user is
> unable to enter their encrypted root password via a wireless keyboard
> connected with a Logitech, Inc. Unifying Receiver.

This sounds weird. Why exactly is this needed. The hwdb should be
non-essential information only, and not be needed for basic operations
or in the initrd.

If the basics of the keyboard aren't working properly, it might need a
kernel fix.

Kay
