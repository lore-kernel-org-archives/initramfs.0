From: Harald Hoyer <harald-2VeQXyDyezErK2HsEjNOmQ@public.gmane.org>
Subject: Re: [PATCH] Extend 52f1b041 to allow devices to be specified in config
 files as well as cmdline.
Date: Tue, 22 Jan 2013 15:35:51 +0100
Message-ID: <50FEA3C7.9010606@harald-hoyer.de>
References: <1358767399-17302-1-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms050204070901050505010006"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358767399-17302-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Dies ist eine kryptografisch unterzeichnete Nachricht im MIME-Format.

--------------ms050204070901050505010006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 21.01.2013 12:23, schrieb Colin Guthrie:
> This also changes the command line switch to be --add-device and the
> config directive is set to add_device. This was chosen as device=3D in =
the
> config file seems too generic and not quite as consistent with other
> directives (i.e. drivers/add_drivers)
>=20
> The --device command line is still supported but it should be considere=
d
> deprecated in favour of --add-device.
> ---
>  dracut.8.asc      |  7 +++++--
>  dracut.conf.5.asc |  5 +++++
>  dracut.sh         | 15 +++++++++++++--
>  3 files changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/dracut.8.asc b/dracut.8.asc
> index 6300055..da7f327 100644
> --- a/dracut.8.asc
> +++ b/dracut.8.asc
> @@ -332,8 +332,11 @@ provide a valid _/etc/fstab_.
>      Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ and _<=
filesystem
>      options>_ in the initramfs
> =20
> -**--device** _<device>_ ::
> -    Bring up _<device>_ in initramfs, _<device>_ should be the device =
name
> +**--add-device** _<device>_ ::
> +    Bring up _<device>_ in initramfs, _<device>_ should be the device =
name.
> +    This can be useful in hostonly mode for resume support when your s=
wap is on
> +    LVM or an encrypted partition.
> +    [NB --device can be used for compatibility with earlier releases]
> =20
>  **-i, --include** _<SOURCE>_ _<TARGET>_::
>      include the files in the SOURCE directory into the
> diff --git a/dracut.conf.5.asc b/dracut.conf.5.asc
> index 68bd9eb..e545451 100644
> --- a/dracut.conf.5.asc
> +++ b/dracut.conf.5.asc
> @@ -82,6 +82,11 @@ If chrooted to another root other than the real root=
 device, use --fstab and pro
>  *add_fstab+=3D*" __<filename>__ "::
>      Add entries of __<filename>__ to the initramfs /etc/fstab.
> =20
> +*add_device+=3D*" __<device>__ "::
> +    Bring up _<device>_ in initramfs, _<device>_ should be the device =
name.
> +    This can be useful in hostonly mode for resume support when your s=
wap is on
> +    LVM an encrypted partition.
> +
>  *mdadmconf=3D*"__{yes|no}__"::
>      Include local _/etc/mdadm.conf_ (default=3Dyes)
> =20
> diff --git a/dracut.sh b/dracut.sh
> index 469f408..23ffaa4 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -134,7 +134,7 @@ Creates initial ramdisk images for preloading modul=
es
>    --mount "[DEV] [MP] [FSTYPE] [FSOPTS]"
>                          Mount device [DEV] on mountpoint [MP] with fil=
esystem
>                          [FSTYPE] and options [FSOPTS] in the initramfs=

> -  --device "[DEV]"      Bring up [DEV] in initramfs
> +  --add-device "[DEV]"  Bring up [DEV] in initramfs
>    -i, --include [SOURCE] [TARGET]
>                          Include the files in the SOURCE directory into=
 the
