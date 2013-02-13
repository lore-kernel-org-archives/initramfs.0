From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] crypt: Fix device detection.
Date: Wed, 13 Feb 2013 11:52:58 +0100
Message-ID: <511B708A.60106@redhat.com>
References: <1360715138-19755-1-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360715138-19755-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 13.02.2013 01:25, schrieb Colin Guthrie:
> The host device/fs rework led to a regression in crypt detection.
> It was only checking the host filesystems, not it's slaves and thus
> never detected if crypt support was needed.
> 
> Code now mirrors the lvm module's check
> 
> https://bugs.mageia.org/show_bug.cgi?id=9040
> ---

Does this commit fix the issue instead?

http://git.kernel.org/?p=boot/dracut/dracut.git;a=commitdiff;h=19bab59c48ba6edbdf9d6d9f339baef250bdd4a6

