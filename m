From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut, degraded md arrays, resume and systemd.
Date: Mon, 16 Mar 2015 09:45:58 +0100
Message-ID: <55069846.9060309@redhat.com>
References: <20150311112845.01dd3269@notabene.brown> <20150312184115.34f40a09@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150312184115.34f40a09-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12.03.2015 08:41, NeilBrown wrote:
> On Wed, 11 Mar 2015 11:28:45 +1100 NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org> wrote:
> 
> 
>> BTW, I also have a problem in a similar config where the md/raid RAID1
>> is encrypted.  Systemd gives up waiting for the encrypted device after
>> 90 seconds: [   92.250437] linux systemd[1]: Dependency failed for
>> Cryptography Setup for cr_md1.
>> 
>> but mdraid_start doesn't get run until 120 seconds have elapsed. I
>> haven't looked into setup of encrypted devices yet, but if anyone has 
>> suggestions, I'm very interested :-)
> 
> I've looked into this problem some more.
> 
> The main problem is that generator_wait_for_dev in rootfs-generator.sh 
> doesn't always do the same thing.
> 
> When you "systemctl daemon-reload", systemd will remove all of
> /run/systemd/generator and then re-run all the generators.
> 
> generator_wait_for_dev will only create files in /run/systemd/generator
> if the .../initqueue/finished/devexists.... file doesn't exist. So the
> first time, this file is created and so are the generator files. 
> Subsequent times, nothing is created, so the /run/systemd/generator files
> are not recreated.
> 
> This means that the timeout set by timeout.conf is ignored, and the
> default timeout is used instead. The default timeout is 90 second.  The
> rd.retry timeout, which determines when the md array will be assembled, is
> 120 seconds.  So systemd times out first.
> 
> If I apply this patch:
> 
> diff --git a/modules.d/98systemd/rootfs-generator.sh
> b/modules.d/98systemd/rootfs-generator.sh index f3c7d1f237df..97512c07ab06
> 100755 --- a/modules.d/98systemd/rootfs-generator.sh +++
> b/modules.d/98systemd/rootfs-generator.sh @@ -11,14 +11,15 @@
> generator_wait_for_dev() _timeout=$(getarg rd.timeout) 
> _timeout=${_timeout:-0}
> 
> -    [ -e "$hookdir/initqueue/finished/devexists-${_name}.sh" ] && return
> 0 +    if ! [ -e "$hookdir/initqueue/finished/devexists-${_name}.sh" ];
> then
> 
> -    printf '[ -e "%s" ]\n' $1 \ -        >>
> "$hookdir/initqueue/finished/devexists-${_name}.sh" -    { -        printf
> '[ -e "%s" ] || ' $1 -        printf 'warn "\"%s\" does not exist"\n' $1 -
> } >> "$hookdir/emergency/80-${_name}.sh" +        printf '[ -e "%s" ]\n'
> $1 \ +            >> "$hookdir/initqueue/finished/devexists-${_name}.sh" +
> { +            printf '[ -e "%s" ] || ' $1 +            printf 'warn
> "\"%s\" does not exist"\n' $1 +        } >>
> "$hookdir/emergency/80-${_name}.sh" +    fi
> 
> _name=$(dev_unit_name "$1") if ! [ -L
> /run/systemd/generator/initrd.target.wants/${_name}.device ]; then
> 
> 
> Then it does the right thing ... mostly.
> 
> I get a successful boot, but there are warning messages about a timeout
> waiting for dev-md-2.device.   This doesn't seem to be fatal, but it would
> be good to get rid of it.
> 
> systemd knows about this device because the cryptsetup generator tells
> it. So it seems to make sense to tell systemd that all devices in
> /etc/crypttab should have the correct timeout.  We cannot simply use
> "wait_for_dev", as we don't want to wait for the device necessarily, but
> we want to be sure that systemd doesn't complain about it.
> 
> So I have split "set_systemd_timeout_for_dev" out of "wait_for_dev", and
> then called it on all crypttab devices, as shown in these patches:
> 
> diff --git a/modules.d/90crypt/parse-crypt.sh
> b/modules.d/90crypt/parse-crypt.sh index 94ad1f63ae6f..5a64652cc51c
> 100755 --- a/modules.d/90crypt/parse-crypt.sh +++
> b/modules.d/90crypt/parse-crypt.sh @@ -14,6 +14,10 @@ else LUKS=$(getargs
> rd.luks.uuid -d rd_LUKS_UUID) tout=$(getarg rd.luks.key.tout)
> 
> +    while read _dev _uuid ; do +        set_systemd_timeout_for_dev
> $_dev +    done + if [ -n "$LUKS" ]; then for luksid in $LUKS; do
> 
> diff --git a/modules.d/99base/dracut-lib.sh
> b/modules.d/99base/dracut-lib.sh index 079c9a21ecad..15e6b992b114 100755 
> --- a/modules.d/99base/dracut-lib.sh +++ b/modules.d/99base/dracut-lib.sh 
> @@ -892,12 +892,10 @@ dev_unit_name() printf -- "%s" "$dev" }
> 
> -# wait_for_dev <dev> -# -# Installs a initqueue-finished script, -# which
> will cause the main loop only to exit, -# if the device <dev> is
> recognized by the system. -wait_for_dev() +# set_systemd_timeout_for_dev
> <dev> +# Set 'rd.timeout' as the systemd timeout for <dev> + 
> +set_systemd_timeout_for_dev() { local _name local _needreload @@ -912,19
> +910,6 @@ wait_for_dev() _timeout=$(getarg rd.timeout) 
> _timeout=${_timeout:-0}
> 
> -    _name="$(str_replace "$1" '/' '\x2f')" - -    type mark_hostonly
> >/dev/null 2>&1 && mark_hostonly
> "$hookdir/initqueue/finished/devexists-${_name}.sh" - -    [ -e
> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" ] && return
> 0 - -    printf '[ -e "%s" ]\n' $1 \ -        >>
> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" -    { -
> printf '[ -e "%s" ] || ' $1 -        printf 'warn "\"%s\" does not
> exist"\n' $1 -    } >> "${PREFIX}$hookdir/emergency/80-${_name}.sh" - if [
> -n "$DRACUT_SYSTEMD" ]; then _name=$(dev_unit_name "$1") if ! [ -L
> ${PREFIX}/etc/systemd/system/initrd.target.wants/${_name}.device ]; then 
> @@ -949,6 +934,36 @@ wait_for_dev() fi fi } +# wait_for_dev <dev> +# +#
> Installs a initqueue-finished script, +# which will cause the main loop
> only to exit, +# if the device <dev> is recognized by the system. 
> +wait_for_dev() +{ +    local _name +    local _noreload + +    if [ "$1"
> = "-n" ]; then +        _noreload=-n +        shift +    fi + +
> _name="$(str_replace "$1" '/' '\x2f')" + +    type mark_hostonly
> >/dev/null 2>&1 && mark_hostonly
> "$hookdir/initqueue/finished/devexists-${_name}.sh" + +    [ -e
> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" ] && return
> 0 + +    printf '[ -e "%s" ]\n' $1 \ +        >>
> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" +    { +
> printf '[ -e "%s" ] || ' $1 +        printf 'warn "\"%s\" does not
> exist"\n' $1 +    } >> "${PREFIX}$hookdir/emergency/80-${_name}.sh" + +
> set_systemd_timeout_for_dev $_noreload $1 +}
> 
> cancel_wait_for_dev() {
> 
> 
> and that seems do do what I want.
> 
> Is this an appropriate fix? If you like I can send them as properly
> formatted patches.
> 
> Thanks, NeilBrown
> 

Thanks for your debugging time. If you don't mind, I would like to have those
properly formatted patches :)

Thanks again!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBphFAAoJEANOs3ABTfJwHRUP/i9xuwxNS4/KZy9Ky1kHY4VR
ERl3VCBxG3hdyP1HrspSgsNzckS30TZKTFzZqQBN3F7ncWZFDhJ9SxSLrL9p2Ih6
kWeUg8FH+VkNRIa9F/XbnXStlKHt2YMwENmC7vt6JgwWw9eh7EQeEu8+2S4UpCB1
IKezrx/7m7vjBcqgL4wEQiJvC/a7sMrynAwz8n+V61yN8u8Dw7crQGznBC1DyiYA
SrNK21r0ET9rDVeqxgU14hUwr1YNk/B45W8ePXRxdMWwHZyCgxLkM1RApYndu8mD
QGeEM/QN4aDDN/gdF275+uznHRaqMRs88wb2ElqM5KMzWAFPTmEE+QLyYAZMaVlQ
w6KqsFT1MQWWSJgETJrDDIsarLbg7G1RODdqsD8g5JewIDab1hMsRmR+PwJMwD8R
7USsa3Knr0bVfcKqc0oEBUpuB/xLZlZpaqJOfLIv2bPB1AuyoRozE7jEztP311zq
0s+GXeL0JY4gLVnXiUQmFZ7TDA9ouUAO+DmjoACZxFhffkiZURLDi54Pwv5sHZ1y
1P6kw9InUjZIbxsbscvhManBo4huZb7JbUoB7r1f7ayzF3sRZIKZraXlN0uXk66Y
PUTk3Cs7L6GacNkDB25oIIrCd5kzYNk+Ts11m0Djr7gxQSeGPf8J6TN3Hxsa83GJ
U8wkyAH/8wWr6iZWjss6
=xd5L
-----END PGP SIGNATURE-----
