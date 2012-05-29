From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] do emergency_shell in die() if rd.debug=1
Date: Tue, 29 May 2012 11:42:04 +0200
Message-ID: <4FC499EC.7030502@redhat.com>
References: <1337724972-6545-2-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337724972-6545-2-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 23.05.2012 00:16, schrieb Will Woods:
> If I said 'rd.debug=1' I should get to debug the system before it dies,
> right?
> ---
>  modules.d/99base/dracut-lib.sh |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

pushed
