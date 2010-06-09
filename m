From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] Support old version of module-init-tools
Date: Wed, 9 Jun 2010 05:55:47 -0500
Message-ID: <AANLkTinJLcfbsNFjpHMJK6fqrokcTzQ0aY8gPkROHwOI@mail.gmail.com>
References: <20100609103605.50a6acec@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+NGEUH5WHaFEzZcHU7b/YhGmUWFCzFNJVt7wXdZ7rMo=;
        b=gx04Vj8DqgfkB2R/hk0/Zxt6oQ2FA3NhHAhhK99x8rb8kmlo7qg+6z3j4UTxVE/+0e
         YaFQLjICs6dmZJfYQEVAIbCUOVd2t5M0r0D252Uk7LiCvtq36pEUyQLWNvy/6o3uyexn
         MgpclFIu8hN7lSZjnY0mUVBFr8MH9VoW347fI=
In-Reply-To: <20100609103605.50a6acec-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2010/6/9 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> modprobe included in version prior to 3.7 of module-init-tools doesn'=
t
> have -d | --dirname option which allows to give a prefix other than
> '/' for kernel modules path. Dracut assumes existence of that
> option and uses it even with default '/'. The patch passes -d option
> only if it's different from default and also checks module-init-tools
> version if user changes the prefix by --kmoddir Dracut option.
> ---
> =C2=A0dracut =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A08 ++++=
+++-
> =C2=A0dracut-functions | =C2=A0 44 ++++++++++++++++++++++++++++++++++=
++++++++--
> =C2=A02 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/dracut b/dracut
> index 35be7eb..139d0e0 100755
> --- a/dracut
> +++ b/dracut
> @@ -183,7 +183,13 @@ esac
> =C2=A0abs_outfile=3D$(readlink -f "$outfile") && outfile=3D"$abs_outf=
ile"
>
> =C2=A0srcmods=3D"/lib/modules/$kernel/"
> -[[ $drivers_dir ]] && srcmods=3D"$drivers_dir"
> +[[ $drivers_dir ]] && {
> + =C2=A0 =C2=A0if verlt $(modprobe --version | cut -d' ' -f3) 3.7; th=
en
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0derror 'To use --kmoddir option module-i=
nit-tools >=3D 3.7 is required.'
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1
> + =C2=A0 =C2=A0fi
> + =C2=A0 =C2=A0srcmods=3D"$drivers_dir"
> +}
> =C2=A0export srcmods
>
> =C2=A0if [[ -f $outfile && ! $force ]]; then
> diff --git a/dracut-functions b/dracut-functions
> index a76cc22..fbac282 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -24,6 +24,39 @@ IF_dynamic=3D""
> =C2=A0# Generic substring function. =C2=A0If $2 is in $1, return 0.
> =C2=A0strstr() { [[ $1 =3D~ $2 ]]; }
>
> +# Version comparision function. =C2=A0Returns result similar to C st=
rcmp,
> +# but instead of -1 is 2. =C2=A0Function assumes version scheme like=
 does
> +# Linux kernel.
> +vercmp() {
> + =C2=A0 =C2=A0local n1 n2 i=3D1
> +
> + =C2=A0 =C2=A0while true
> + =C2=A0 =C2=A0do
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0n1=3D$(echo $1 | cut -d'.' -f$i)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0n2=3D$(echo $2 | cut -d'.' -f$i)

Ugh, no.

We are using bash, no need for that sort of hackery.
Just split the passed version strings into arrays using parameter
expansion, like so:

n1=3D(${1//./ })
n2=3D(${2//./ })

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0[[ ! $n1 && ! $n2 ]] && return 0
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0[[ $n1 -lt $n2 ]] && return 2
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0[[ $n1 -gt $n2 ]] && return 1
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0((i++))
> + =C2=A0 =C2=A0done

and then do the whole thing in an arithmetic for loop:

for ((i=3D0; ;i++)); do
    [[ ${n1[i]} && ! ${n2[i]} ]] && return 1
    [[ ! ${n1[i]} && ${n2[i]} ]] && return 2
    [[ ${n1[i]} && ${n2[i]} || return 0
    ((${n1[i]} > ${n2[i]})) && return 1
    ((${n1[i]} < ${n2[i]})) && return 2
done


> +}
> +
> +# Variation of version comparision function. =C2=A0If $1 >=3D $2, re=
turn 0.
> +verge() {
> + =C2=A0 =C2=A0vercmp $1 $2
> +
> + =C2=A0 =C2=A0[[ $? =3D 0 || $? =3D 1 ]]
> +}
> +
> +# Variation of version comparision function. =C2=A0If $1 < $2, retur=
n 0.
> +verlt() {
> + =C2=A0 =C2=A0vercmp $1 $2
> +
> + =C2=A0 =C2=A0[[ $? =3D 2 ]]
> +}
> +
> =C2=A0# Log initrd creation.
> =C2=A0if ! [[ $dracutlogfile ]]; then
> =C2=A0 =C2=A0 [[ $dracutbasedir =3D /usr/share/dracut ]] && \
> @@ -487,7 +520,7 @@ filter_kernel_modules () (
> =C2=A0# install kernel modules along with all their dependencies.
> =C2=A0instmods() {
> =C2=A0 =C2=A0 [[ $no_kernel =3D yes ]] && return
> - =C2=A0 =C2=A0local mod mpargs modpath modname cmd
> + =C2=A0 =C2=A0local mod mpargs modpath modname cmd moddirname
> =C2=A0 =C2=A0 while (($# > 0)); do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mod=3D${1%.ko*}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case $mod in
> @@ -519,10 +552,17 @@ instmods() {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0! echo $add_dr=
ivers | grep -qe "\<${mod}\>" && =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
shift; continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # We use '-d' opti=
on in modprobe only if modules prefix path
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # differs from def=
ault '/'. =C2=A0This allows us to use Dracut with
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # old version of m=
odprobe which doesn't have '-d' option.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 moddirname=3D${src=
mods%%/lib/modules/*}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[ -n ${moddirname=
} ]] && moddirname=3D"-d ${moddirname}/"
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# ok, load the=
 module, all its dependencies, and any firmware
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# it may requi=
re
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_kmod_=
dep install_kmod_with_fw $mod \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --se=
t-version $kernel -d ${srcmods%%/lib/modules/*}/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --se=
t-version $kernel ${moddirname}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> =C2=A0 =C2=A0 =C2=A0 =C2=A0shift
> --
> 1.7.1
>
