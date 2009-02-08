From: Szabolcs Szakacsits <szaka-IyvsvuGDJ8VBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Sun, 8 Feb 2009 19:16:37 +0000 (UTC)
Message-ID: <loom.20090208T191148-830@post.gmane.org>
References: <20090206164019.GD552@redhat.com>  <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com>  <20090206165601.GF11144@nostromo.devel.redhat.com>  <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com>  <20090206173814.GA3541@nostromo.devel.redhat.com> <e9c3a7c20902061012w15a31e7br6ce2074b7b9db555@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Dan Williams <dan.j.williams@...> writes:
> consider what extra tools the initramfs would need if we wanted to
> support an ntfs-3g rootfs.

The FUSE kernel module. Nothing else. Several distros do it.

Regards, Szaka

NTFS-3G: http://ntfs-3g.org 


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
