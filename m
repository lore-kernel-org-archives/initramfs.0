From: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Subject: Re: Dracut NFS root rw before pivot but ro after pivot
Date: Thu, 7 Oct 2010 09:24:27 +0200
Message-ID: <20101007072427.GA30734@maude.comedia.it>
References: <20101005124250.12811x7b1hr8g23k@webmail.zoltak.com> <20101005165245.12962kslvxq6cmyo@webmail.zoltak.com> <20101005174817.98833aq1pzqn2cds@webmail.zoltak.com> <20101007122935.19334qntub6vdeo0@webmail.zoltak.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101007122935.19334qntub6vdeo0-2RFepEojUI3Y3UUic/vCjNBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Oct 07, 2010 at 12:29:35PM +1100, daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org wrote:
> If I cd /sysroot/tmp (as I did previously) and ../bin/touch test the test 
> file is created however the permissions are nobody:nobody:
>
> -rw---- 1 nobody nobody 0 Oct    7 11:47 test

you are probably exporting the nfs root without the no_root_squash flag
check your nfs server configuration

L.

-- 
Luca Berra -- bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org
         Communication Media & Services S.r.l.
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X        AGAINST HTML MAIL
  / \
