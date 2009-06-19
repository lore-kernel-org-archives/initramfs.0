From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Fri, 19 Jun 2009 12:58:04 -0400
Message-ID: <4A3BC39C.9030307@redhat.com>
References: <4A3B968C.5070600@bfh.ch> <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch> <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com> <1245428342.32104.3.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245428342.32104.3.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/19/2009 12:19 PM, David Dillow wrote:
> On Fri, 2009-06-19 at 11:08 -0500, Victor Lowther wrote:
>> Or you can include ethtool and check every half second until a timeo=
ut
>> to see if the link is back.
>
> With most switches, you'll get a link back almost immediately, but it
> will be in blocking mode and won't transmit your packets for 20-30
> seconds.

Our test suite can simulate this by using attaching qemu's -net tap=20
device to a bridge to talk to the other virtual machine instead of usin=
g=20
-net socket mcast mode.

qemu -net=20
tap[,vlan=3Dn][,name=3Dname][,fd=3Dh][,ifname=3Dname][,script=3Dfile][,=
downscript=3Ddfile]

script=3Dcan be a script that tells it to attach to a particular bridge=
=2E

#!/bin/sh
export PATH=3D/sbin:/usr/sbin:$PATH
BRIDGEDEV=3Dbr0
ifconfig $1 0.0.0.0 up
brctl addif ${BRIDGEDEV} $1

brctl setfd <bridge> <time> sets the bridge=92s =92bridge forward delay=
=92 to=20
<time> seconds.

Then you can use brctl to make the bridge's forward delay super long.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
