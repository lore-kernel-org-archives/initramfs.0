From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 09/10] initqueue now loops until /dev/root exists or root
 is mounted
Date: Mon, 6 Jul 2009 10:54:56 +0200
Message-ID: <4A51BBE0.6030603@bfh.ch>
References: <1246639520-3094-1-git-send-email-harald@redhat.com> <1246639520-3094-10-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246639520-3094-10-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald Hoyer wrote:
> init now has the following points to inject scripts:
> 
> /cmdline/*.sh
>    scripts for command line parsing
> 
> /pre-udev/*.sh
>    scripts to run before udev is started
> 
> /pre-trigger/*.sh
>    scripts to run before the main udev trigger is pulled
> 
> /initqueue/*.sh
>    runs in parallel to the udev trigger
>    Udev events can add scripts here with /sbin/initqueue.
>    If /sbin/initqueue is called with the "--onetime" option, the script
>    will be removed after it was run.
>    If /initqueue/work is created and udev >= 143 then this loop can
>    process the jobs in parallel to the udevtrigger.
>    If the udev queue is empty and no root device is found or no root
>    filesystem was mounted, the user will be dropped to a shell after
>    a timeout.
>    Scripts can remove themselves from the initqueue by "rm $job".

I like this. It introduces a bit more complexity than I'd like, but 
allows us to solves a lot of timeing issues between asynchronous and 
parallel tasks in udev.

> /pre-mount/*.sh
>    scripts to run before the root filesystem is mounted
>    NFS is an exception, because it has no device node to be created
>    and mounts in the udev events

Suggestion: If this description goes into a README or something similar, 
I'd rewrite this as "...network filesystems like NFS that do not use 
devicefiles are an exception,..."

> /mount/*.sh
>    scripts to mount the root filesystem
>    NFS is an exception, because it has no device node to be created
>    and mounts in the udev events
Same here, although I'd just drop it since its already mentioned or 
change it to say "network filesystems like NFS that do not use 
devicefiles should mount directly inside their netroot root-handlers."

>    If the udev queue is empty and no root device is found or no root
>    filesystem was mounted, the user will be dropped to a shell after
>    a timeout.
> 
> /pre-pivot/*.sh
>    scripts to run before the real init is executed and the initramfs
>    disappears
>    All processes started before should be killed here.
> 
> The behaviour of the dmraid module demonstrates how to use the new
> mechanism. If it detects a device which is part of a raidmember from a
> udev rule, it installs a job to scan for dmraid devices, if the udev
> queue is empty. After a scan, it removes itsself from the queue.

[snip]
> diff --git a/modules.d/90dmraid/dmraid_scan b/modules.d/90dmraid/dmraid_scan
> new file mode 100755
> index 0000000..433e5d3
> --- /dev/null
> +++ b/modules.d/90dmraid/dmraid_scan
> @@ -0,0 +1,8 @@
> +#!/bin/sh
> +
> +if udevadm settle --timeout=0 >/dev/null 2>&1; then
> +    # run dmraid if udev has settled
> +    dmraid -ay -Z
> +    [ -e "$job" ] && rm -f "$job"
> +fi

Please do not use 'udevadm settle timeout=0'. Older version of udev, 
especially the one on debian lenny does not support a value of 0.

I suggest to increase that timeout to 1.

[snip]
> diff --git a/modules.d/99base/init b/modules.d/99base/init
> index bb20220..f082765 100755
> --- a/modules.d/99base/init
> +++ b/modules.d/99base/init
> @@ -16,36 +16,6 @@ emergency_shell()
>      sh -i
>  }
>  
> -do_initqueue()
> -{
> -    while :; do
> -        # bail out, if we have mounted the root filesystem
> -	[ -d "$NEWROOT/proc" ] && break;
> -
> -        # check if root can be mounted
> -        [ -e /dev/root ] && break;
> -
> -	if [ $UDEVVERSION -ge 143 ]; then
> -	    udevadm settle --exit-if-exists=/initqueue/work --exit-if-exists=/dev/root
> -	else
> -	    udevadm settle --timeout=30
> -	fi
> -	[ -f /initqueue/work ] || break
> -	rm /initqueue/work
> -	
> -	for job in /initqueue/*.job; do
> -	    . $job
> -	    rm -f $job
> -
> -            # bail out, if we have mounted the root filesystem
> -	    [ -d "$NEWROOT/proc" ] && break;
> -
> -            # check if root can be mounted
> -	    [ -e /dev/root ] && break;
> -	done
> -    done
> -}
> -
>  export PATH=/sbin:/bin:/usr/sbin:/usr/bin
>  export TERM=linux
>  NEWROOT="/sysroot"
> @@ -116,7 +86,47 @@ source_all pre-trigger
>  # then the rest
>  udevadm trigger $udevtriggeropts  >/dev/null 2>&1
>  
> -do_initqueue
> +i=0
> +while :; do
> +    # bail out, if we have mounted the root filesystem
> +    [ -d "$NEWROOT/proc" ] && break;
> +
> +    # check if root can be mounted
> +    [ -e /dev/root ] && break;
> +
> +    if [ $UDEVVERSION -ge 143 ]; then
> +        udevadm settle --exit-if-exists=/initqueue/work --exit-if-exists=/dev/root 
> +    else
> +        udevadm settle --timeout=30
> +    fi
> +    unset queuetriggered
> +    if [ -f /initqueue/work ]; then
> +        rm /initqueue/work
> +	queuetriggered="1"
> +    fi
> +    	
> +    for job in /initqueue/*.sh; do
> +	[ -e "$job" ] || break
> +        job=$job . $job
> +
> +        # bail out, if we have mounted the root filesystem
> +        [ -d "$NEWROOT/proc" ] && break;
> +        # check if root can be mounted
> +        [ -e /dev/root ] && break;
> +    done
> +
> +    [ -n "$queuetriggered" ] && continue
> +
> +    if udevadm settle --timeout=0 >/dev/null 2>&1; then

Same here. Please increase the timeout to 1.

> +        # no more udev jobs
> +        sleep 0.5
> +        i=$(($i+1))
> +        [ $i -gt 20 ] && getarg rdshell \
> +            && { flock -s 9 ; emergency_shell; } 9>/.console_lock

Question: Would it make sense to reset i to 0 after we've opened a 
shell? Or is it the intention that if a shell is opened and closed that 
we drop in again as soon as possible?

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
