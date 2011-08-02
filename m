From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] init: fix for setting udev logging priority
Date: Tue, 02 Aug 2011 15:00:19 +0200
Message-ID: <4E37F4E3.90301@redhat.com>
References: <1312289216-5958-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070107000701000602070608"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312289216-5958-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------070107000701000602070608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 02.08.2011 14:46, Michal Soltys wrote:
> Previously udevproperty() function was called, which would lead to
> setting not intended properties instead of actually adjusting logging
> priority, e.g.:
> 
> udevadm control --property=--log-priority=info
> 
> Now, udevadm is called directly from the init script.
> 
> Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
> ---
>  modules.d/99base/init |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/modules.d/99base/init b/modules.d/99base/init
> index ae834be..34a8aef 100755
> --- a/modules.d/99base/init
> +++ b/modules.d/99base/init
> @@ -189,16 +189,14 @@ source_hook pre-udev
>  # start up udev and trigger cold plugs
>  udevd --daemon --resolve-names=never
>  
> -UDEV_LOG_PRIO_ARG=--log-priority
> -UDEV_QUEUE_EMPTY="udevadm settle --timeout=0"
> -
>  if [ $UDEVVERSION -lt 140 ]; then
> -    UDEV_LOG_PRIO_ARG=--log_priority
>      UDEV_QUEUE_EMPTY="udevadm settle --timeout=1"
> +else
> +    UDEV_QUEUE_EMPTY="udevadm settle --timeout=0"
>  fi
>  
> -getargbool 0 rd.udev.info -y rdudevinfo && udevproperty "$UDEV_LOG_PRIO_ARG=info"
> -getargbool 0 rd.udev.debug -y rdudevdebug && udevproperty "$UDEV_LOG_PRIO_ARG=debug"
> +getargbool 0 rd.udev.info -y rdudevinfo && udevadm control --log-priority=info
> +getargbool 0 rd.udev.debug -y rdudevdebug && udevadm control --log-priority=debug
>  udevproperty "hookdir=$hookdir"
>  
>  getarg 'rd.break=pre-trigger' 'rdbreak=pre-trigger' && emergency_shell -n pre-trigger "Break before pre-trigger"


I think the attached patch solves the problem:


--------------070107000701000602070608
Content-Type: text/plain;
 name="dracut-udevadm-control.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-udevadm-control.patch"

commit e36ee58d0e269e6a403f184177d4f14f05b1d3d0
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Aug 2 14:57:49 2011 +0200

    99base/init: use udevadm control to set the logging priority
    
    due to a bad revert commit, "udevadm control" was converted to
    "udevproperty", which is the wrong command to set the logging priority.

diff --git a/modules.d/99base/init b/modules.d/99base/init
index ae834be..b991196 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -197,8 +197,8 @@ if [ $UDEVVERSION -lt 140 ]; then
     UDEV_QUEUE_EMPTY="udevadm settle --timeout=1"
 fi
 
-getargbool 0 rd.udev.info -y rdudevinfo && udevproperty "$UDEV_LOG_PRIO_ARG=info"
-getargbool 0 rd.udev.debug -y rdudevdebug && udevproperty "$UDEV_LOG_PRIO_ARG=debug"
+getargbool 0 rd.udev.info -y rdudevinfo && udevadm control "$UDEV_LOG_PRIO_ARG=info"
+getargbool 0 rd.udev.debug -y rdudevdebug && udevadm control "$UDEV_LOG_PRIO_ARG=debug"
 udevproperty "hookdir=$hookdir"
 
 getarg 'rd.break=pre-trigger' 'rdbreak=pre-trigger' && emergency_shell -n pre-trigger "Break before pre-trigger"

--------------070107000701000602070608--
