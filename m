From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: check_finished() syntax weirdness
Date: Tue, 13 May 2014 12:30:32 +0200
Message-ID: <5371F448.5030208@suse.de>
References: <5371E992.1080802@suse.de> <5371EA56.3000203@redhat.com> <5371EC2E.4020209@suse.de> <5371F250.9040708@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5371F250.9040708-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/13/2014 12:22 PM, Harald Hoyer wrote:
> On 13.05.2014 11:55, Hannes Reinecke wrote:
[ .. ]
>>
>> Ah. So fcoe never worked?
>> (As it doesn't supply an 'finished' script)
>>
>> Cheers,
>>
>> Hannes
>
> What do you mean? Normally there are "finished" scripts installed, wh=
ich wait
> for the root device to appear. So the loop continues until the fcoe d=
evice appears.
>
Not in my case.
Which module should install them?

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
