From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 98syslog: try to dynamically check for rsyslog moddir
Date: Fri, 10 Sep 2010 16:39:32 +0200
Message-ID: <4C8A4324.3000707@redhat.com>
References: <E1Ou4kw-0005pA-00.arvidjaar-mail-ru@smtp11.mail.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1Ou4kw-0005pA-00.arvidjaar-mail-ru-eJLJSXF0gEtsdVUOrk1QfQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: =?ISO-8859-2?Q?Tomasz_Pawe=B3_Gajc?= <phenomenal-5tc4TXWwyLM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rsyslog-4gKAAF5ltrKNkp5+ER1W/AC/G2K4zDHf@public.gmane.org, tpg-4qZELD6Fgxhg9hUCZPvPmw@public.gmane.org

On 09/10/2010 04:33 PM, Andrey Borzenkov wrote:
> On Friday 10 of September 2010 15:48:22 Harald Hoyer wrote:
>> On 09/08/2010 06:48 PM, Tomasz Pawe=B3 Gajc wrote:
>>> Dnia 2010-09-08, o godz. 18:52:13
>>>
>>> Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>   napisa=B3(a):
>>>> Thomas pointed out that default module path may not be correct
>>>> (Mandriva installs modules under architecture dependent path).
>>>> Unfortunately rsyslog does not seem to offer any way to query
>>>> for
>>>> default configuration values. Here is rather hack - try to load
>>>> non-existing module and fetch path from error message.
>>>>
>>>> Example of error message from version 4.6.4:
>>>>
>>>> rsyslogd: could not load module
>>>> '/lib64/rsyslog/_No_sUcH_MOduLe.so', dlopen:
>>>> /lib64/rsyslog/_No_sUcH_MOduLe.so: cannot open shared object
>>>> file: No such file or directory
>>>>
>>>> Signed-off-by: Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>
>>>>
>>>> ---
>>>>
>>>>    modules.d/98syslog/install |   17 ++++++++++++++++-
>>>>    1 files changed, 16 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/modules.d/98syslog/install
>>>> b/modules.d/98syslog/install index 1fd1b6f..e3d02bf 100755
>>>> --- a/modules.d/98syslog/install
>>>> +++ b/modules.d/98syslog/install
>>>> @@ -1,6 +1,21 @@
>>>>
>>>>    #!/bin/sh
>>>>    if type -P rsyslogd>/dev/null; then
>>>>
>>>> -
>>>> installs=3D"rsyslogd /lib/rsyslog/lmnet.so /lib/rsyslog/imklog.so
>>>> /lib/rsyslog/imuxsock.so" +	# module path can be changed during
>>>> build and currently rsyslog
>>>> +	# does not provide any means to query for it. Use hack - try
>>>> to
>>>> +	# load non-existent module and look at error message
>>>> +	R_CONF=3D/tmp/dracut.rsyslog.conf.$$
>>>> +	R_ERR=3D/tmp/dracut.rsyslog.err.$$
>>>> +	R_MODDIR=3D
>>>> +	echo '$ModLoad _No_sUcH_MOduLe'>   $R_CONF
>>>> +	if [ -s $R_CONF ]; then
>>>> +		rsyslogd -N 1 -f $R_CONF 2>   $R_ERR>   /dev/null
>>>> +		R_MODDIR=3D$(grep ' could not load
>>>> module .*_No_sUcH_MOduLe' $R_ERR)
>>>> +		R_MODDIR=3D${R_MODDIR#*could not load module \'}
>>>> +		R_MODDIR=3D${R_MODDIR%\', *}
>>>> +		R_MODDIR=3D${R_MODDIR%/*}
>>>> +	fi
>>>> +	[ -n "$R_MODDIR" ] || R_MODDIR=3D/lib/rsyslog
>>>> +	installs=3D"rsyslogd $R_MODDIR/lmnet.so $R_MODDIR/imklog.so
>>>> $R_MODDIR/imuxsock.so" elif type -P syslogd>/dev/null; then
>>>>
>>>>        installs=3D"syslogd"
>>>>
>>>>    elif type -P syslog-ng>/dev/null; then
>>>
>>> Indeed this patch is more precise than my simplified one ;)
>>
>> ugly hack :-/ plus you want mktemp to prevent attacks..
>
> Just to make sure - it was NAK? :)

NAK without mktemp... with mktemp, I am willing to accept the hackiness=
 for the=20
sake of portability :)
