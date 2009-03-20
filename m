From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: Thoughts on mounting the rootfs from a udev rule
Date: Fri, 20 Mar 2009 14:40:02 +0100
Message-ID: <ac3eb2510903200640w1cfab1d4sbadc3db7b2f11e06@mail.gmail.com>
References: <1237496785.5070.28.camel@sentry-no.fnordovax.org>
	 <49C3546C.8050505@suse.de>
	 <1237540487.5070.54.camel@sentry-no.fnordovax.org>
	 <49C360B3.9020107@bfh.ch> <20090320123018.GB3363@nb.net.home>
	 <49C39509.2020205@bfh.ch>
	 <ac3eb2510903200613k6826172cl4766b48edea92228@mail.gmail.com>
	 <49C3987F.8010804@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49C3987F.8010804-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Mar 20, 2009 at 14:22, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>=
 wrote:
> Kay Sievers wrote:
>> On Fri, Mar 20, 2009 at 14:07, Seewer Philippe <philippe.seewer@bfh.=
ch>
>> wrote:
>>>
>>> Karel Zak wrote:
>>>>
>>>> On Fri, Mar 20, 2009 at 10:24:03AM +0100, Seewer Philippe wrote:
>>>>>
>>>>> Again, is it possible to send events to udev from Userspace?
>>>>
>>>> =C2=A0uevent files in /sys ?
>>>>
>>>> =C2=A0echo "change" > /sys/devices/pci0000:00/0000:00:19.0/net/eth=
0/uevent
>>>
>>> good point! but... whatever I write in there, 'udevadm monitor' sho=
ws
>>> this:
>>>
>>> UEVENT[1237554273.439387] add
>>> =C2=A0/devices/pci0000:00/0000:00:19.0/net/eth0
>>> (net)
>>> UDEV =C2=A0[1237554273.446993] add
>>> =C2=A0/devices/pci0000:00/0000:00:19.0/net/eth0
>>> (net)
>>
>> You got an ancient kernel? That was added very long ago to use match
>> valid event actions.
>
> Same behaviour on:
> -Ubuntu 8.10 stock 2.6.27-11-generic
> -Debian 5.0 stock 2.6.26-1-686

Oh, that's fine. You got a warning in dmesg, I guess, saying that you
did not write a proper string to the file? It's falling back to 'add'
then. Make sure you are not writing invalid action strings to it.

Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
