From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut.sh: Support --mount with just mountpoint as
 parameter
Date: Fri, 13 Nov 2015 13:45:12 +0100
Message-ID: <5645DB58.5040405@redhat.com>
References: <1602461.PPk7fxS36o@linux-lm3i>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1602461.PPk7fxS36o@linux-lm3i>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Fabian <fvogt-IBi9RG/b67k@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11.09.2015 13:35, Fabian wrote:
> Right now the --mount parameter of dracut expects a rather long fstab-like 
> line. This makes it possible to invoke dracut with e.g. --mount /boot.
> 
> ---
>  dracut.8.asc |  4 ++++
>  dracut.sh    | 16 +++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)

Thanks! Pushed.
