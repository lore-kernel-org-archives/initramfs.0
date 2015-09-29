From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch 0/6] Revert action_on_fail patches
Date: Tue, 29 Sep 2015 16:11:50 +0800
Message-ID: <20150929081150.GD30623@dhcp-129-73.nay.redhat.com>
References: <20150831024314.798498962@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150831024314.798498962-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 08/31/15 at 10:43am, Dave Young wrote:
> Hi,
> 
> action_on_fail was introduced originally for kdump error handling.
> Before the patches, dracut will drop into emergency shell for many
> failure cases, but kdump does not care about some of failures as
> long as vmcore can be saved successfully. Thus action_on_fail was
> introduced to fall to kdump service in case early failure in dracut.
> 
> But later with new systemd services, there are cases that kdump
> script can never be called in case early dracut failure because of
> systemd service dependency issues.
> 
> Thus there was below post which create a new kdump error handler
> systemd service:
> https://lists.stg.fedoraproject.org/archives/list/kexec-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org/thread/3EN63K2NDC6C545M5Z434VCHWDR3BCHD/
> 
> Now this action_on_fail interface was useless, nobody use it and
> it is broken with systemd sometimes. So I send this series to revert
> them one by one.
> 

Harald, ping

Since the code is useless, IMHO it is odd to keep them and it will
cause trouble in the future for further fixes and improvements.

What do you think?

Thanks
Dave
