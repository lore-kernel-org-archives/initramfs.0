From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Extend initramfs archive format to support xattrs
Date: Mon, 14 Dec 2015 08:17:15 -0500
Message-ID: <1450099035.2702.29.camel@linux.vnet.ibm.com>
References: <1434983836.3558.11.camel@linux.vnet.ibm.com>
	,<55882E39.2030906@fridu.net>,<1449697604.2937.150.camel@linux.vnet.ibm.com>
	 <COL125-W325C9BFBC043CD534A7789E2EC0@phx.gbl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <COL125-W325C9BFBC043CD534A7789E2EC0-MsuGFMq8XAE@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: James McMechan <james_mcmechan-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Josh Boyer <jwboyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dominig ar Foll Intel OTC <dominig.arfoll-GYgxVzVJcz1eoWH0uzbU5w@public.gmane.org>, Nick Kralevich <nnk-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>

Hi James,

I think we need to describe the basic problem being discussed, make a
list of the problems and then decide which could and should be addressed
before upstreaming the initramfs xattr support.

The patches posted about a year ago to extend the initramfs archive
format to support xattrs changed the initramfs magic number from 070701
to 070703.  James pointed out, in an offline email, a number of problems
that should be addressed, before making this magic number change.

James' original list:
1) Bad CRC it just added bytes together not even a real crc much less
something that would cause confidence like md5 or shaX, or better a
digital signature. of course we are not even using that CRC yet.
2) It is still missing the other two timestamps all three of which
should likely be extended beyond 64bits if you want sub-second accuracy
3) The missing user and group names
4) Lack of padding/blocking control; having the file data uncompress on
a page boundary would be very convenient for the tmpfs
5) Handling sparse files
6) Alternate streams, for example Mac OS and NTFS
7) The longer device major and minor numbers.
 
Do we need to address all of these issues?  Are there any other changes,
which should be made before changing the magic number?

Mimi
