From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 0/6] Revert action_on_fail patches
Date: Mon, 31 Aug 2015 10:43:14 +0800
Message-ID: <20150831024314.798498962@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Hi,

action_on_fail was introduced originally for kdump error handling.
Before the patches, dracut will drop into emergency shell for many
failure cases, but kdump does not care about some of failures as
long as vmcore can be saved successfully. Thus action_on_fail was
introduced to fall to kdump service in case early failure in dracut.

But later with new systemd services, there are cases that kdump
script can never be called in case early dracut failure because of
systemd service dependency issues.

Thus there was below post which create a new kdump error handler
systemd service:
https://lists.stg.fedoraproject.org/archives/list/kexec-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org/thread/3EN63K2NDC6C545M5Z434VCHWDR3BCHD/

Now this action_on_fail interface was useless, nobody use it and
it is broken with systemd sometimes. So I send this series to revert
them one by one.

Thanks
Dave
