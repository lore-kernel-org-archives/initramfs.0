From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/6] Various cleanups
Date: Fri, 27 Nov 2009 14:08:38 +0100
Message-ID: <4B0FCF56.7080208@redhat.com>
References: <1259319436-14925-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259319436-14925-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/27/2009 11:57 AM, Philippe Seewer wrote:
> While debianizing dracut, debians package checker (lintian) came up with
> a few errors and warnings. Since they're not debian specific at all it
> makes sense to fix them.
>
> Philippe Seewer (6):
>    initqueue: Remove trailing ;
>    syslog-genrules.sh: Shebang should be /bin/sh not /bin/dash
>    Module scripts should be executable
>    All module scripts should have a shebang
>    loginit: Fix shebang
>    Fix manpage display errors
>
>   dracut.8                                         |   38 ++++++++++++++-------
>   modules.d/90crypt/crypt-cleanup.sh               |    1 +
>   modules.d/90crypt/parse-crypt.sh                 |    1 +
>   modules.d/90dmsquash-live/parse-dmsquash-live.sh |    1 +
>   modules.d/90lvm/lvm-cleanup.sh                   |    1 +
>   modules.d/90mdraid/mdraid-cleanup.sh             |    1 +
>   modules.d/95dasd/parse-dasd.sh                   |    1 +
>   modules.d/95dasd_mod/parse-dasd-mod.sh           |    1 +
>   modules.d/95iscsi/mount-lun.sh                   |    1 +
>   modules.d/95zfcp/parse-zfcp.sh                   |    2 +-
>   modules.d/95znet/parse-ccw.sh                    |    1 +
>   modules.d/98syslog/syslog-genrules.sh            |    2 +-
>   modules.d/99base/initqueue                       |    1 -
>   modules.d/99base/loginit                         |    2 +-
>   14 files changed, 37 insertions(+), 17 deletions(-)
>   mode change 100644 =>  100755 modules.d/40network/ifname-genrules.sh
>   mode change 100644 =>  100755 modules.d/40network/parse-bridge.sh
>   mode change 100644 =>  100755 modules.d/40network/parse-ifname.sh
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

pushed
