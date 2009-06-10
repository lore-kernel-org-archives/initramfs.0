From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dhclient.* files become net.* only after successful netboot
Date: Wed, 10 Jun 2009 14:12:54 +0200
Message-ID: <4A2FA346.8070409@redhat.com>
References: <4A2F3E84.8070403@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A2F3E84.8070403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/10/2009 07:03 AM, Warren Togami wrote:
> Somehow the final chunk of this patch isn't working.  Isn't that part
> supposed to happen only on the occasion where netroot is successfully
> mounted? I seem to be missing something simple here...
>
> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

is "cp" installed in the initramfs?
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
