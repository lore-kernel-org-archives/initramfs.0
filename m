From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2 V3] add function getargnum
Date: Tue, 22 Jan 2013 15:32:40 +0100
Message-ID: <50FEA308.6050405@redhat.com>
References: <20130117085549.207542806@redhat.com> <20130117085724.062434676@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130117085724.062434676-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 17.01.2013 09:55, schrieb dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org:
> For cmdline argument with numeric value, add a new function getargnum
> It will get proper value with default value as $1, min value as $2,
> max value as $3, and param name as $4. valid result will be echo to stdout.
> for nul or value not valid it will just echo the default value.
> Note: The values should be >=0
> 
> [v1->v2]: add arg <minval>
> [v2->v3]: do not use bash string match =~
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

merged
