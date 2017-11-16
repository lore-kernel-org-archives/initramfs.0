From: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>
Subject: Re: iscsi netboot failure in case of multiple interfaces
Date: Thu, 16 Nov 2017 14:03:05 +0100
Message-ID: <1510837385.10823.6.camel@suse.de>
References: <3d6d6a40-692f-6c7f-fadd-ef6ccaab510d@oracle.com>
         <98407a21-3e1d-6355-1ba5-f732afb674d7@oracle.com>
         <1510751540.17501.55.camel@suse.de>
         <d15c3567-509e-7bcd-62e9-6930b203753b@oracle.com>
         <08997d6f-0b94-af50-d407-0c4803a70697@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <08997d6f-0b94-af50-d407-0c4803a70697-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: si-wei liu <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Vasanth Vemula <vasanth.vemula-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

On Wed, 2017-11-15 at 11:47 -0800, si-wei liu wrote:
> On 11/15/2017 11:17 AM, Cathy Zhou wrote:
> > 
> Please let us know if it's desirable to keep iscsid around, or we
> can 
> post patch to make iscsistart manage iscsid instead (or leave iscsid 
> disabled).

IMO dracut should ditch iscsistart and work cleanly with iscsid and
iscsiadm. We have some patches in openSUSE that unfortunately never
quite hit upstream, see e.g. here:

https://github.com/danimo/dracut/commit/5ac36324e3daa897152929e67718250
1b9d20c1f#diff-6dcf84c45218f1adf71f53a6cd80b5c9

Martin
