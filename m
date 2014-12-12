From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 31/42] 95fcoe: Store current configuration in dracut cmdline
Date: Fri, 12 Dec 2014 15:05:55 +0100
Message-ID: <548AF643.2070401@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de> <1418309193-11208-32-git-send-email-trenn@suse.de> <20141212030201.GD1678@dhcp-16-116.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141212030201.GD1678-je1gSBvt1Tcx0jIIkfS+Ph/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/12/2014 04:02 AM, Baoquan He wrote:
> On 12/11/14 at 03:46pm, Thomas Renninger wrote:
>> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
>>
>> When running with --hostonly-cmdline we should be storing
>> the current configuration in /etc/cmdline.d so that dracut
>> will be configure the system automatically.
>>
>> References: bnc#877288
>>
>> Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
>> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
>> ---
>>  modules.d/95fcoe/module-setup.sh | 52 +++++++++++++++++++++++++++++=
+++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/modules.d/95fcoe/module-setup.sh b/modules.d/95fcoe/mod=
ule-setup.sh
>> index b67aa04..174745a 100755
>> --- a/modules.d/95fcoe/module-setup.sh
>> +++ b/modules.d/95fcoe/module-setup.sh
>> @@ -2,7 +2,16 @@
>> =20
>>  # called by dracut
>>  check() {
>> +    [[ $hostonly ]] || [[ $mount_needs ]] && {
>> +        for c in /sys/bus/fcoe/devices/ctlr_* ; do
>> +            [ -L $c ] || continue
>> +            fcoe_ctlr=3D$c
>> +        done
>> +        [ -z "$fcoe_ctlr" ] && return 255
>> +    }
>> +
>>      require_binaries dcbtool fipvlan lldpad ip readlink || return 1
>> +
>>      return 0
>>  }
>> =20
>> @@ -17,12 +26,55 @@ installkernel() {
>>      instmods fcoe 8021q edd
>>  }
>> =20
>> +get_vlan_parent() {
>> +    local link=3D$1
>> +
>> +    [ -d $link ] || return
>> +    read iflink < $link/iflink
>> +    for if in /sys/class/net/* ; do
>> +	read idx < $if/ifindex
>> +	if [ $idx -eq $iflink ] ; then
>> +	    echo ${if##*/}
>> +	fi
>> +    done
>> +}
>> +
>> +# called by dracut
>> +cmdline() {
>> +
>> +    for c in /sys/bus/fcoe/devices/ctlr_* ; do
>> +        [ -L $c ] || continue
>> +        read enabled < $c/enabled
>> +        [ $enabled -eq 0 ] && continue
>> +        d=3D$(cd -P $c; echo $PWD)
>> +        i=3D${d%/*}
>> +        read mac < ${i}/address
>> +        s=3D$(dcbtool gc ${i##*/} dcb | sed -n 's/^DCB State:\t*\(.=
*\)/\1/p')
>> +        if [ -z "$s" ] ; then
>> +	    p=3D$(get_vlan_parent ${i})
>> +	    if [ "$p" ] ; then
>> +	        s=3D$(dcbtool gc ${p} dcb | sed -n 's/^DCB State:\t*\(.*\)=
/\1/p')
>> +	    fi
>> +        fi
>> +        if [ "$s" =3D "on" ] ; then
>> +	    dcb=3D"dcb"
>> +        else
>> +	    dcb=3D"nodcb"
>> +        fi
>> +        echo "fcoe=3D${mac}:${dcb}"
>> +    done
>> +}
>=20
> Hi Thomas,
>=20
> Why do you need to do this? Usually a module should do the work based=
 on
> its functionality. According to your change, how does a user specify =
NIC
> or vlan they only want to bring up?
>=20
You don't. The current code checking for DCBx capabilities, and sets
a default for that.
The FCoE mac address is basically fixed (derived from the network
MAC address), and the VLAN is given by the DCBx information.
If DCB is not running there's a fair chance you're FCoE connection
won't run reliably, neither.
(Intel claims it FCoE would run without DCB in a Peer-to-Peer
connection, but I've never seen that in real life).

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 21284 (AG N=FCrnberg)
