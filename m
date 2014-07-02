From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Why has the timeout be removed?
Date: Wed, 02 Jul 2014 09:52:19 +0200
Message-ID: <53B3BA33.7090002@redhat.com>
References: <4109187.o2ig1JcEG2@d46>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4109187.o2ig1JcEG2@d46>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01.07.2014 17:59, Thomas Renninger wrote:
> Hi,
> 
> 
> commit 8ee18253644a812184c60e31d7ee3d3f6d8f45c0
> Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Date:   Tue Mar 4 13:46:14 2014 +0100
> 
>     dracut: don't let devices timeout
> 
>     https://bugzilla.redhat.com/show_bug.cgi?id=949697
> 
> 
> See the whole diff at the end.
> This one removes timeouts on the rootfs and if the rootfs
> cannot be accessed early boot will remain hung forever.
> 
> Unfortunately I cannot access the bug reference from
> the changelog and the changelog does not describe the problem.
> 
> I would like to revive the/a timeout, but need to understand
> why it got removed.
> 
> Thanks,
> 
>       Thomas
> 
> 
> =============================================
>    
> 
> diff --git a/modules.d/98systemd/rootfs-generator.sh b/modules.d/98systemd/rootfs-generator.sh
> index a11ce59..2c09895 100755
> --- a/modules.d/98systemd/rootfs-generator.sh
> +++ b/modules.d/98systemd/rootfs-generator.sh
> @@ -29,7 +29,7 @@ generator_wait_for_dev()
>          mkdir -p /run/systemd/generator/${_name}.device.d
>          {
>              echo "[Unit]"
> -            echo "JobTimeoutSec=3600"
> +            echo "JobTimeoutSec=0"
>          } > /run/systemd/generator/${_name}.device.d/timeout.conf
>      fi
>  }
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index 763b7e2..e4d7da8 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -891,7 +891,7 @@ wait_for_dev()
>              mkdir -p ${PREFIX}/etc/systemd/system/${_name}.device.d
>              {
>                  echo "[Unit]"
> -                echo "JobTimeoutSec=3600"
> +                echo "JobTimeoutSec=0"
>              } > ${PREFIX}/etc/systemd/system/${_name}.device.d/timeout.conf
>              _needreload=1
>          fi
> 
> =============================================
> 

The main reason was that for encrypted devices it would timeout, if you don't
enter the password in time.

If you solve that, then you can reintroduce the timeout.
