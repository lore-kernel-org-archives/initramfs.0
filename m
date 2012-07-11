From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: nfs: install modprobe config file
Date: Wed, 11 Jul 2012 14:44:12 +0800
Message-ID: <4FFD20BC.10208@redhat.com>
References: <20120711050818.GA10940@dhcp-16-143.nay.redhat.com> <4FFD1B89.7060208@redhat.com> <jtj72b$g4h$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jtj72b$g4h$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/11/2012 02:39 PM, Cong Wang wrote:

> On Wed, 11 Jul 2012 at 06:22 GMT, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> Hmm... that modprobe.d conf file should have been already copied to the initramfs:
>>
>> modules.d/90kernel-modules/module-setup.sh:    dracut_install $(find -L
>> /etc/modprobe.d/ -maxdepth 1 -type f -name '*.conf')
>>
>> Oh.. I see ... it's /lib/modprobe.d and not /etc/modprobe.d
> 
> Yeah, should consider /lib/modprobe.d as well:


It's ok to install the /lib/modprobe.d/*.conf, but for nfs alias as I
said better to create the nfs.conf in case there's no such file..

> 
> diff --git a/modules.d/90kernel-modules/module-setup.sh
> b/modules.d/90kernel-modules/module-setup.sh
> index 8822fa7..a9b9637 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -78,6 +78,7 @@ install() {
>      local _f i
>      [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
>      dracut_install $(find -L /etc/modprobe.d/ -maxdepth 1 -type f -name '*.conf')
> +    [ -d /lib/modprobe.d ] && dracut_install $(find -L /lib/modprobe.d/ -maxdepth 1 -type f -name '*.conf')
>      inst_hook cmdline 01 "$moddir/parse-kernel.sh"
>      inst_simple "$moddir/insmodpost.sh" /sbin/insmodpost.sh
> }
> 	   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
