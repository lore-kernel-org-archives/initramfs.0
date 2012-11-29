From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch RFC 5/6] Get ifaces for udev rule use
Date: Thu, 29 Nov 2012 16:07:34 +0800
Message-ID: <50B717C6.4090709@redhat.com>
References: <20121108034018.789330224@redhat.com> <20121108034317.735680044@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121108034317.735680044-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 11/08/2012 11:40 AM, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:

> In case without BOOTIF, but /tmp/ifaces are already created.
> net-genrule.sh will fall to bring up all net interfaces.
> 
> Fix by reading from /tmp/ifaces before generating rules instead.

>

> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/net-genrules.sh |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- dracut.orig/modules.d/40network/net-genrules.sh
> +++ dracut/modules.d/40network/net-genrules.sh
> @@ -19,6 +19,8 @@ if [ -z "$netroot" ] && [ ! -e "/tmp/net
>      return
>  fi
>  
> +[ -e /tmp/net.ifaces ] && read IFACES < /tmp/net.ifaces



later code will update and overwrite IFACES
So use net.ifaces as default  above line should be moved after
the bond.info test code chunk.

> +
>  # Write udev rules
>  {
>      # bridge: attempt only the defined interface
> 



-- 
Thanks
Dave
