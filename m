From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Fix autodetection of UNICODE keymap
Date: Thu, 12 Aug 2010 14:28:28 +0200
Message-ID: <4C63E8EC.7040507@redhat.com>
References: <4C63D629.4040204@redhat.com> <E1OjWGr-0004HZ-00.arvidjaar-mail-ru@f169.mail.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1OjWGr-0004HZ-00.arvidjaar-mail-ru-KwwT3n/ykh4edp2WBT/QOw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org

On 08/12/2010 01:48 PM, Andrey Borzenkov wrote:
>
> Thu, 12 Aug 2010 13:08:25 +0200 =D0=C9=D3=D8=CD=CF =CF=D4 Harald Hoye=
r<harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
>
>> On 08/12/2010 01:05 PM, Harald Hoyer wrote:
>>> On 08/11/2010 07:47 PM, Andrey Borzenkov wrote:
>>>> +
>>>> + # KEYTABLE is a bit special - it defines base keymap name and UN=
ICODE
>>>> + # determines whether non-UNICODE or UNICODE version is used
>>>> +
>>>> + if [[ ${KEYTABLE} ]]; then
>>>> + if [[ ${UNICODE} =3D=3D 1 ]]; then
>>>> + [[ ${KEYTABLE} =3D~ .*\.uni.* ]] || KEYTABLE=3D${KEYTABLE%.map*}=
=2Euni
>>>> + fi
>>>> +
>>>> + KEYMAP=3D${KEYTABLE}
>>>> + fi
>>>
>>> On Fedora we would end with:
>>>
>>> KEYTABLE=3D"de-latin1-nodeadkeys"
>>>
>>> at
>>>
>>> KEYMAP=3D"de-latin1-nodeadkeys.uni"
>>>
>>> which does not exist.
>>
>
> Could you send me your /etc/sysconfig/keyboard (or where these are de=
fined)?
>
> So, in other words - you have UTF-8 environment but load non-UNICODE =
keyboard?
>
>> Fedora's console_init calls "loadkeys" with "-u", if its LANG has .U=
TF-8
>
> It does not help here, unfortunately. Which version of initscripts is=
 it?
> --
>

http://git.fedorahosted.org/git/?p=3Dinitscripts.git;a=3Dblob;f=3Dsrc/c=
onsole_init.c

It's been like this forever...

http://git.fedorahosted.org/git/?p=3Dinitscripts.git;a=3Dhistory;f=3Dsr=
c/console_init.c

# loadkeys -u de-latin1-nodeadkeys
Loading /lib/kbd/keymaps/i386/qwertz/de-latin1-nodeadkeys.map.gz
