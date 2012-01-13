From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] minor cleanups in parsing for dmsquash-live and livenet
Date: Fri, 13 Jan 2012 11:51:24 +0100
Message-ID: <4F100CAC.30208@redhat.com>
References: <1326304109-32652-1-git-send-email-wwoods@redhat.com> <1326304109-32652-2-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326304109-32652-2-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11.01.2012 18:48, Will Woods wrote:
> - use wait_for_dev in livenet
> - clarify log message and fix missing newline in dmsquash-live
> 
> Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/90dmsquash-live/parse-dmsquash-live.sh |    4 ++--
>  modules.d/90livenet/parse-livenet.sh             |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

applied
