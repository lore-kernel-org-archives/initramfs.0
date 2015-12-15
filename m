From: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Subject: Re: Extend initramfs archive format to support xattrs
Date: Tue, 15 Dec 2015 10:44:54 -0600
Message-ID: <56704386.1090106@landley.net>
References: <1434983836.3558.11.camel@linux.vnet.ibm.com>
 <55882E39.2030906@fridu.net> <1449697604.2937.150.camel@linux.vnet.ibm.com>
 <COL125-W325C9BFBC043CD534A7789E2EC0@phx.gbl>
 <1450099035.2702.29.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=atDPzG2Zhg1hW99kn8IdCSvQJB2Mou8r10PqGWw9o0E=;
        b=04leQPw+cqSQRkEqW9REPMQ4yvW7tR4z0lRgJiDO3GeBl7YtkHna9MgKSpfj7MIrXj
         ijJx0CXCe673dLKAcBvNbw++DwaWvJ+mdIAG17H11iT9xGw8Hec5NNPJ5FqnApc1iLQk
         VLsNyO9ketF7htJhLOVIJayiPmQptBFaneEAeI4aon5Ld8TZruEzjEfVEL5qEkjpvUuQ
         zJLXCLX4I1CbwczJYwrvFa0iJbc6DJCc3UfPWA8bRGQu6VvzGmVvbPdxCstc8BD/zuNX
         qWK49qm/KCjsQDe8Lztv8mJkb4xjVSdm3WF/6Pns+y+gGLorE93lwS0ukQqUbNJbDVB1
         YRKg==
In-Reply-To: <1450099035.2702.29.camel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, James McMechan <james_mcmechan-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Josh Boyer <jwboyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dominig ar Foll Intel OTC <dominig.arfoll-GYgxVzVJcz1eoWH0uzbU5w@public.gmane.org>, Nick Kralevich <nnk-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

On 12/14/2015 07:17 AM, Mimi Zohar wrote:
> Hi James,
> 
> I think we need to describe the basic problem being discussed, make a
> list of the problems and then decide which could and should be addressed
> before upstreaming the initramfs xattr support.

I still have this on my todo list for toybox and would very much like to
be involved.

Any archive format change should add xattrs, fix the 32 bit time with no
nanoseconds problem too, and probably the 32 bit file size limit while
we're there.

Beyond that, cpio was chosen because it's simple. Let's not complicate
it unnecessarily?

> The patches posted about a year ago to extend the initramfs archive
> format to support xattrs changed the initramfs magic number from 070701
> to 070703.  James pointed out, in an offline email, a number of problems
> that should be addressed, before making this magic number change.

Here's my suggestion:

For the new type just change all the fields from 32 bits to 64 bits
(I.E. from 8 to 16 hex digits), and tack on xattrcount. With data
compression the difference more or less vanishes, and the header size
still fits in 256 bytes.

This keeps the parsing simple (all fields after the first are the same
size!) while solving not only filesize and timestamp (interpreted now as
seconds=mtime>>20; nanosecs=mtime&((1<<20)-1); which gives us half a
million years and change), but this also addresses the 32 bit inode and
nlink limits (in case anyone cares).

If xattrcount is nonzero, then at the end of this entry's datastream
have a 16 digit size, followed by that much data, repeated xattrcount
times. Each one is a key=value and the point of size is we don't care
what the value is (embedded NUL? No problem!).

If somebody wants a "data fork" instead of an xattr, pick a magic key
name for it. Not our problem. Smack vs Selinux: not our problem.

> James' original list:
> 1) Bad CRC it just added bytes together not even a real crc much less
> something that would cause confidence like md5 or shaX, or better a
> digital signature. of course we are not even using that CRC yet.

The enclosing compression checksums the data, no need to repeat it. As
you say, we're not currently using the cpio checksum. We're using the
gzip (or lzma...) checksum.

Heck, using the checksum field _as_ the xattrcount field in the new
format would work for me, but I don't feel strongly about the issue. If
you instead want to take 64 bits of data and use... I dunno, sha1sum
with the high and low halves xored, up to you.

> 2) It is still missing the other two timestamps all three of which
> should likely be extended beyond 64bits if you want sub-second accuracy

Why? Initramfs doesn't particularly need to distinguish creation,
modification, and access time.

We should extend beyond 32 bits for y2038 reasons. (Yeah unsigned gives
us almost another century but as long as we're changing the format
anyway...) A 64 bit format with 44 bits of time and 20 bits of
nanoseconds seems straightforward enough and gets us half a million years.

Again, not strongly opposed, just don't see a use case for it. Tar
exists if you want fancy.

> 3) The missing user and group names

We have existing uid and gid names. Are you suggesting that the kernel's
initramfs parser should reach into userspace, read the /etc/passwd file
that initramfs supplied, and confirm that those uid and gid names _match_?

I'm not following this suggestion at all. The kernel adding magic
uid/gid values for devtmpfs was deeply questionable, but at least it was
still numbers not names.

> 4) Lack of padding/blocking control; having the file data uncompress on
> a page boundary would be very convenient for the tmpfs

I don't see how that's cpio's problem? The data currently gets copied
into the page cache to align it: life is good.

The alternative you're suggesting seems to be putting each file's cpio
header and a lot of padding on its own page, which means you eat one
page per file during decompression, which can get big fast _and_ means
you've made confetti of physical memory in early boot when you discard
them all.

If you want to make the cpio extractor cleverer you can have it
decompress 64k at a time and handle the decompression in cache-friendly
chunks. Filling up and processing an output buffer is a thing they have
to be able to do. The processing is usually just write() in userspace
but it's a hook we can use. Then process just the data in that buffer
before extracting the rest (special case if you end halfway through a
cpio header copy it to the start of the buffer and do a decompress of
64k-remainder, but that's not a big deal).

The advantage of that is your extracted cpio copy should fit into L2
cache even on low-end chips, and be able to flush a page at a time to
DRAM in nice friendly sequential bursts to the same bank. (Heck, 32k
should be plenty and that's cache local for almost everything, modulo
the compressor's internal data probably not being so for anything but
gzip...)

This does not require any change to the file format.

> 5) Handling sparse files

Detect whole-page runs of zeroes during decompression. Gzip the file and
they basically go away. This does not require a format change, and
adding one is unnecessary complexity.

> 6) Alternate streams, for example Mac OS and NTFS

We're proposing adding xattr support. They contain arbitrary data and
are of arbitrary length. Pick a magic xattr name for your stream, not
our problem.

The above "xattr length, xattr contents" means you can have any in-band
data you want, we don't mess with the contents other than expecting a
"name=" header identifying each one.

> 7) The longer device major and minor numbers.

Currently devmajor is 32 bits and devminor is 32 bits. You need longer
than that?

Ok, this proposal would extended them to 64 bits anyway (treat all the
fields the same and simplify the parsing as an array), but I don't
understand the objection...

> Do we need to address all of these issues?

No?

> Are there any other changes,
> which should be made before changing the magic number?

My cpio.txt isn't on this machine, but not off the top of my head? File
size, file date, and xattr are the big ones.

> Mimi

Rob
