From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut options for installing files and drivers
Date: Mon, 14 May 2012 06:01:28 +0000 (UTC)
Message-ID: <joq73o$u50$1@dough.gmane.org>
References: <4FAA1E44.2090006@redhat.com> <4FAA65B7.9040209@redhat.com>
 <4FAB2379.2050504@redhat.com> <4FAB7A26.4060409@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 10 May 2012 at 08:19 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 05/10/2012 10:10 AM, Dave Young wrote:
>
>> On 05/09/2012 08:40 PM, Harald Hoyer wrote:
>> 
>>> Am 09.05.2012 09:35, schrieb Dave Young:
>>>> Hi, harald
>>>>
>>>> Dracut options '-I' and '-a' both mean optionally install file/ko
>>>
>>> this is wrong
>>>
>>> $ man dracut
>>>
>>> "-a" means
>>>
>>>        -a, --add <list of dracut modules>
>> 
>> 
>> modules install happens in modules.d/90kernel-modules/module-setup.sh
>> but module-setup.sh does not check the return value of instmods, so it
>> will not fail and exit if no such modules.
>
>
> Oops, I actually means --add-drivers instead of -a
>

Yeah...

% sudo dracut --add-drivers "no-such-module" -I "/no/such/file" -f test.img
E: ssh interactive mode need option --ctty!
F: Failed to install /no/such/file
% echo $?
1

Maybe the following untested patch could fix this??

---
diff --git a/modules.d/90kernel-modules/module-setup.sh
b/modules.d/90kernel-modules/module-setup.sh
index 26f4784..838088a 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -58,8 +58,18 @@ installkernel() {
         hostonly='' instmods $drivers
      fi
	       
       -    [[ $add_drivers ]] && hostonly='' instmods $add_drivers
       -    [[ $filesystems ]] && hostonly='' instmods $filesystems
       +    if [[ $add_drivers ]]; then
       +        hostonly='' instmods $add_drivers || {
       +            dfatal "Failed to install $add_drivers"
       +            return 1
       +       }
       +    fi
       +    if [[ $filesystems ]]; then
       +        hostonly='' instmods $filesystems || {
       +            dfatal "Failed to install $filesystems"
       +            return 1
       +       }
       +    fi
        
	     # force install of scsi_wait_scan
          hostonly='' instmods scsi_wait_scan
			  
