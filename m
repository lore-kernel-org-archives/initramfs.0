From: Wei Xu <wexu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Stuck at 'probing EDD (edd=off) .... Ok'
Date: Fri, 17 Feb 2017 00:00:20 +0800
Message-ID: <20170216160020.zwzctsc5eg5abisx@Wei-Dev>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Guys,
I have been sticking at this for several days after a fresh installation of 
centos/rhel7 server on my desktop. 

My desktop:
    Gigabyte B85M-D3V 
    Intel E1230V3
    DDR3 1600 8G
    256G ssd

The installation works fine and system boots up without any problem, but after
I recompiled the kernel with almost the same source code with the same config file 
to the released one(both 3.10.0a) and installed it, it kept sticking at
'probing EDD (edd=off) .... Ok'. I have googled it and tried almost every tip there.
I also built a generic initramfs and it changed nothing.

I have compared the contents with the installed initramfs and mine, no module 
less than the installed binary. the only difference was all the modules(*.ko)
were compressed with xz as well as they were shown up as '*.ko.xz' in official
binary, and mine are '*.ko' as normal. Would this be the trick?

Thanks,
Wei
