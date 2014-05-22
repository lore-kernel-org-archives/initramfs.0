From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: live rootfs from squashfs and read write ability
Date: Thu, 22 May 2014 17:59:25 +0800
Message-ID: <20140522095925.GG1859@darkstar.nay.redhat.com>
References: <CACaajQsj71mL4BciOPaNTx2wN_A2SiBM=babpsUK5QGzQ2Yreg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACaajQsj71mL4BciOPaNTx2wN_A2SiBM=babpsUK5QGzQ2Yreg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/21/14 at 04:51pm, Vasiliy Tolstov wrote:
> Hello! I'm very happy with dracut (i'm create live squashfs image and
> boot it), but as i see i have my root in read only mode. How can i get
> route in read/write mode (in ram).
> My cmdline like:
> bond=bond0:eth0,eth1:mode=6 net.ifnames=0 ip=bond0:auto6 rd.bootif=0
> rd.md=0 rd.dm=0 rd.lvm=0 rd.luks=0 rd.shell
> root=live:http://[2001:db8:0:f101:92e2:baff:fe31:44e]/image/mh-vm/image.squashfs
> console=tty0 console=ttyS1,115200 rw

I don't think there's easy solution for read-write mount since it need stacked fs like
unionfs. But maybe you can try mount some folder as tmpfs such as /tmp, /var etc.
and only write to the specific folders.

I imagine a simpe implement for unionfs specific for initramfs use.. 

Thanks
Dave
