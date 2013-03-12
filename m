From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] emergency_shell: Use '\W' in $PS1 variable to show current
 working directory.
Date: Tue, 12 Mar 2013 18:01:54 +0800
Message-ID: <513EFD12.5070402@redhat.com>
References: <1363064503-14783-1-git-send-email-chaowang@redhat.com> <513EEB05.9050706@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030603040008010206000509"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <513EEB05.9050706-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------030603040008010206000509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/12/2013 04:44 PM, Harald Hoyer wrote:
> Am 12.03.2013 06:01, schrieb WANG Chao:
>> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  modules.d/98systemd/dracut-emergency.sh | 2 +-
>>  modules.d/99base/dracut-lib.sh          | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/modules.d/98systemd/dracut-emergency.sh b/modules.d/98systemd/dracut-emergency.sh
>> index a0a4b12..af8daf2 100755
>> --- a/modules.d/98systemd/dracut-emergency.sh
>> +++ b/modules.d/98systemd/dracut-emergency.sh
>> @@ -29,7 +29,7 @@ if getargbool 1 rd.shell -d -y rdshell || getarg rd.break -d rdbreak; then
>>      echo
>>      echo
>>      [ -f /etc/profile ] && . /etc/profile
>> -    [ -z "$PS1" ] && export PS1="$_name:\${PWD}# "
>> +    [ -z "$PS1" ] && export PS1="$_name:\W# "
>>      exec sh -i -l
>>  else
>>      warn "$action has failed. To debug this issue add \"rd.shell rd.debug\" to the kernel command line."
>> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
>> index d2c803a..e96411e 100755
>> --- a/modules.d/99base/dracut-lib.sh
>> +++ b/modules.d/99base/dracut-lib.sh
>> @@ -906,7 +906,7 @@ _emergency_shell()
>>      local _name="$1"
>>      if [ -n "$DRACUT_SYSTEMD" ]; then
>>          > /.console_lock
>> -        echo "PS1=\"$_name:\${PWD}# \"" >/etc/profile
>> +        echo "PS1=\"$_name:\W# \"" >/etc/profile
>>          systemctl start dracut-emergency.service
>>          rm -f /etc/profile
>>          rm -f /.console_lock
>> @@ -924,7 +924,7 @@ _emergency_shell()
>>          echo
>>          echo 'Dropping to debug shell.'
>>          echo
>> -        export PS1="$_name:\${PWD}# "
>> +        export PS1="$_name:\W# "
>>          [ -e /.profile ] || >/.profile
>>  
>>          _ctty="$(RD_DEBUG= getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
>>
> 
> \W does not work with dash.
I didn't take dash into consideration :(

> Maybe you want:
> 
> export PS1="[$_name:\${PWD##*/}]# "

I didn't intend to break this long-working-directory convention. But
${PWD##*/} works for me.

The buggy line is:
echo "PS1=\"$_name:\${PWD}# \"" >/etc/profile
In this case, /etc/profile will be PS1="name:${PWD}# ", and ${PWD} will be
interpreted once at the time it being sourced.

It should be,
echo "PS1=\"$_name:\\\${PWD}# \"" >/etc/profile.

Patch is attached. Thanks!

WANG Chao




--------------030603040008010206000509
Content-Type: text/x-patch;
 name="0001-_emergency_shell-don-t-let-PWD-being-interpreted-whe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-_emergency_shell-don-t-let-PWD-being-interpreted-whe.pa";
 filename*1="tch"

From cfbd73c9f527a4845459cc995985ee87ff510156 Mon Sep 17 00:00:00 2001
From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Tue, 12 Mar 2013 17:52:31 +0800
Subject: [PATCH] _emergency_shell: don't let $PWD being interpreted when
 export $PS1

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index d2c803a..954de2e 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -906,7 +906,7 @@ _emergency_shell()
     local _name="$1"
     if [ -n "$DRACUT_SYSTEMD" ]; then
         > /.console_lock
-        echo "PS1=\"$_name:\${PWD}# \"" >/etc/profile
+        echo "PS1=\"$_name:\\\${PWD}# \"" >/etc/profile
         systemctl start dracut-emergency.service
         rm -f /etc/profile
         rm -f /.console_lock
-- 
1.8.1.4


--------------030603040008010206000509--
