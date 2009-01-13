From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 1/3] Fix 'root=LABEL=/'
Date: Tue, 13 Jan 2009 08:46:44 +0100
Message-ID: <496C46E4.8000301@bfh.ch>
References: <1231617553-4206-1-git-send-email-notting@redhat.com> <B9A9EF7B-50A6-4E37-8485-F9486F96C5FA@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B9A9EF7B-50A6-4E37-8485-F9486F96C5FA-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Jeremy Katz wrote:
> On Jan 10, 2009, at 2:59 PM, Bill Nottingham wrote:
>> As you can't have /dev/disk/by-label//, we need to escape the '/'
>> character in the same way that udev does.
> 
> Applied, thanks.  Though I still want to get to where we use a udev rule 
> to create the /dev/root symlink so that we can not have to do this sort 
> of escaping.

Just out of curiosity. Any idea how to do a udev rule like that?

Cheers,
Philippe

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
