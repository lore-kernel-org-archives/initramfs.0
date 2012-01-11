From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] remove the global --sshkey parameter
Date: Wed, 11 Jan 2012 10:59:20 +0800
Message-ID: <4F0CFB08.6030800@redhat.com>
References: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com> <1326208786-24344-2-git-send-email-xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326208786-24344-2-git-send-email-xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 01/10/2012 11:19 PM, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  dracut       |    4 +---
>  dracut.8.xml |    8 --------
>  2 files changed, 1 insertions(+), 11 deletions(-)
> 
> diff --git a/dracut b/dracut
> index f3fa257..58c4fde 100755
> --- a/dracut
> +++ b/dracut
> @@ -118,7 +118,6 @@ Creates initial ramdisk images for preloading modules
>    -M, --show-modules    Print included module's name to standard output during
>                           build.
>    --keep                Keep the temporary initramfs for debugging purposes
> -  --sshkey [SSHKEY]     Add ssh key to initramfs (use with ssh-client module)
>    --ctty                Add control tty for emergency shells
>  EOF
>  }
> @@ -242,7 +241,6 @@ while (($# > 0)); do
>          --debug)       debug="yes";;
>          --profile)     profile="yes";;
>          --ctty)        cttyhack="yes";;
> -        --sshkey)      read_arg sshkey   "$@" || shift;;
>          -v|--verbose)  ((verbosity_mod_l++));;
>          -q|--quiet)    ((verbosity_mod_l--));;
>          -l|--local)    allowlocal="yes" ;;
> @@ -613,7 +611,7 @@ export initdir dracutbasedir dracutmodules drivers \
>      add_drivers mdadmconf lvmconf filesystems \
>      use_fstab libdir usrlibdir fscks nofscks cttyhack \
>      stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
> -    debug host_fs_types host_devs sshkey dracut_module_args
> +    debug host_fs_types host_devs dracut_module_args
>  
>  # Create some directory structure first
>  [[ $prefix ]] && mkdir -m 0755 -p "${initdir}${prefix}"
> diff --git a/dracut.8.xml b/dracut.8.xml
> index ea24764..0dc6225 100644
> --- a/dracut.8.xml
> +++ b/dracut.8.xml
> @@ -371,14 +371,6 @@ Default:
>          </varlistentry>
>          <varlistentry>
>            <term>
> -            <option>--sshkey&nbsp;<replaceable>&lt;sshkey file&gt;</replaceable></option>
> -          </term>
> -          <listitem>
> -            <para>ssh key file used with ssh-client module.</para>
> -          </listitem>
> -        </varlistentry>
> -        <varlistentry>
> -          <term>
>              <option>-l</option>
>            </term>
>            <term>


Hi,

After removing --sshkey we need to parse dracut_module_args for module
use. Maybe in a general function of dracut-lib will be fine.

Also need consider the multi-param case like below:
module:a=b,c=d,e=f,...

Ie. in ssh-client module we need to parse "sshkey=/root/.ssh/id_rsa" for
installing sshkey

-- 
Thanks
Dave
