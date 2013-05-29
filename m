From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 50drm: Install dracut 50drm module in hostonly mode when
 drm driver is currently in use.
Date: Wed, 29 May 2013 12:54:13 +0200
Message-ID: <51A5DE55.7020801@redhat.com>
References: <1369383763-24956-1-git-send-email-chaowang@redhat.com> <51A49E65.9000206@redhat.com> <51A56BC8.2010205@redhat.com> <20130529065726.GA28070@dhcp12-158.nay.redhat.com> <51A5CDE9.4090808@redhat.com> <20130529104112.GA3727@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130529104112.GA3727-UAAZkH0G2Ts1naxU1pY8ZxcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/29/2013 12:41 PM, WANG Chao wrote:
>>
>> Do we really need a fb console?
>> If there is a valid reason, I will change "return 255" to "return 0".
> 
> Actually I don't have strong technical reason.
> 
> But from a user's perspective, there are some benefits:
> - Higher resolution on the screen. It's good-looking and show me much
>   more text.
> - Initializing drm drivers would cause a flash on the screen and clear
>   all existing text. I'd like this flash happens in initrd not later in
>   real root.
>   (During bootup, I care more about the status of real root systemd
>   services than what's going on in initrd as long as it
>   switches to root successfully)
> 
> I know it's weird for a normal boot to try to avoid plymouth but still want fb
> console. So I wouldn't blame it if you don't feel comfortable about the
> change.
> 
> Thanks
> WANG Chao
> 

Well, my reasons are size and speed for those who want a very minimal initramfs.
The initramfs should not do more than it has to, to get to the real rootfs.

If someone omits the dracut plymouth module manually, he can also add drm in the
same step, if he wants.

I might change my mind, when we move to wayland terminal consoles. :)