>                           Target directory in the final initramfs.
> @@ -331,7 +331,8 @@ while :; do
>          --fscks)       push fscks_l              "$2"; shift;;
>          --add-fstab)   push add_fstab_l          "$2"; shift;;
>          --mount)       push fstab_lines          "$2"; shift;;
> -        --device)      push host_devs            "$2"; shift;;
> +        --add-device|--device)
> +                       push add_device_l         "$2"; shift;;
>          --kernel-cmdline) push kernel_cmdline_l  "$2"; shift;;
>          --nofscks)     nofscks_l=3D"yes";;
>          --ro-mnt)      ro_mnt_l=3D"yes";;
> @@ -734,6 +735,16 @@ for f in $add_fstab; do
>      done < $f
>  done
> =20
> +if (( ${#add_device_l[@]} )); then
> +    while pop add_device_l val; do
> +        add_device+=3D" $val "
> +    done
> +fi
> +
> +for dev in $add_device; do
> +    push host_devs $dev
> +done
> +
>  if [[ $hostonly ]]; then
>      # in hostonly mode, determine all devices, which have to be access=
ed
>      # and examine them for filesystem types
>=20


merged


--------------ms050204070901050505010006
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Kryptografische Unterschrift

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFPDCC
BTgwggMgoAMCAQICAwn6mjANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0xMTAz
MjMxMTU4MTVaFw0xMzAzMjIxMTU4MTVaMD4xFTATBgNVBAMTDEhhcmFsZCBIb3llcjElMCMG
CSqGSIb3DQEJARYWaGFyYWxkQGhhcmFsZC1ob3llci5kZTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMWJ6ewlyqPdfi2JF6XsM9hxa/l6edcmLEALUs5fblqJxA9ixAoWI+WY
0agbuZgs/iudr69sU9lJIfpXUdLdZoVUn6iWxwRuJmvgihnFpLfojx+l4wDZu5JeJUXbcml4
2wHvykdBfkfTEmUGn09CbPWeG5fAfOq37s9TIyAq4AnVWPaR4ZtIgg/s9ns9DoCAKP1pzgLn
qTu94pfLtl5dB/dpCV9seqe+YtUZqedXhFOtWkq/w2hbFA+mXSbSDts6rZMlQO8+Rzkx1fSc
aMZYBZ3OqRRxk6+oC4Tlv24Yj2lPMV+inTyXllxxqUa9NuXYK9hI+juy4fa3BIbKBCKidCEC
AwEAAaOCAQIwgf8wDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIg
b3duIGNlcnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2Vy
dC5vcmcwQAYDVR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEE
AYI3CgMDBglghkgBhvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8v
b2NzcC5jYWNlcnQub3JnMCEGA1UdEQQaMBiBFmhhcmFsZEBoYXJhbGQtaG95ZXIuZGUwDQYJ
KoZIhvcNAQEFBQADggIBAFZcfmCgsk7743CPH2jmToVyC2hotfjnKsrCyky/b0GH0Ov9Y4TL
+0uGcrq0vZeC/xEKKCmaUF5bAPtYLIJGByV8xVzUUzCypkmh5eyR93OuWnbNpD0VW+u3If5v
m93CXp11bUh1eDk2OOP0irJNmze0GqohW/hjibY6exN183zOc75xD1Horf1j1/JcJocJR0aq
hU4mQRnYqxc2Rhkeyd2vueWDV69pc+orqLinT6O09EpPVo/Yxh6Xq/fM5gTong1Hf2hFVwGu
9KIotNPMauU/IY4Hedxc6uXIZ2UEW2lpmfNh242Z6Bv0/nir4iOtOr8EcowxNYs7yXLBSVh7
X8eYIcUY9qu6SJ0L2tHPIwhK9JjZXD9mg/ko/zI3+wHvJbU/kGsQGCvKTdF44QnRv1YMiQBP
X5M1R1lun+4lJ8XT02Xo0tiDQqbtCsO3nFmZ5DfRBuFK+uZj3JsuwiUPuxFhLE2jZIBxi0yX
JA71+hbbrTJ72dBRJD6Q2SlBzPLMAvvGQTEH23n5QYlCp2WuGujPpR2lD7CdGMjxhwbTPbXy
Ontf2+OqNS5EEu+gJoD3k4wLQNsWjaPD/Oi06I4VkO4VQgo9ddpDgTmEuoa5sOstzrRA+eBZ
8/g/K/LqlLVXvux5KLrmrvNmQO4UHBTOFe3XMRvL2wNrz8Ay8xaO//TIMYIDoTCCA50CAQEw
gYAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3Jn
MSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJz
dXBwb3J0QGNhY2VydC5vcmcCAwn6mjAJBgUrDgMCGgUAoIIB9TAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMzAxMjIxNDM1NTFaMCMGCSqGSIb3DQEJBDEW
BBSJNjZ3kWrKidIp+6IYpNyggylyfTBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAweTEQMA4GA1UE
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAwn6mjCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMHUm9vdCBDQTEe
MBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25p
bmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAwn6mjAN
BgkqhkiG9w0BAQEFAASCAQC/vsVbFwxw8/HeMK4iElAY1cTLH/oJfvG31HYyrVF73t5oqn/f
f+MRRC59siNoAm69K/DuB97909/TKry64FcAof58eu4EaBZkHEWHlS/FAOg2C0si/66zljUC
z9bAlz6VvZvfJd1T179IjOVX1s7VU1NMugL9MNhAHfkNAyh9LG8KEhAuijrM0fIrHVCbFvKY
WAPMWYIPpm8oQvarR+5PvNbBYGP7iARWsGG1roBl07sTSYsz7LEZJl/VC/u5uPIViRyAtHHb
1fByTCu8j2Szwne7fOh1K6oSifMZWwhJPdVR9ETiZ19fINsxOIJtTP91IlRYW5LpFD2d6HWV
vNrSAAAAAAAA
--------------ms050204070901050505010006--
