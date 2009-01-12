From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] Go to an emergency shell if mounting the root filesystem fails.
Date: Mon, 12 Jan 2009 11:36:40 -0500
Message-ID: <953FD763-DD7A-4F36-B35F-388BF6859007@redhat.com>
References: <1231617553-4206-1-git-send-email-notting@redhat.com> <1231617553-4206-2-git-send-email-notting@redhat.com> <1231617553-4206-3-git-send-email-notting@redhat.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1231617553-4206-3-git-send-email-notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Jan 10, 2009, at 2:59 PM, Bill Nottingham wrote:
> -mount -o ro /dev/root $NEWROOT
> +mount -o ro /dev/root $NEWROOT || emergency_shell

And also applied.  Although it raises the question of if it makes  
sense to use 'set -e' so that any command failing drops you to the  
prompt

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
