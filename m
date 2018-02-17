From: hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH v3 01/15] Documentation: add newcx initramfs format description
Date: Fri, 16 Feb 2018 16:00:36 -0800
Message-ID: <A5A0727C-B932-49F6-A7D7-AA7CAECECF96@zytor.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com> <1518813234-5874-2-git-send-email-takondra@cisco.com> <d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com> <72480de8-e6d6-5125-e647-08815eb9f6a7@landley.net> <alpine.LRH.2.00.1802161336350.22409@sjc-ads-6991.cisco.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LRH.2.00.1802161336350.22409-fZ7xe+6E5F8pLdfb+Kaa2CW4+XlvGpQz@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Cc: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, James McMechan <james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xe-linux-external-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org

On February 16, 2018 1:47:35 PM PST, Victor Kamensky <kamensky-FYB4Gu1CFyUA=
vxtiuMwx3w@public.gmane.org> wrote:
>
>
>On Fri, 16 Feb 2018, Rob Landley wrote:
>
>>
>> On 02/16/2018 02:59 PM, H. Peter Anvin wrote:
>>> On 02/16/18 12:33, Taras Kondratiuk wrote:
>>>> Many of the Linux security/integrity features are dependent on file
>>>> metadata, stored as extended attributes (xattrs), for making
>decisions.
>>>> These features need to be initialized during initcall and enabled
>as
>>>> early as possible for complete security coverage.
>>>>
>>>> Initramfs (tmpfs) supports xattrs, but newc CPIO archive format
>does not
>>>> support including them into the archive.
>>>>
>>>> This patch describes "extended" newc format (newcx) that is based
>on
>>>> newc and has following changes:
>>>> - extended attributes support
>>>> - increased size of filesize to support files >4GB
>>>> - increased mtime field size to have 64 bits of seconds and added a
>>>>   field for nanoseconds
>>>> - removed unused checksum field
>>>>
>>>
>>> If you are going to implement a new, non-backwards-compatible
>format,
>>> you shouldn't replicate the mistakes of the current format.=20
>Specifically:
>>
>> So rather than make minimal changes to the existing format and
>continue to
>> support the existing format (sharing as much code as possible), you
>recommend
>> gratuitous aesthetic changes?
>>
>>> 1. The use of ASCII-encoded fixed-length numbers is an idiotic
>legacy
>>> from an era before there were any portable way of dealing with
>numbers
>>> with prespecified endianness.
>>
>> It lets encoders and decoders easily share code with the existing
>cpio format,
>> which we still intend to be able to read and write.
>>
>>> If you are going to use ASCII, make them
>>> delimited so that they don't have fixed limits, or just use binary.
>>
>> When it's gzipped this accomplishes what? (Other than being
>gratuitously
>> different from the previous iteration?)
>>
>>> The cpio header isn't fixed size, so that argument goes away, in
>fact
>>> the only way to determine the end of the header is to scan forward.
>>>
>>> 2. Alignment sensitivity!  Because there is no header length
>>> information, the above scan tells you where the header ends, but
>there
>>> is padding before the data, and the size of that padding is only
>defined
>>> by alignment.
>>
>> Again, these are minimal changes to the existing cpio format. You're
>complaining
>> about _cpio_, and that the new stuff isn't _different_ enough from
>it.
>>
>>> 3. Inband encoding of EOF: if you actually have a filename
>"TRAILER!!!"
>>> you have problems.
>>
>> Been there, done that:
>>
>> http://lkml.iu.edu/hypermail/linux/kernel/1801.3/01791.html
>>
>>> But first, before you define a whole new format for which no tools
>exist
>>> (you will have to work with the maintainers of the GNU tools to add
>>> support)
>>
>> No, he's been working with the maintainer of toybox to add support
>(for about a
>> year now), which gets him the Android command line. And the kernel
>has its own
>> built-in tool to generate cpio images anyway.
>>
>> Why would anyone care what the GNU project thinks?
>
>In our internal use of this patch series we do use gnu cpio
>to create initramfs.cpio.
>
>And reference to gnu cpio patch that supports newcx format is
>posted in description for this serieis:
>
>https://raw.githubusercontent.com/victorkamensky/initramfs-xattrs-poky/roc=
ko/meta/recipes-extended/cpio/cpio-2.12/cpio-xattrs.patch
>
>Whether GNU cpio maintainers will accept it is different matter.
>We will try, but we need to start somewhere and agree on
>new format first.
>
>Thanks,
>Victor
>
>>> you should see how complex it would be to support the POSIX
>>> tar/pax format,
>>
>> That argument was had (at length) when initramfs went in over a
>decade ago.
>> There are links in
>Documentation/filesystems/ramfs-rootfs-initramfs.txt to the
>> mailing list entries about it.
>>
>>> which already has all the features you are seeking, and
>>> by now is well-supported.
>>
>> So... tar wasn't well-supported 15 years ago? (Hasn't the kernel
>source always
>> been distributed via tarball back since 0.0.1?)
>>
>> You're suggesting having a whole second codepath that shares no code
>with the
>> existing cpio extractor. Are you suggesting abandoning support for
>the existing
>> initramfs.cpio.gz file format?
>>
>> Rob
>>

Introducing new, incompatible data formats is an inherently *very* costly o=
peration; unfortunately many engineers don't seem to have a good grip of ju=
st *how* expensive it is (see "silly embedded nonsense hacks", "too little,=
 too soon".)

Cpio itself is a great horror show of just how bad this gets: a bunch of mi=
nor tweaks without finding underlying design bugs resulting in a ton of mut=
ually incompatible formats.  "They are almost the same" doesn't help: they =
are still incompatible.

Introducing a new incompatible data format without strong justification is =
engineering malpractice.  Doing it under the non-justification of expedienc=
e ("oh, we can share most of the code") is aggravated engineering malpracti=
ce.

It is entirely possible that the modern posix tar/pax format is too complex=
 to be practical in this case =E2=80=93 that would be justifying a new form=
at.  But then you are taking the fundamental cost of breakage, and then the=
 new format definitely should not be replicating known defects of another f=
ormat and without at least some thought about how to avoid it in the future.
--=20
Sent from my Android device with K-9 Mail. Please excuse my brevity.
