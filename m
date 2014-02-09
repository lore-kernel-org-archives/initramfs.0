From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Cryptroot-ask.sh: Use variables consistently
Date: Sun, 09 Feb 2014 14:13:30 +0100
Message-ID: <52F77EFA.2070600@redhat.com>
References: <1391933322-17308-1-git-send-email-opensource@till.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391933322-17308-1-git-send-email-opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Till Maas <opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/09/2014 09:08 AM, Till Maas wrote:
> - Always use $luksname instead of sometimes $2
> - define $asked_file instead of using the same path twice
> ---
>  modules.d/90crypt/cryptroot-ask.sh | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Thanks! Pushed.
