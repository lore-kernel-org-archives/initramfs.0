From: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>
Subject: Re: iscsi netboot failure in case of multiple interfaces
Date: Wed, 15 Nov 2017 14:12:20 +0100
Message-ID: <1510751540.17501.55.camel@suse.de>
References: <3d6d6a40-692f-6c7f-fadd-ef6ccaab510d@oracle.com>
         <98407a21-3e1d-6355-1ba5-f732afb674d7@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <98407a21-3e1d-6355-1ba5-f732afb674d7-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Si-Wei <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Vasanth Vemula <vasanth.vemula-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Hello Cathy,

On Mon, 2017-11-13 at 10:43 -0800, Cathy Zhou wrote:
> Dracut experts,
> 
> A gentle reminder ...  Looking forward to gaining some insights on
> below 
> questions.

I haven't analyzed your scenario in detail, but IMHO this is a long-
standing issue. dracut is using both iscsid and iscsistart, which is
wrong. iscsistart is meant for situations where iscsid is not
available. It starts iscsid at startup, and stops it again when done.
If proper iscsid is running, iscsiadm should be used rather than
iscsistart to activate sessions.

In my experience, iscsistart will only work reliably if you have just a
single interface.

Martin
