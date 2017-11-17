From: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>
Subject: Re: iscsi netboot failure in case of multiple interfaces
Date: Fri, 17 Nov 2017 20:11:12 +0100
Message-ID: <1510945872.16284.37.camel@suse.de>
References: <3d6d6a40-692f-6c7f-fadd-ef6ccaab510d@oracle.com>
         <98407a21-3e1d-6355-1ba5-f732afb674d7@oracle.com>
         <1510751540.17501.55.camel@suse.de>
         <d15c3567-509e-7bcd-62e9-6930b203753b@oracle.com>
         <08997d6f-0b94-af50-d407-0c4803a70697@oracle.com>
         <1510837385.10823.6.camel@suse.de>
         <0a3f48bc-d110-e163-22a5-795c2d554297@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0a3f48bc-d110-e163-22a5-795c2d554297-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, si-wei liu <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Vasanth Vemula <vasanth.vemula-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

On Fri, 2017-11-17 at 10:34 -0800, Cathy Zhou wrote:
> Martin,
> 
> Thanks. I will take a detail look of the diff you sent. But a brief 
> browse of it raised one question: assuming we solely use iscsid and 
> iscsiadm instead of iscsistart, wouldn't iscsid be started outside
> of  
> iscsiroot.sh? Otherwise, the restart/stop/start of iscsid for one 
> interface could interfere with another iscsiroot instance for
> another 
> interface?

Yes, certainly, the iscsid service should be started only once. 

Please note that I'm not the author of the patch I linked, and that
this link I sent was also just a starting point:

https://github.com/danimo/dracut/commits/obs_from_git/modules.d/95iscsi

Note also that this branch is quite a bit behind upstream dracut in
other areas, so porting the iSCSI changes may not be trivial.

Regards,
Martin
