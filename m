From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2 v2] deal with nfs in fstab-sys
Date: Wed, 1 Feb 2012 07:52:21 +0000 (UTC)
Message-ID: <jgaqvk$n39$2@dough.gmane.org>
References: <20120201020058.GA9573@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 01 Feb 2012 at 02:00 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Do not check and fsck $_dev for nfs mount in mount-sys.sh
>

For fsck_single, I think you need to fix fsck_single() to skip NFS case.
