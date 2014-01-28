From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv2] dracut-initramfs-restore,lsinitrd: add LZ4 support
Date: Tue, 28 Jan 2014 15:40:07 +0100
Message-ID: <52E7C147.4090000@redhat.com>
References: <1389866454-28426-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389866454-28426-1-git-send-email-koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/16/2014 11:00 AM, Koen Kooi wrote:
> Dracut claims to have LZ4 support, but trying to use it will result in an xzcat failure at the end due to missing CAT support.
> 
> The lz4 command chokes on '--', so abstract that out into the CAT select.
> 
> Something similar will need to be done for LZO.
> 
> Signed-off-by: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
> ---
>  dracut-initramfs-restore.sh |  2 ++
>  lsinitrd.sh                 | 22 ++++++++++++----------
>  2 files changed, 14 insertions(+), 10 deletions(-)

Thanks! Pushed.
