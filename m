From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/5 branch usrmove v2] deal common part of etc passwd
 in 99base
Date: Thu, 29 Dec 2011 17:45:49 +0800
Message-ID: <4EFC36CD.8040205@redhat.com>
References: <20111226062910.GA3141@darkstar.nay.redhat.com> <jdcb3i$9bf$1@dough.gmane.org> <4EFBD882.2090707@redhat.com> <jdhbpl$s87$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jdhbpl$s87$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/29/2011 05:27 PM, Cong Wang wrote:

> On Thu, 29 Dec 2011 at 03:03 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> On 12/27/2011 07:44 PM, Cong Wang wrote:
>>
>>> On Mon, 26 Dec 2011 at 06:29 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>> ssh module will need root user in /etc/passwd, so add root and nobody
>>>> to /etc/passwd in 99base instead of nfs module
>>>>
>>>
>>> Sorry, for people who don't use nfs/ssh module,
>>> this is totally unnecessary.
>>
>>
>> I dont think so, but if you insist I can add an dracut function like
>> inst_root_user
>>
> 
> I cooked the following patch.


Thanks.

> 
> The nfs module still uses "/" as home of root, while ssh module uses
> "/root". With you patches, you changed to "/root" for both nfs and
> ssh, which *maybe* a problem for nfs module since you didn't test it.


I tested nfs boot as well, it works ok with $HOME=/root

Also if you add both ssh-client and nfs, what's the result of /etc/passwd?

> 
> 
> ----
> diff --git a/modules.d/95nfs/module-setup.sh b/modules.d/95nfs/module-setup.sh
> index 6778f28..c97dea3 100755
> --- a/modules.d/95nfs/module-setup.sh
> +++ b/modules.d/95nfs/module-setup.sh
> @@ -65,8 +65,8 @@ install() {
>  
>      # Rather than copy the passwd file in, just set a user for rpcbind
>      # We'll save the state and restart the daemon from the root anyway
> -    egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/:/bin/sh' >> "$initdir/etc/passwd"
> -    egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
> +    egrep -q '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/:/bin/sh' >> "$initdir/etc/passwd"
> +    egrep -q '^nobody:' "$initdir/etc/passwd" 2>/dev/null || egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
>      egrep '^nfsnobody:' /etc/passwd >> "$initdir/etc/passwd"
>      egrep '^rpc:' /etc/passwd >> "$initdir/etc/passwd"
>      egrep '^rpcuser:' /etc/passwd >> "$initdir/etc/passwd"
> diff --git a/modules.d/95ssh-client/module-setup.sh b/modules.d/95ssh-client/module-setup.sh
> index 0ffc298..ef8effe 100644
> --- a/modules.d/95ssh-client/module-setup.sh
> +++ b/modules.d/95ssh-client/module-setup.sh
> @@ -56,5 +56,8 @@ install() {
>      inst ssh
>      inst scp
>      inst_sshenv
> +
> +    egrep -q '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/root:/bin/sh' >> "$initdir/etc/passwd"
> +    egrep -q '^nobody:' "$initdir/etc/passwd" 2>/dev/null || egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
