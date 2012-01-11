From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] remove the global --sshkey parameter
Date: Wed, 11 Jan 2012 11:40:25 +0800
Message-ID: <4F0D04A9.4010406@redhat.com>
References: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com> <1326208786-24344-2-git-send-email-xiyou.wangcong@gmail.com> <4F0CFB08.6030800@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F0CFB08.6030800-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 01/11/2012 10:59 AM, Dave Young wrote:

> On 01/10/2012 11:19 PM, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> 
>> From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  dracut       |    4 +---
>>  dracut.8.xml |    8 --------
>>  2 files changed, 1 insertions(+), 11 deletions(-)
>>
>> diff --git a/dracut b/dracut
>> index f3fa257..58c4fde 100755
>> --- a/dracut
>> +++ b/dracut
>> @@ -118,7 +118,6 @@ Creates initial ramdisk images for preloading modules
>>    -M, --show-modules    Print included module's name to standard output during
>>                           build.
>>    --keep                Keep the temporary initramfs for debugging purposes
>> -  --sshkey [SSHKEY]     Add ssh key to initramfs (use with ssh-client module)
>>    --ctty                Add control tty for emergency shells
>>  EOF
>>  }
>> @@ -242,7 +241,6 @@ while (($# > 0)); do
>>          --debug)       debug="yes";;
>>          --profile)     profile="yes";;
>>          --ctty)        cttyhack="yes";;
>> -        --sshkey)      read_arg sshkey   "$@" || shift;;
>>          -v|--verbose)  ((verbosity_mod_l++));;
>>          -q|--quiet)    ((verbosity_mod_l--));;
>>          -l|--local)    allowlocal="yes" ;;
>> @@ -613,7 +611,7 @@ export initdir dracutbasedir dracutmodules drivers \
>>      add_drivers mdadmconf lvmconf filesystems \
>>      use_fstab libdir usrlibdir fscks nofscks cttyhack \
>>      stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
>> -    debug host_fs_types host_devs sshkey dracut_module_args
>> +    debug host_fs_types host_devs dracut_module_args
>>  
>>  # Create some directory structure first
>>  [[ $prefix ]] && mkdir -m 0755 -p "${initdir}${prefix}"
>> diff --git a/dracut.8.xml b/dracut.8.xml
>> index ea24764..0dc6225 100644
>> --- a/dracut.8.xml
>> +++ b/dracut.8.xml
>> @@ -371,14 +371,6 @@ Default:
>>          </varlistentry>
>>          <varlistentry>
>>            <term>
>> -            <option>--sshkey&nbsp;<replaceable>&lt;sshkey file&gt;</replaceable></option>
>> -          </term>
>> -          <listitem>
>> -            <para>ssh key file used with ssh-client module.</para>
>> -          </listitem>
>> -        </varlistentry>
>> -        <varlistentry>
>> -          <term>
>>              <option>-l</option>
>>            </term>
>>            <term>
> 
> 
> Hi,
> 
> After removing --sshkey we need to parse dracut_module_args for module
> use. Maybe in a general function of dracut-lib will be fine.
> 
> Also need consider the multi-param case like below:
> module:a=b,c=d,e=f,...
> 
> Ie. in ssh-client module we need to parse "sshkey=/root/.ssh/id_rsa" for
> installing sshkey
> 


Seems $sshkey is only limited to check() function, so it will be not
available in install(), should add something like below:

diff --git a/modules.d/95ssh-client/module-setup.sh
b/modules.d/95ssh-client/module-setup.sh
index ef8effe..352817c 100755
--- a/modules.d/95ssh-client/module-setup.sh
+++ b/modules.d/95ssh-client/module-setup.sh
@@ -39,7 +39,10 @@ inst_sshenv()
     fi

     # Copy over ssh key and knowhosts if needed
+    ssharg=${dracut_module_args["ssh-client"]}
+    sshkey=`echo $ssharg|cut --fields=2 -d '='`
     [[ $sshkey ]] && {
+        echo "installing sshkey"
         inst $sshkey
         [[ -f /root/.ssh/known_hosts ]] && inst /root/.ssh/known_hosts
         [[ -f /etc/ssh/ssh_known_hosts ]] && inst /etc/ssh/ssh_known_hosts


-- 
Thanks
Dave
