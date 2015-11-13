From: Hannes Reinecke <hare-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH] Use udev rules to create dmraid /dev/mapper/ devices
Date: Fri, 13 Nov 2015 16:04:34 +0100
Message-ID: <5645FC02.9060602@suse.com>
References: <1435330557-17685-9-git-send-email-trenn@suse.de> <1435599415-10187-1-git-send-email-trenn@suse.de> <559BBAF5.5000501@redhat.com> <559BBE0F.1070903@suse.com> <5645C2D6.2010702@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5645C2D6.2010702-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heinz Mauelshagen <heinzm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 11/13/2015 12:00 PM, Harald Hoyer wrote:
> On 07.07.2015 13:54, Hannes Reinecke wrote:
>> On 07/07/2015 01:41 PM, Harald Hoyer wrote:
>>> On 29.06.2015 19:36, Thomas Renninger wrote:
>>>> From: Hannes Reinecke <hare-IBi9RG/b67k@public.gmane.org>
>>>>
>>>> https://bugzilla.opensuse.org/show_bug.cgi?id=3D905746
>>>>
>>>> Version 2: Remove 64-md-raid.rules
>>>>
>>>> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
>>>> ---
>>>>  modules.d/90dmraid/dmraid.sh       | 2 --
>>>>  modules.d/90dmraid/module-setup.sh | 2 ++
>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/modules.d/90dmraid/dmraid.sh b/modules.d/90dmraid/dmr=
aid.sh
>>>> index 3dcff38..cc4390f 100755
>>>> --- a/modules.d/90dmraid/dmraid.sh
>>>> +++ b/modules.d/90dmraid/dmraid.sh
>>>> @@ -26,8 +26,6 @@ if [ -n "$DM_RAIDS" ] || getargbool 0 rd.auto; t=
hen
>>>>                  if [ "${s##$r}" !=3D "$s" ]; then
>>>>                      info "Activating $s"
>>>>                      dmraid -ay -i -p --rm_partitions "$s" 2>&1 | =
vinfo
>>>> -                    [ -e "/dev/mapper/$s" ] && kpartx -a "/dev/ma=
pper/$s" 2>&1 | vinfo
>>>> -                    udevsettle
>>>>                  fi
>>>>              done
>>>>          done
>>>> diff --git a/modules.d/90dmraid/module-setup.sh b/modules.d/90dmra=
id/module-setup.sh
>>>> index e8de5f5..797a58e 100755
>>>> --- a/modules.d/90dmraid/module-setup.sh
>>>> +++ b/modules.d/90dmraid/module-setup.sh
>>>> @@ -74,6 +74,8 @@ install() {
>>>> =20
>>>>      inst "$moddir/dmraid.sh" /sbin/dmraid_scan
>>>> =20
>>>> +    inst_rules 66-kpartx.rules 67-kpartx-compat.rules
>>>> +
>>>>      inst_libdir_file "libdmraid-events*.so*"
>>>> =20
>>>>      inst_rules "$moddir/61-dmraid-imsm.rules"
>>>>
>>>
>>> Fedora does not have 66-kpartx.rules nor 67-kpartx-compat.rules ...
>>>
>>> Heinz, do we need the kpartx part still?
>>>
>>> I reverted to kpartx, because "dmraid" adds a "p" as a seperator by=
 default for
>>> the partitions and this breaks existing installations.
>>>
>>
>> I would recommend splitting the kpartx call into a separate udev
>> rule; otherwise you'll run into timing issues with udev.
>>
>> Cheers,
>>
>> Hannes
>>
>=20
> Care to share your 66-kpartx.rules 67-kpartx-compat.rules or make the=
m
> upstream? Shouldn't we agree on one naming scheme?
>=20
Sure, I'd love to.

Although the 67-kpartx-compat.rules is pretty much SUSE specific, as
we've messed up the device-mapper device naming
(older SUSE versions would be creating device-mapper names with
underscores, but the links would be using normal dashes).
So it's not relevant to the general audience, but yeah I'd like
to have them both included.

Will be sending patches to multipath-tools covering that.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		               zSeries & Storage
hare-IBi9RG/b67k@public.gmane.org			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
