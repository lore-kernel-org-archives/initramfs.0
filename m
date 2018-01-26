From: Victor Kamensky <kamensky@cisco.com>
Subject: Re: [PATCH v2 01/15] Documentation: add newcx initramfs format
 description
Date: Fri, 26 Jan 2018 07:51:21 -0800 (PST)
Message-ID: <alpine.LRH.2.00.1801260739120.8259@sjc-ads-6991.cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com> <1516850875-25066-2-git-send-email-takondra@cisco.com> <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com> <0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
 <20180126103132.7szs5lj5ppm7eyy6@khazad-dum.debian.net>
Mime-Version: 1.0
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1615; q=dns/txt; s=iport;
  t=1516982456; x=1518192056;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WH227MJVQx+LRvdD8fLUE7UCaSluNra5ymRI+8qbiK4=;
  b=DOcZAO2Q9K8axrU80xFP+7s54dQYgmnC3nW9FCdDuCYg1gV/Cg/4NmOx
   v8F4qvWOKpiMouiMy2UoUs1j/lxIcJqVdWvFTYE0EJ78M4eKhJjkvcWoA
   Z4DXlsBo6uFTdH/hxVaWwbJ2D0Jw2bQsBQUxSD5mBjI8IhtqteS4dXXyc
   A=;
In-Reply-To: <20180126103132.7szs5lj5ppm7eyy6@khazad-dum.debian.net>
Sender: linux-doc-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Rob Landley <rob@landley.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Taras Kondratiuk <takondra@cisco.com>, "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, xe-linux-external@cisco.com



On Fri, 26 Jan 2018, Henrique de Moraes Holschuh wrote:

> On Thu, 25 Jan 2018, Rob Landley wrote:
>> That said, I don't think -h newcx should emit (or recognize) the
>> "TRAILER!!!1!" entry. That's kinda silly in-band signaling for 2018:
>> files have a length, pipes provide EOF, and each cpiox entry starts with
>> 6 bytes of c_magic anyway.

My understanding that TRAILER is really used on tape devices,
there is no notion of file end in this case, it is just a stream of bytes
from char device.

Thanks,
Victor

>> (I stopped toybox from producing the TRAILER
>> entry back in june, toybox commit 32550751997d, and the kernel consumes
>> the resulting cpio just fine. All the trailer does is prevent you from
>> concatenating cpio files, which is a feature multiple people asked me for.)
>
> Not in the kernel.  What TRAILER does in the kernel is to act as a
> barrier for the hardlink creation state, which IS a good thing.  You
> could just specify it as such for "newcx".
>
> The kernel will continue reading for more entries after TRAILER, so
> concatenation is not broken by TRAILER.  It is also insensitive to
> NUL-padding length (as long as it is 4-byte aligned), which is another
> nice feature you could specify for "newcx".
>
> Also, the kernel does something nothing in userspace ever tried to,
> AFAIK: it detects compression signatures along with the CPIO header
> signatures, and thus it can take several compressed and uncompressed
> archives concatenater together (and the compressor doesn't need to be
> the same, either).
> --
>  Henrique Holschuh
>
