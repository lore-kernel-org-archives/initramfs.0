From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 05/13] prepare udev rules for udev >= 143
Date: Fri, 19 Jun 2009 18:09:32 +0200
Message-ID: <4A3BB83C.60305@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com> <1245409551-30493-6-git-send-email-harald@redhat.com> <20090619155149.GA89011@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090619155149.GA89011-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >> \"initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org\"" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/19/2009 05:51 PM, Jeremy Katz wrote:
> Note that this isn't "prepare" as much as "require udev>= 143 and
> util-linux-ng>= 2.15".  Which means only working with the devel trees of
> every distro afaict.
>
> Jeremy

not true... it will work with old versions as well, because it will install the 
old rules for that.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
