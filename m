From: Neil Brown <neilb-IBi9RG/b67k@public.gmane.org>
Subject: Re: dracut is too "clever" at identifying modules to exclude.
Date: Tue, 13 Oct 2015 07:30:37 +1100
Message-ID: <87vbabzv6a.fsf@notabene.neil.brown.name>
References: <20150409140840.0bb6d59d@notabene.brown> <87r3l023ha.fsf@notabene.neil.brown.name> <561BD1E9.5010007@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <561BD1E9.5010007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, trenn-IBi9RG/b67k@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:

> On 12.10.2015 05:02, Neil Brown wrote:
>>=20
>> If I have booted a kernel with md/raid built in (no modules) and
>> I use dracut to build the initramfs for a different kernel which
>> has the md code compiled as separate modules, then it does not include
>> the required md modules in the initramfs.
>>=20
>> As a particular instance this happen when the root filesystem is on
>> RAID0.  The 'raid0.ko' module is not included and boot fails.
>>=20
>> https://bugzilla.opensuse.org/show_bug.cgi?id=3D935993
>>=20
>> This only happens when 'host-only' is selected (which is the default for
>> openSUSE).
>>=20
>> the modules.d/90mdraid/module-setup.sh code calls
>>=20
>>     instmods =3Ddrivers/md
>>=20
>> instmods calls
>>    module_is_host_only "raid0"
>> and this incorrectly fails.
>>=20
>> If raid0.ko didn't have any alias this would succeed, but it does.
>>=20
>> $ modinfo -F alias raid0
>> md-level-0
>> md-raid0
>> md-personality-2
>
> Huh? Is the module not loaded?

No, because the running kernel has "md/raid built in (no modules)".

Thanks,
NeilBrown

>
>>=20
>> However these aliases don't appear in any modalias file in /sys/devices,
>> in /proc/crypto, or in /proc/modules.
>>=20
>> Maybe you could parse /proc/mdstat..
>>=20
>> if [ -f /proc/mdstat ]; then
>>   while read _d _c _a _m _x; do
>>    if [ "$_c" =3D ':' -a "$_a" =3D 'active' ]; then
>>       host_modalias["md-$_m"]=3D1
>>    fi
>>   done < /proc/mdstat
>> fi
>>=20
>> but it all seems rather fragile.  There are probably other modules that
>> might miss out accidentally. dm?
>>=20
>> Do we really need the host_modalias stuff?
>>=20
>> Thanks,
>> NeilBrown
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWHBhtAAoJEDnsnt1WYoG5dZsP/3i+jIG5EGAbXPr3zHlIbBqB
ELL3XiVD5jizoB4Dt0r1SawkpWLIpBy9gVJfC2yZl+gQpbk6QzdAwQzZMQYRScFp
e3IYZp09zJmPbJOJCvmWFUlVJhrft/zTyl4nkcr5DY7b+//CS+BrEVlRJQ4ihlDS
KxsmUdP0QU9AXuipDUZpHxCsgtNHzxVxup0wZk+0B0k6LuJLB6S4utXBkGxLV9pj
sbiw6N8Vx0u/btlnVDapQ86FTtQ5IW66rtUhQQ+urVi422sqVY5a5rrsPcmkQcZW
swX4mqXVUvH3NGMCGLTnIG7C/kxkgtRng+gv2jA9+Hx44xSQ0fLL3zmOB9/Ijoov
VcBDJ/jn+9NJSEELS4FFohUuVhXqJ2gVg5ydwx3tjpLBcBW76+QI/n+tv3vs8o/h
b5cYi27mKYsKtQrngBlyssuVyk92+k+zsob8Grqsqg/ZKzJ7YRJUUTNiDKpGNqWQ
FgFbG3RHv8pfuqD7qEbkGohTQ/RLRVDaL4FVFSctVuiwIxuu0AAp3wCE/ZmokA4Z
MhYwIjfp7FjTHaZatny6u5s5KHrI18QvK4iXbxp6al40Tn3XSj9a1oZN8M1rWQKj
zH2+paYPx5pwBTGLcL+pU0FQRQza2Cgzb22p7qSTfafNEbowBk/z+Jm+JkUPt4Mm
yO4/Ql3nd/XAFHsOlSlf
=3X06
-----END PGP SIGNATURE-----
--=-=-=--
