From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut options for installing files and drivers
Date: Mon, 14 May 2012 06:10:26 +0000 (UTC)
Message-ID: <joq7ki$u50$2@dough.gmane.org>
References: <4FAA1E44.2090006@redhat.com> <4FAA65B7.9040209@redhat.com>
 <4FAB2379.2050504@redhat.com> <4FAB7A26.4060409@redhat.com>
 <joq73o$u50$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 14 May 2012 at 06:01 GMT, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, 10 May 2012 at 08:19 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> On 05/10/2012 10:10 AM, Dave Young wrote:
>>
>>> On 05/09/2012 08:40 PM, Harald Hoyer wrote:
>>> 
>>>> Am 09.05.2012 09:35, schrieb Dave Young:
>>>>> Hi, harald
>>>>>
>>>>> Dracut options '-I' and '-a' both mean optionally install file/ko
>>>>
>>>> this is wrong
>>>>
>>>> $ man dracut
>>>>
>>>> "-a" means
>>>>
>>>>        -a, --add <list of dracut modules>
>>> 
>>> 
>>> modules install happens in modules.d/90kernel-modules/module-setup.sh
>>> but module-setup.sh does not check the return value of instmods, so it
>>> will not fail and exit if no such modules.
>>
>>
>> Oops, I actually means --add-drivers instead of -a
>>
>
> Yeah...
>
> % sudo dracut --add-drivers "no-such-module" -I "/no/such/file" -f test.img
> E: ssh interactive mode need option --ctty!
> F: Failed to install /no/such/file
> % echo $?
> 1
>
> Maybe the following untested patch could fix this??
>

A better version:

---->

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 8256e02..148dd19 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -1168,11 +1168,17 @@ instmods() {
         local _ret=0 _mod _mpargs
         if (($# == 0)); then  # filenames from stdin
             while read _mod; do
-                inst1mod "${_mod%.ko*}"
+                inst1mod "${_mod%.ko*}" || {
+                    dfatal "Failed to install ${_mod%.ko*}"
+                    return 1
+                }
             done
         fi
         while (($# > 0)); do  # filenames as arguments
-            inst1mod ${1%.ko*}
+            inst1mod ${1%.ko*} || {
+                dfatal "Failed to install ${1%.ko*}"
+                return 1
+            }
             shift
         done
         return $_ret
