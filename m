From: Victor Kamensky <kamensky@cisco.com>
Subject: Re: [PATCH v3 01/15] Documentation: add newcx initramfs format
 description
Date: Fri, 16 Feb 2018 13:47:35 -0800 (PST)
Message-ID: <alpine.LRH.2.00.1802161336350.22409@sjc-ads-6991.cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com> <1518813234-5874-2-git-send-email-takondra@cisco.com> <d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com> <72480de8-e6d6-5125-e647-08815eb9f6a7@landley.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4232; q=dns/txt; s=iport;
  t=1518818230; x=1520027830;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=48p2y3cyXgYWGfe5pPOGmdy2Ufhl04uLnWHqTJB28dA=;
  b=XvRwuZDtodL12EjCWtjp+WeTQaaLmq7oc6ARPF3EsLRcs/M/VskHEbas
   +8PejWyahzwDHGW7U/YWyvcUnS3iE17hXzDUUNYFz/OUlBKsZohhvpnzM
   YYwo+wfgkXtXdbT37sSICjhh4nqjEE3ZV2uBGKkKe1xx1OwPECnEAqFQS
   Q=;
In-Reply-To: <72480de8-e6d6-5125-e647-08815eb9f6a7@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Taras Kondratiuk <takondra@cisco.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com



On Fri, 16 Feb 2018, Rob Landley wrote:

>
> On 02/16/2018 02:59 PM, H. Peter Anvin wrote:
>> On 02/16/18 12:33, Taras Kondratiuk wrote:
>>> Many of the Linux security/integrity features are dependent on file
>>> metadata, stored as extended attributes (xattrs), for making decisions.
>>> These features need to be initialized during initcall and enabled as
>>> early as possible for complete security coverage.
>>>
>>> Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
>>> support including them into the archive.
>>>
>>> This patch describes "extended" newc format (newcx) that is based on
>>> newc and has following changes:
>>> - extended attributes support
>>> - increased size of filesize to support files >4GB
>>> - increased mtime field size to have 64 bits of seconds and added a
>>>   field for nanoseconds
>>> - removed unused checksum field
>>>
>>
>> If you are going to implement a new, non-backwards-compatible format,
>> you shouldn't replicate the mistakes of the current format.  Specifically:
>
> So rather than make minimal changes to the existing format and continue to
> support the existing format (sharing as much code as possible), you recommend
> gratuitous aesthetic changes?
>
>> 1. The use of ASCII-encoded fixed-length numbers is an idiotic legacy
>> from an era before there were any portable way of dealing with numbers
>> with prespecified endianness.
>
> It lets encoders and decoders easily share code with the existing cpio format,
> which we still intend to be able to read and write.
>
>> If you are going to use ASCII, make them
>> delimited so that they don't have fixed limits, or just use binary.
>
> When it's gzipped this accomplishes what? (Other than being gratuitously
> different from the previous iteration?)
>
>> The cpio header isn't fixed size, so that argument goes away, in fact
>> the only way to determine the end of the header is to scan forward.
>>
>> 2. Alignment sensitivity!  Because there is no header length
>> information, the above scan tells you where the header ends, but there
>> is padding before the data, and the size of that padding is only defined
>> by alignment.
>
> Again, these are minimal changes to the existing cpio format. You're complaining
> about _cpio_, and that the new stuff isn't _different_ enough from it.
>
>> 3. Inband encoding of EOF: if you actually have a filename "TRAILER!!!"
>> you have problems.
>
> Been there, done that:
>
> http://lkml.iu.edu/hypermail/linux/kernel/1801.3/01791.html
>
>> But first, before you define a whole new format for which no tools exist
>> (you will have to work with the maintainers of the GNU tools to add
>> support)
>
> No, he's been working with the maintainer of toybox to add support (for about a
> year now), which gets him the Android command line. And the kernel has its own
> built-in tool to generate cpio images anyway.
>
> Why would anyone care what the GNU project thinks?

In our internal use of this patch series we do use gnu cpio
to create initramfs.cpio.

And reference to gnu cpio patch that supports newcx format is
posted in description for this serieis:

https://raw.githubusercontent.com/victorkamensky/initramfs-xattrs-poky/rocko/meta/recipes-extended/cpio/cpio-2.12/cpio-xattrs.patch

Whether GNU cpio maintainers will accept it is different matter.
We will try, but we need to start somewhere and agree on
new format first.

Thanks,
Victor

>> you should see how complex it would be to support the POSIX
>> tar/pax format,
>
> That argument was had (at length) when initramfs went in over a decade ago.
> There are links in Documentation/filesystems/ramfs-rootfs-initramfs.txt to the
> mailing list entries about it.
>
>> which already has all the features you are seeking, and
>> by now is well-supported.
>
> So... tar wasn't well-supported 15 years ago? (Hasn't the kernel source always
> been distributed via tarball back since 0.0.1?)
>
> You're suggesting having a whole second codepath that shares no code with the
> existing cpio extractor. Are you suggesting abandoning support for the existing
> initramfs.cpio.gz file format?
>
> Rob
>
