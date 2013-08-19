From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut.sh: Fix [no-]early-microcode parameter and add
 documentation.
Date: Mon, 19 Aug 2013 11:13:54 +0200
Message-ID: <5211E1D2.5060605@redhat.com>
References: <1376687775-31272-1-git-send-email-farbing@web.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376687775-31272-1-git-send-email-farbing-S0/GAf8tV78@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Daniel Schaal <farbing-S0/GAf8tV78@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/16/2013 11:16 PM, Daniel Schaal wrote:
> [no-]early-microcode was missing from getopt argument list.
> 
> Let arguments passed by command line override config files.
> ---
>  dracut.8.asc      | 6 ++++++
>  dracut.conf.5.asc | 3 +++
>  dracut.sh         | 8 ++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 

Thanks! pushed
