From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 7/8] ensure pre-mount (and resume) run before root fsck
Date: Wed, 1 Jul 2015 17:47:54 +0200
Message-ID: <55940BAA.2000703@redhat.com>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
 <1435330557-17685-8-git-send-email-trenn@suse.de>
 <20150630024933.3c41d601@home.puleglot.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150630024933.3c41d601-gl4+DzqHFJJb4Dhfy2/fiQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 30.06.2015 01:49, Alexander Tsoy wrote:
> =D0=92 Fri, 26 Jun 2015 16:55:56 +0200
> Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>> From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> References:
>> https://bugzilla.suse.com/show_bug.cgi?id=3D906592
>> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
>> ---
>>  modules.d/98dracut-systemd/rootfs-generator.sh | 18
>> ++++++++++++++++++ 1 file changed, 18 insertions(+)
>>
>> diff --git a/modules.d/98dracut-systemd/rootfs-generator.sh
>> b/modules.d/98dracut-systemd/rootfs-generator.sh index
>> 5910ce7..7eb0b1a 100755 ---
>> a/modules.d/98dracut-systemd/rootfs-generator.sh +++
>> b/modules.d/98dracut-systemd/rootfs-generator.sh @@ -65,6 +65,23 @@
>> generator_mount_rootfs() fi
>>  }
>> =20
>> +generator_fsck_after_pre_mount()
>> +{
>> +    local _name
>> +
>> +    [ -z "$1" ] && return 0
>> +
>> +    _name=3D$(dev_unit_name "$1")
>> +    [ -d /run/systemd/generator/systemd-fsck@${_name}.service.d ] |=
|
>> mkdir -p /run/systemd/generator/systemd-fsck@${_name}.service.d
>> +    if !
>> [ -f /run/systemd/generator/systemd-fsck@${_name}.service.d/after-pr=
e-mount.conf
>> ]; then
>> +        {
>> +            echo "[Unit]"
>> +            echo "After=3Ddracut-pre-mount.service"
>> +        }
>>> /run/systemd/generator/systemd-fsck@${_name}.service.d/after-pre-mo=
unt.conf
>> +    fi
>> +
>> +}
>> +
>>  root=3D$(getarg root=3D)
>>  case "$root" in
>>      block:LABEL=3D*|LABEL=3D*)
>> @@ -95,6 +112,7 @@ GENERATOR_DIR=3D"$1"
>> =20
>>  if [ "${root%%:*}" =3D "block" ]; then
>>     generator_wait_for_dev "${root#block:}" "$RDRETRY"
>> +   generator_fsck_after_pre_mount "${root#block:}"
>>     strstr "$(cat /proc/cmdline)" 'root=3D' || generator_mount_rootf=
s
>> "${root#block:}" "$(getarg rootfstype=3D)" "$(getarg rootflags=3D)" =
fi
>> =20
>=20
> Hmmm.. How about systemd >=3D220? See the following change:
> http://cgit.freedesktop.org/systemd/systemd/commit/?id=3D4dda4e637e4c=
17a14db6cd265f36f5e8a5050367
>=20
> Shouldn't we also add "Before=3Dsystemd-fsck-root.service" to
> dracut-pre-mount.service?
>=20

Good point.. yes
