From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH] Make kill-dhclient.sh more readable
Date: Fri, 05 Jun 2009 10:41:15 -0400
Message-ID: <1244212875.6963.0.camel@lap75545.ornl.gov>
References: <4A28E91D.1000006@bfh.ch> <4A28FC46.8070201@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A28FC46.8070201-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-06-05 at 13:06 +0200, Harald Hoyer wrote:
> On 06/05/2009 11:45 AM, Seewer Philippe wrote:
> > Checking for existing file is more readable than string comparison
> >
> > ---
> > diff --git a/modules.d/40network/kill-dhclient.sh
> > b/modules.d/40network/kill-dhclient.sh
> > index 19f258a..fcebd32 100755
> > --- a/modules.d/40network/kill-dhclient.sh
> > +++ b/modules.d/40network/kill-dhclient.sh
> > @@ -1,5 +1,5 @@
> > #!/bin/sh
> >
> > for f in /tmp/dhclient.*.pid; do
> > - [ "$f" != "/tmp/dhclient.*.pid" ] && kill $(cat $f)
> > + [ -e $f ] && kill $(cat $f)
> > done
> 
> but it involves a disk access :)
> for the sake of speed :) (not that it matters much here.. )

To a ram disk. :)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
