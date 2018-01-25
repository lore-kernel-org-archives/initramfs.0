From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/15] Documentation: add newcx initramfs format description
Date: Thu, 25 Jan 2018 22:02:49 +0100
Message-ID: <CAK8P3a06d66eEwxGtezGhfqxYLg9hPiTm5aXRzC=rMwoWQ=dpA@mail.gmail.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
 <1516850875-25066-2-git-send-email-takondra@cisco.com> <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
 <151691200536.5378.11544479301138437367@takondra-t460s>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=os4qxIcSK2zNcdNjn5B57aPOkGxMko+lFdrFlTI55xo=;
        b=QKVbf742Imi2X9ZLrdG/eJp5Rvfw7JsSYyznU54JsRhrdm19XqOU5C54MxQ2Iyxdlw
         QXonFiiPeVqgfxBVx8OCR38RZf2rGo5XCXDByx+LMypBpNauEYaNQjzERg8pHqjziCXg
         WwPUhFezgSsfZdhdMzwjPr1qwJZTS0+L/U0drXtYO6W9MVc3sdks90TBx6oXcKGmnNP3
         IQdDlUidY7b4e4pG9s6rtYL+z1AnebZjqk33YPhzw60S/bPqgJYJwVQy91QxYFG2ajDq
         jUOinKRvbeAUQF4+bZTI0dABHPlc+II1SE7HPkaBYYv5rBnVUfKGYrS/t3cI+xHyUm3n
         z66w==
In-Reply-To: <151691200536.5378.11544479301138437367@takondra-t460s>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Taras Kondratiuk <takondra@cisco.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, xe-linux-external@cisco.com

On Thu, Jan 25, 2018 at 9:26 PM, Taras Kondratiuk <takondra@cisco.com> wrote:
> Quoting Arnd Bergmann (2018-01-25 01:29:12)
>> On Thu, Jan 25, 2018 at 4:27 AM, Taras Kondratiuk <takondra@cisco.com> wrote:
>
> We can match statx(2) by having 64 bits for seconds plus 32 bits for
> nanoseconds.

Ok.

> For initramfs nanoseconds field can be ignored during
> unpacking.

That sounds like a pointless microoptimization. Most likely we won't ever
need the nanoseconds in the initramfs, but it's trivial to just copy them
into the right field, and not adding that one source line would probably
involve adding a one-line source comment to explain the omission ;-)

      Arnd
