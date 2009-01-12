From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] Fix 'root=LABEL=/'
Date: Mon, 12 Jan 2009 11:35:41 -0500
Message-ID: <B9A9EF7B-50A6-4E37-8485-F9486F96C5FA@redhat.com>
References: <1231617553-4206-1-git-send-email-notting@redhat.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1231617553-4206-1-git-send-email-notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Jan 10, 2009, at 2:59 PM, Bill Nottingham wrote:
> As you can't have /dev/disk/by-label//, we need to escape the '/'
> character in the same way that udev does.

Applied, thanks.  Though I still want to get to where we use a udev  
rule to create the /dev/root symlink so that we can not have to do  
this sort of escaping.

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
