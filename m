From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Bug in dracut-functions.sh@225(print_vars)
Date: Tue, 20 May 2014 13:28:03 +0200
Message-ID: <537B3C43.7040103@redhat.com>
References: <201404061338.54350.skoeln@physnet.uni-hamburg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201404061338.54350.skoeln-4JCb7EXykGJ5qnkD1ooD3mPhZIeI7moD@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?ISO-8859-1?Q?Sebastian_K=F6ln?= <skoeln-4JCb7EXykGJ5qnkD1ooD3mPhZIeI7moD@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06.04.2014 13:38, Sebastian K=F6ln wrote:
> Hello,
>=20
> I stubled upon the following bug (dracut --verbose output):
>=20
>> ...
>> //usr/lib/dracut/modules.d/10i18n/module-setup.sh@132(install_local_=
i18n):=20
> EXT_KEYMAPS=3D'backspace keypad euro2'
>> ...
>> /usr/lib/dracut/dracut-functions.sh@224(print_vars): eval printf -v =
_value=20
> %s '$EXT_KEYMAPS'
>> //usr/lib/dracut/dracut-functions.sh@224(print_vars): printf -v _val=
ue %s=20
> backspace keypad euro2
>> /usr/lib/dracut/dracut-functions.sh@225(print_vars): [[ -n=20
> backspacekeypadeuro2 ]]
>> /usr/lib/dracut/dracut-functions.sh@225(print_vars): printf '%s=3D\"=
%s\"\n'=20
> EXT_KEYMAPS backspacekeypadeuro2
>=20
> the "eval" line of print_vars
> needs to re replaced by
>> eval printf -v _value "%s" \""\$$_var"\"
>=20
> the modified function is then:
>=20
>> # Function prints global variables in format name=3Dvalue line by li=
ne.
>> # $@ =3D list of global variables' name
>> print_vars() {
>>     local _var _value
>>
>>     for _var in "$@"
>>     do
>>         eval printf -v _value "%s" \""\$$_var"\"
>>         [[ ${_value} ]] && printf '%s=3D"%s"\n' "$_var" "$_value"
>>     done
>> }
>=20
> this produces the correct result.


Thanks!

http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=3D7a94a432=
6f0641396125acb2b444b562224457a1
