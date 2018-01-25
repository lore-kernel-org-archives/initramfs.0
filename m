From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/15] Documentation: add newcx initramfs format description
Date: Thu, 25 Jan 2018 10:29:12 +0100
Message-ID: <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com> <1516850875-25066-2-git-send-email-takondra@cisco.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fyIk78pod9xeYj04xi8I/gXuJE7wryUm5CMMIdB89rE=;
        b=fJ9AjSXuR13SUA2BUHfYBUoTSOne4YmuU6i0WVPEJ1JBoXRlXwiAMsthBkXaNEX9bX
         dOh3NvEROX5bOaonunFRI+kZP/uJnO+bBWIOWMTxxmDGTWWmjpytw35I2VyphDcP35bD
         Yv8wZ7Nm4BlFQnZg3YEu58NDjhHcepglw1Mv4oqJ61uJhZvuea1D9Noib8SEl2jPpLEs
         tova+z+T5w5Zqz1wMxn+qpsa5q+dQCr5DBjw8P0mSfFpAMWZhfO9dZeETcnerGzESCE/
         VU2tIbFvcqOmtkGbIUVCQw6FNOjE/ukMmEgIJw5qeUH0In4alDTOPJu8ut7mPfg7DoCw
         PbmA==
In-Reply-To: <1516850875-25066-2-git-send-email-takondra@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Taras Kondratiuk <takondra@cisco.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, xe-linux-external@cisco.com

On Thu, Jan 25, 2018 at 4:27 AM, Taras Kondratiuk <takondra@cisco.com> wrote:
> Many of the Linux security/integrity features are dependent on file
> metadata, stored as extended attributes (xattrs), for making decisions.
> These features need to be initialized during initcall and enabled as
> early as possible for complete security coverage.
>
> Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
> support including them into the archive.
>
> This patch describes "extended" newc format (newcx) that is based on
> newc and has following changes:
> - extended attributes support
> - increased size of filesize to support files >4GB.
> - increased mtime field size to have usec precision and more than
>   32-bit of seconds.
> - removed unused checksum field.
>
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>

Ah nice, I like the extension of the time handling, that certainly
addresses one of the issues with y2038 that we have previously
hacked around in an ugly way (interpreting the 32-bit
number as unsigned).

However, if this is to become a generally supported format
for cpio files, could we make it use nanosecond resolution
instead? The issue that I see with microseconds is that
storing a file in an archive and extracting it again would
otherwise keep the mtime stamp /almost/ identical on file
systems that have nanosecond resolution, but most of
the time a comparison would indicate that the files are
not the same.

Unfortunately, the range of a 64-bit nanoseconds counter
is still a bit limited (584 years, or half of that if we make it
signed). While this is clearly enough for the uses in
initramfs, it still has a similar problem: someone creating
a fake timestamp a long time in the past or future on
a file system would lose information after going though
cpio.

         Arnd
