From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] move cleanup scripts to pre-pivot-cleanup hook
Date: Thu, 19 Apr 2012 12:16:46 +0200
Message-ID: <4F8FE60E.1070508@redhat.com>
References: <20120419040143.GA17474@localhost.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120419040143.GA17474-bi+AKbBUZKaljkADxpZm/1aTQe2KTcn/@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 19.04.2012 06:01, schrieb Dave Young:
> below cleanup scripts is moved:
> 40network: kill-dhclient.sh
> 90crypt: crypt-cleanup.sh
> 90multipath: multipathd-stop.sh
> 95iscsi: cleanup-iscsi.sh
> 95nfs: nfsroot-cleanup.sh
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

pushed
