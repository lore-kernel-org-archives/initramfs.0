From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut.sh: allow setting i18n_install_all in command
 options
Date: Fri, 13 Nov 2015 13:45:26 +0100
Message-ID: <5645DB66.2060300@redhat.com>
References: <1441958636-15303-1-git-send-email-dliu@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441958636-15303-1-git-send-email-dliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dangyi Liu <dliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11.09.2015 10:03, Dangyi Liu wrote:
> From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> During kdump, we need a way to disable i18n_install_all forcedly in
> order to reduce memory usage, especially on PowerPC machines with 64k
> pages, which would efficiently save upto 60MB memory.
> ---
>  dracut.8.asc | 3 +++
>  dracut.sh    | 5 +++++
>  2 files changed, 8 insertions(+)
> 

Thanks! Pushed.
