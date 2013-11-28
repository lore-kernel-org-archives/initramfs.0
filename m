From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 03/10] 95dasd_mod: make dasd_cio_free optional
Date: Thu, 28 Nov 2013 13:53:14 +0100
Message-ID: <52973CBA.4080006@suse.de>
References: <1385567061-13247-1-git-send-email-hare@suse.de> <1385567061-13247-4-git-send-email-hare@suse.de> <52973C68.8040504@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52973C68.8040504-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/28/2013 01:51 PM, Harald Hoyer wrote:
> On 11/27/2013 04:44 PM, Hannes Reinecke wrote:
>> dasd_cio_free is a RedHat-specific tool, so make it optional.
>>
>> Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
>> ---
>>  dracut-functions.sh                    | 9 +++++++++
>>  modules.d/95dasd_mod/module-setup.sh   | 3 ++-
>>  modules.d/95dasd_mod/parse-dasd-mod.sh | 4 +++-
>>  3 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/dracut-functions.sh b/dracut-functions.sh
>> index 2872516..c2cf67a 100755
>> --- a/dracut-functions.sh
>> +++ b/dracut-functions.sh
>> @@ -741,6 +741,15 @@ inst_multiple() {
>>      return $ret
>>  }
>> =20
>> +inst_multiple_optional() {
>> +    local ret
>> +        #dinfo "initdir=3D$initdir $DRACUT_INSTALL -l $@"
>> +    $DRACUT_INSTALL ${initdir:+-D "$initdir"} -o -a ${DRACUT_RESOLV=
E_DEPS:+-l}  ${DRACUT_FIPS_MODE:+-H} "$@"
>> +    ret=3D$?
>> +    (($ret !=3D 0)) && derror $DRACUT_INSTALL ${initdir:+-D "$initd=
ir"} -o -a ${DRACUT_RESOLVE_DEPS:+-l}  ${DRACUT_FIPS_MODE:+-H} "$@" || =
:
>> +    return $ret
>> +}
>> +
>=20
>=20
> Why so complicated and not use "inst_multiple -o" ??
> Or, if you prefer inst_multiple_optional, replace all other occurence=
s of
> "inst_multiple -o" with inst_multiple_optional also.
>=20
Ah. Okay, will be doing it.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
