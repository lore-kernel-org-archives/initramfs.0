From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch dracut v2] fix teamd exec in case config does not
 include devname
Date: Thu, 10 Jan 2013 22:10:49 +0800
Message-ID: <1357827049.10074.20.camel@cr0>
References: <1357826571-1877-1-git-send-email-jiri@resnulli.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357826571-1877-1-git-send-email-jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Thu, 2013-01-10 at 15:02 +0100, Jiri Pirko wrote:
> In case that configuration file did not include name of team device,
> teamd would not start. Fix this by adding "-t" parameter.
> 
> Signed-off-by: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
> ---
> 
> v2->v1:
> -fixed bad order of args

Looks good! I didn't test the ifcfg case.

Acked-by: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Thanks!
