From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] split nfsroot rpc start code
Date: Wed, 01 Feb 2012 15:56:07 +0800
Message-ID: <4F28F017.3030908@redhat.com>
References: <20120201020054.GA9567@darkstar.nay.redhat.com> <jgaqo7$n39$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jgaqo7$n39$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/01/2012 03:48 PM, Cong Wang wrote:

> On Wed, 01 Feb 2012 at 02:00 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> fstab-sys will mount nonroot nfs as well, so we need to split the necessary
>> code from nfsroot to start rpc daemon as hook script.
>>
>> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Why not Cc me who reviewed your V1 patches? :-/


Hehe, Will do next time.
I assume you will monitor dracut list. sorry about the lazy.

> 
>> ---
>>  modules.d/95nfs/module-setup.sh  |    1 +
>>  modules.d/95nfs/nfs-start-rpc.sh |   17 +++++++++++++++++
>>  modules.d/95nfs/nfsroot          |   15 ---------------
>>  3 files changed, 18 insertions(+), 15 deletions(-)
>>
>> Index: dracut/modules.d/95nfs/module-setup.sh
>> ===================================================================
>> --- dracut.orig/modules.d/95nfs/module-setup.sh
>> +++ dracut/modules.d/95nfs/module-setup.sh
>> @@ -57,6 +57,7 @@ install() {
>>      dracut_install $(for _i in $(ls {/usr,}$libdir/libnss*.so 2>/dev/null); do echo $_i;done | egrep "$_nsslibs")
>>  
>>      inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
>> +    inst_hook cmdline 91 "$moddir/nfs-start-rpc.sh"
> 
> I am sure this is wrong. You need pre-pivot.


I want to start them as early as we can, I always think about user use
dracut as a minimal recovery system, they need do something manually.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
