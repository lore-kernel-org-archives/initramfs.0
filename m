From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: check_finished() syntax weirdness
Date: Tue, 13 May 2014 16:21:56 +0200
Message-ID: <53722A84.7080205@suse.de>
References: <5371E992.1080802@suse.de> <5371EA56.3000203@redhat.com> <5371EC2E.4020209@suse.de> <5371F250.9040708@redhat.com> <5371F448.5030208@suse.de> <5371F645.3080309@redhat.com> <5371F729.2000100@suse.de> <53720BCF.5080806@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53720BCF.5080806-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/13/2014 02:10 PM, Harald Hoyer wrote:
> On 13.05.2014 12:42, Hannes Reinecke wrote:
>> On 05/13/2014 12:39 PM, Harald Hoyer wrote:
>>> On 13.05.2014 12:30, Hannes Reinecke wrote:
>>>> On 05/13/2014 12:22 PM, Harald Hoyer wrote:
>>>>> On 13.05.2014 11:55, Hannes Reinecke wrote:
>>>> [ .. ]
>>>>>>
>>>>>> Ah. So fcoe never worked?
>>>>>> (As it doesn't supply an 'finished' script)
>>>>>>
>>>>>> Cheers,
>>>>>>
>>>>>> Hannes
>>>>>
>>>>> What do you mean? Normally there are "finished" scripts installed=
, which wait
>>>>> for the root device to appear. So the loop continues until the fc=
oe device
>>>>> appears.
>>>>>
>>>> Not in my case.
>>>> Which module should install them?
>>>>
>>>> Cheers,
>>>>
>>>> Hannes
>>>
>>> for systemd:
>>>     modules.d/98systemd/rootfs-generator.sh:
>>> [ "${root%%:*}" =3D "block" ] && generator_wait_for_dev "${root#blo=
ck:}"
>>>
>>> for non-systemd:
>>>    modules.d/95rootfs-block/parse-block.sh:
>>> [ "${root%%:*}" =3D "block" ] && wait_for_dev "${root#block:}"
>>>
>>>
>>> What is your kernel command line?
>>>
>> BOOT_IMAGE=3D/boot/vmlinuz-3.12.18-4-default \
>> root=3DUUID=3D7b90aa11-62ba-4260-81c6-bcf43914e97e \
>> console=3Dtty0 console=3DttyS1,57600 sysrq_always_enabled \
>> panic=3D100 ignore_loglevel unknown_nmi_panic \
>> resume=3D/dev/disk/by-uuid/7be10c24-f0fe-4ecd-b04f-c307b0370c48 \
>> splash=3Dsilent quiet showopts crashkernel=3D166M-:83M \
>> rd.break=3Dpre-mount
>>
>> (The pre-mount thingie is inserted by me so that I have a chance to =
debug & fix
>> things)
>>
>> Cheers,
>>
>> Hannes
>
> do a rd.break=3Dinitqueue and look in the
> /lib/dracut/hooks/initqueue/finished
> directory.
>
> If you use systemd in the initramfs, you should have:
>
> /usr/lib/systemd/system-generators/dracut-rootfs-generator
>
> in the initramfs, which transforms root=3DUUID=3D... into the finishe=
d hook.
>
> You should be able to test it in the dracut shell with:
>
> # bash -x /usr/lib/systemd/system-generators/dracut-rootfs-generator

Which seems to be the problem; the generator is present, but apparently=
=20
not called.
Once I execute the above line the 'finished' entry for the root fs is=20
there. From which I surmise that the generator hasn't been called.

Hmm.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
