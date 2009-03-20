From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Thoughts on mounting the rootfs from a udev rule
Date: Fri, 20 Mar 2009 14:07:21 +0100
Message-ID: <49C39509.2020205@bfh.ch>
References: <1237496785.5070.28.camel@sentry-no.fnordovax.org> <49C3546C.8050505@suse.de> <1237540487.5070.54.camel@sentry-no.fnordovax.org> <49C360B3.9020107@bfh.ch> <20090320123018.GB3363@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090320123018.GB3363-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Karel Zak wrote:
> On Fri, Mar 20, 2009 at 10:24:03AM +0100, Seewer Philippe wrote:
>> Again, is it possible to send events to udev from Userspace?
> 
>  uevent files in /sys ?
> 
>  echo "change" > /sys/devices/pci0000:00/0000:00:19.0/net/eth0/uevent


good point! but... whatever I write in there, 'udevadm monitor' shows this:

UEVENT[1237554273.439387] add      /devices/pci0000:00/0000:00:19.0/net/eth0 (net)
UDEV  [1237554273.446993] add      /devices/pci0000:00/0000:00:19.0/net/eth0 (net)


>  
>     Karel
> 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
