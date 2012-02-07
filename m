From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/7] auto setup network without netroot
Date: Tue, 07 Feb 2012 12:15:11 +0100
Message-ID: <4F3107BF.9060002@redhat.com>
References: <20120202075952.GA12412@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120202075952.GA12412-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Am 02.02.2012 08:59, schrieb Dave Young:
> Current dracut network only will be setup when netroot is used. But there are
> some cases we need network even without netroot. For example kdump will need
> copy vmcore to remote machine via scp or nfs mount. OTOH, if we use dracut as
> a recovery system the network is helpful even root is not a network device.
> 
> This implementation is based on the manually bring up method. Here add a kernel
> cmdline argument rd.neednet. If rd.neednet is set dracut will bring up network
> with ifup $INTERFACE -m. If netroot is used we still keep original behavior.
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.cmdline.7.xml                |    8 ++++++++
>  modules.d/40network/net-genrules.sh |   20 ++++++++++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> Index: dracut/modules.d/40network/net-genrules.sh
> ===================================================================
> --- dracut.orig/modules.d/40network/net-genrules.sh
> +++ dracut/modules.d/40network/net-genrules.sh
> @@ -14,7 +14,7 @@ fix_bootif() {
>  }
>  
>  # Don't continue if we don't need network
> -[ -z "$netroot" ] && return;
> +[ -z "$netroot" ] && ! getargbool 0 rd.neednet && return;
>  
>  # Write udev rules
>  {
> @@ -35,17 +35,29 @@ fix_bootif() {
>      BOOTIF=$(getarg 'BOOTIF=')
>      if [ -n "$BOOTIF" ] ; then
>          BOOTIF=$(fix_bootif "$BOOTIF")
> -        printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$BOOTIF"
> +        if [ -n "$netroot" ]; then
> +            printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$BOOTIF"
> +        else
> +            printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="/sbin/ifup $env{INTERFACE} -m"\n' "$BOOTIF"
> +        fi
>  
>      # If we have to handle multiple interfaces, handle only them.
>      elif [ -n "$IFACES" ] ; then
>          for iface in $IFACES ; do
> -            printf 'SUBSYSTEM=="net", ENV{INTERFACE}=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$iface"
> +            if [ -n "$netroot" ]; then
> +                printf 'SUBSYSTEM=="net", ENV{INTERFACE}=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$iface"
> +            else
> +                printf 'SUBSYSTEM=="net", ENV{INTERFACE}=="%s", RUN+="/sbin/ifup $env{INTERFACE} -m"\n' "$iface"
> +            fi
>          done
>  
>      # Default: We don't know the interface to use, handle all
>      else
> -        printf 'SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"\n'
> +        if [ -n "$netroot" ]; then
> +            printf 'SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"\n'
> +        else
> +            printf 'SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE} -m"\n'
> +        fi
>      fi
>  
>  } > /etc/udev/rules.d/60-net.rules
> Index: dracut/dracut.cmdline.7.xml
> ===================================================================
> --- dracut.orig/dracut.cmdline.7.xml
> +++ dracut/dracut.cmdline.7.xml
> @@ -507,6 +507,14 @@ Required if multiple ip= lines are used.
>              <para>turn on/off biosdevname network interface renaming</para>
>            </listitem>
>          </varlistentry>
> +        <varlistentry>
> +          <term>
> +            <envar>rd.neednet=</envar><replaceable>&lt;0|1&gt;</replaceable>
> +          </term>
> +          <listitem>
> +            <para>boolean, bring up network even without netroot set</para>
> +          </listitem>
> +        </varlistentry>
>        </variablelist>
>      </refsect2>
>      <refsect2>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


pushed
