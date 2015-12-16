From: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>
Subject: Re: dracut is too "clever" at identifying modules to exclude.
Date: Wed, 16 Dec 2015 15:15:33 +1100
Message-ID: <87mvtb9ggq.fsf@notabene.neil.brown.name>
References: <20150409140840.0bb6d59d@notabene.brown> <87r3l023ha.fsf@notabene.neil.brown.name> <561BD1E9.5010007@redhat.com> <87vbabzv6a.fsf@notabene.neil.brown.name> <5645D9A1.3040304@redhat.com> <5645DACA.20403@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5645DACA.20403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, trenn-IBi9RG/b67k@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13 2015, Harald Hoyer wrote:

> On 13.11.2015 13:37, Harald Hoyer wrote:
>> On 12.10.2015 22:30, Neil Brown wrote:
>>> Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:
>>>
>>>> On 12.10.2015 05:02, Neil Brown wrote:
>>>>>
>>>>> If I have booted a kernel with md/raid built in (no modules) and
>>>>> I use dracut to build the initramfs for a different kernel which
>>>>> has the md code compiled as separate modules, then it does not include
>>>>> the required md modules in the initramfs.
>>>>>
>>>>> As a particular instance this happen when the root filesystem is on
>>>>> RAID0.  The 'raid0.ko' module is not included and boot fails.
>>>>>
>>>>> https://bugzilla.opensuse.org/show_bug.cgi?id=3D935993
>>>>>
>>>>> This only happens when 'host-only' is selected (which is the default =
for
>>>>> openSUSE).
>>>>>
>>>>> the modules.d/90mdraid/module-setup.sh code calls
>>>>>
>>>>>     instmods =3Ddrivers/md
>>>>>
>>>>> instmods calls
>>>>>    module_is_host_only "raid0"
>>>>> and this incorrectly fails.
>>>>>
>>>>> If raid0.ko didn't have any alias this would succeed, but it does.
>>>>>
>>>>> $ modinfo -F alias raid0
>>>>> md-level-0
>>>>> md-raid0
>>>>> md-personality-2
>>>>
>>>> Huh? Is the module not loaded?
>>>
>>> No, because the running kernel has "md/raid built in (no modules)".
>>>
>>> Thanks,
>>> NeilBrown
>>>
>>>>
>>>>>
>>>>> However these aliases don't appear in any modalias file in /sys/devic=
es,
>>>>> in /proc/crypto, or in /proc/modules.
>>>>>
>>>>> Maybe you could parse /proc/mdstat..
>>>>>
>>>>> if [ -f /proc/mdstat ]; then
>>>>>   while read _d _c _a _m _x; do
>>>>>    if [ "$_c" =3D ':' -a "$_a" =3D 'active' ]; then
>>>>>       host_modalias["md-$_m"]=3D1
>>>>>    fi
>>>>>   done < /proc/mdstat
>>>>> fi
>>>>>
>>>>> but it all seems rather fragile.  There are probably other modules th=
at
>>>>> might miss out accidentally. dm?
>>>>>
>>>>> Do we really need the host_modalias stuff?
>>>>>
>>>>> Thanks,
>>>>> NeilBrown
>>>>>
>>=20
>> Interesting... so we have to blow up the initramfs with the entire drive=
rs/md
>> in the case, where you switch from "compiled in" to "not compiled in"..
>>=20
>> I guess that happens not that often, so better be safe than sorry.
>
> remove host_modalias
>
> <https://github.com/haraldh/dracut/commit/07a081f352497258862ae164d11d9e6=
dc2c5b959>

Thanks a lot for resolving this!

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcOVlAAoJEDnsnt1WYoG5leIQAJN7IG+Qwe+FLEUlHEfF6mqB
x+ezv4YkNEyQXogJmXfxL6UhLt/PAweumN08rRnytdEUswdmgPyL7ICSpEOhcvZr
HM5U43Tb/DJMprqJXw3wP7CBYG8SY1XAVZfh7GpxdD4I6gYoRRn+2IWlSJtM50z6
jZuYeFbp5O5iFY8UPGls4J/2Pv0tTBjo6ZwVIKkn9IIrT4ha7Yb1qPAM7YYyNMLO
+SXsB8PDPHPZ7pG0Kqak4A0XpyUMg/MTEaykvGzP/lWwCE0AS+CIM/+fvKPLSTEI
NzquNxisxsRnIZ7pk1NoPMsWacmLBnWtVizylE3Uw4RJSKMZYBQO8XvLzaBnZN/7
DLa5xFy4YkiIlY+t6nEqSCAJdqhTQ93a+vYoMRzCy8FmhBd7NpIjsDqeuyHQ6vgo
fsb1wNwLKqrFCLrrnHQEfcrevYbeoDVhaIza0hJIj87xl5YNsH085/tZc4MHcTr7
jHnBAWCdGJDdWyO8jtj+Z8FuBLW63YQ6kNRggn6kTNemBAmuylJesISAGMgFxdQj
B0J+gu2ugKPGLzWX/aqXa5JnC6RdaNR0xkG0CLmwkw6bckWHx4Lr/M6sRg7CdDDI
txUO8MhbMKKou4uQ0LvCQRiMCqhg7d4BC/hoi6kO/cJGRcjYIAvNaZ/TfRVtIm75
/9NX43cNDfk7QviNtvQ5
=XpNb
-----END PGP SIGNATURE-----
--=-=-=--
