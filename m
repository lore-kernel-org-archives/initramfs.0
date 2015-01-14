From: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Subject: Re: [RFC][PATCH 6/9] gen_initramfs_list.sh: include xattrs
Date: Tue, 13 Jan 2015 22:34:14 -0600
Message-ID: <54B5F1C6.7040307@landley.net>
References: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>	 <1420663980-20842-7-git-send-email-zohar@linux.vnet.ibm.com>	 <CA+5PVA77x2W9LyHMq1jSW3HKqNgFPz-gPVOH0QtEmmMBwzOx_Q@mail.gmail.com>	 <1420729994.6338.52.camel@dhcp-9-2-203-236.watson.ibm.com>	 <54AECA32.6000304@landley.net>	 <1420754931.6338.95.camel@dhcp-9-2-203-236.watson.ibm.com>	 <54B56881.30403@landley.net>	 <1421180416.2119.73.camel@dhcp-9-2-203-236.watson.ibm.com>	 <54B5913C.5050109@landley.net> <1421205803.2119.110.camel@dhcp-9-2-203-236.watson.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421205803.2119.110.camel-ofEJDTH4t7tcpOBKWxGlqK+Pbu69ru6nqyM6JfAXOaQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: Josh Boyer <jwboyer-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-ima-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fionnuala Gunter <fin-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "casey.schaufler" <casey.schaufler-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Paul Moore <pmoore-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>



On 01/13/2015 09:23 PM, Mimi Zohar wrote:
> On Tue, 2015-01-13 at 15:42 -0600, Rob Landley wrote: 
>>> 4 bytes enough?
> 
>> Eh, as long as we're breaking compatibility anyway, we might as well
>> extend the file size. It's gzipped so the extra run of consecutive
>> zeroes isn't really an issue, and if tmpfs is going to support 64 bit
>> file sizes the thing that's populating them should to just to match.
>> (You can already have memory bigger than 4g. Some crazy person is going
>> to put a squashfs in tmpfs and loopback mount it, or have a giant video
>> there, or... Bootloaders being able to cope with this is not my problem. :)
> 
>> Probably having the new fields at the end (and gluing them to the
>> earlier ones) makes more sense than having variable sized fields? I
>> don't have a strong opinion either way.
> 
> The current file data size header field is a 8 character hexidecimal
> string, which is long enough to store 4g (0xFFFFFFFF).

The current header fields are all 32 bits, yes. To get a 64 bit field
we'd have to add a second 32 bit field and add it <<32 to the original
one, or else have the header fields be of varying sizes. That was the
"adding a new one to the end" thing mentioned above.

Then again if we add a new field right before the previous size then the
"treat it as 64 bits vs 2 32 bit ones" is an implementation detail
anyway. And for the moment we can just have it be padding that
compresses away and wait for an actual >4g file.

Unless you think nobody will ever need an archive member >4g in
initramfs, even though servers with ~256g are reasonably common today
already?

Rob
