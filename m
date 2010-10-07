From: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Subject: Re: Dracut NFS root rw before pivot but ro after pivot
Date: Thu, 07 Oct 2010 12:29:35 +1100
Message-ID: <20101007122935.19334qntub6vdeo0@webmail.zoltak.com>
References: <20101005124250.12811x7b1hr8g23k@webmail.zoltak.com>
 <20101005165245.12962kslvxq6cmyo@webmail.zoltak.com>
 <20101005174817.98833aq1pzqn2cds@webmail.zoltak.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101005174817.98833aq1pzqn2cds-2RFepEojUI3Y3UUic/vCjNBPR1lH4CV8@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Guys,

After reviewing this I found my observations were incorrect.

I have since tried NFSv4 with the same result. I'm now back using NFSv3.

I am booting to pre-pivot rdbreak=pre-pivot.

If I cd /sysroot/tmp (as I did previously) and ../bin/touch test the  
test file is created however the permissions are nobody:nobody:

-rw---- 1 nobody nobody 0 Oct    7 11:47 test

If I try the same in /sysroot i.e. ./bin/touch test I then get:  
Permission denied

For some reason the NFS is seeing the root UID.

The mount options are  
10.197.170.5:/vol/filerboot/linux/images/live-mon-test /sysroot -o  
rw,fg,timeo=6000,retrans=2,rsize=32768,wsize=32768,hard,nointr,noacl,tcp,nfsver=3,nolock,sec=sys

If I chroot into /sysroot and do id it returns with:
uid=0(root) gid=0(root) groups=0(root)

however files get created with the nobody attribute in /tmp?

rpcbind appears to be running as the root user.

When I try to start services such as rpc.statd within the chroot I  
get: superuser access required.

Any ideas?



