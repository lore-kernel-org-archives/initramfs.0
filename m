From: minfei <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 40network: Copy the customize dhcp config
Date: Mon, 15 Sep 2014 09:59:47 +0800
Message-ID: <A76B1C96-974B-4A3D-BAE5-CBD231FB35DC@redhat.com>
References: <1410499671-31253-1-git-send-email-mhuang@redhat.com> <20140912133530.GB32421@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140912133530.GB32421-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


On Sep 12, 2014, at 21:35, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Fri, Sep 12, 2014 at 01:27:51PM +0800, Minfei Huang wrote:
>> It is not available to valid the following customize dhcp config
>> /etc/dhclient.conf in the initram environment.
>>=20
>> supersede domain-name "machine.test.group";
>> supersede domain-name-servers 10.125.97.171, 10.126.98.43, 10.125.97=
=2E176;
>>=20
>> The dracut doesnot acquire the customize dhcp config from
>> /etc/dhclient.conf file when construct the initram image.
>>=20
>> Copy the customize config to make the config availably in the
>> initram environment by dhcp.
>>=20
>> Signed-off-by: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>=20
> Can you give more information about the problem here. Why only look
> for "supercede" options only. What about rest of the options in
> dhclient.conf?
>=20
> Thanks
> Vivek

Maybe the supercede is the frequently options which is customised.  But=
 I think
I should not ignore the customised dhcp configuration /etc/dhclient.con=
f instead of
using the default dhcp configuration in dracut source directory.

Of course it will be fine to append all of the configuration customised=
 dhclient.conf
to the default configuration by constructing the initram image.=20

>=20
>> ---
>> modules.d/40network/module-setup.sh | 11 ++++++++++-
>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/modules.d/40network/module-setup.sh b/modules.d/40netwo=
rk/module-setup.sh
>> index ae1f43f..76761f5 100755
>> --- a/modules.d/40network/module-setup.sh
>> +++ b/modules.d/40network/module-setup.sh
>> @@ -67,6 +67,15 @@ installkernel() {
>>         ecb arc4 bridge stp llc ipv6 bonding 8021q af_packet virtio_=
net
>> }
>>=20
>> +setup_custom_dhclient() {
>> +    _dhclient_file=3D"/etc/dhclient.conf"
>> +
>> +    inst_simple "$moddir/dhclient.conf" "/etc/dhclient.conf"
>> +
>> +    [ ! -e $_dhclient_file ] && return
>> +    cat $_dhclient_file | grep ^supersede >> ${initdir}/$_dhclient_=
file
>> +}
>> +
>> # called by dracut
>> install() {
>>     local _arch _i _dir
>> @@ -79,7 +88,7 @@ install() {
>>     inst_script "$moddir/netroot.sh" "/sbin/netroot"
>>     inst_script "$moddir/dhclient-script.sh" "/sbin/dhclient-script"
>>     inst_simple "$moddir/net-lib.sh" "/lib/net-lib.sh"
>> -    inst_simple "$moddir/dhclient.conf" "/etc/dhclient.conf"
>> +    setup_custom_dhclient
>>     inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
>>     inst_hook pre-udev 60 "$moddir/net-genrules.sh"
>>     inst_hook cmdline 91 "$moddir/dhcp-root.sh"
>> --=20
>> 1.8.3.1
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

=97=20
Minfei
