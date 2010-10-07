From: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Subject: Re: Dracut NFS root rw before pivot but ro after pivot
Date: Fri, 08 Oct 2010 10:07:27 +1100
Message-ID: <20101008100727.16265uf7e1ry9okw@webmail.zoltak.com>
References: <20101005124250.12811x7b1hr8g23k@webmail.zoltak.com>
 <20101005165245.12962kslvxq6cmyo@webmail.zoltak.com>
 <20101005174817.98833aq1pzqn2cds@webmail.zoltak.com>
 <20101007122935.19334qntub6vdeo0@webmail.zoltak.com>
 <20101007072427.GA30734@maude.comedia.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101007072427.GA30734-hdG+WfPrfN2JmafXlB/IVQ@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="flowed"
To: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Quoting Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>:

> On Thu, Oct 07, 2010 at 12:29:35PM +1100, daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org wrote:
>> If I cd /sysroot/tmp (as I did previously) and ../bin/touch test  
>> the test file is created however the permissions are nobody:nobody:
>>
>> -rw---- 1 nobody nobody 0 Oct    7 11:47 test
>
> you are probably exporting the nfs root without the no_root_squash flag
> check your nfs server configuration
>

Thanks Luca - I'm using a NetApp filer. I had to provide the UID for  
the root user in the export setup.

Normally I don't need to do this. Do you know why in this situation  
the mount is treated differently?

Everything is working with NFSv3 however when I use NFSv4 it boots  
fine to pre-pivot the file system is mounted but the ownership is  
reported as MAX_INT and I cannot write to any directory/file owned by  
MAX_INT. I found the bug report  
https://bugzilla.redhat.com/show_bug.cgi?id=570946. Does anyone know  
if this issue has been resolved or there is a work around?

Thanks!


