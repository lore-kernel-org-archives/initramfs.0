From: James Lee <jlee-RWYTM8lfiZY4k1Tz1RznXQC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH 2/2] crypt: Only write udev rules to unlock when the device
 is added
Date: Tue, 14 Jan 2014 02:16:05 -0500
Message-ID: <52D4E435.5050905@thestaticvoid.com>
References: <1388093183-19045-1-git-send-email-colin@mageia.org> <1388093183-19045-2-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1388093183-19045-2-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/26/2013 04:26 PM, Colin Guthrie wrote:
> It seems that when the device is unlocked, it will trigger a change
> event which in turn re-writes the settled job which was diligently
> removed after it was run.
> 
> Due to the previous fix, this isn't crazy important as the triggered
> job should exit, but avoiding this in the first place is still
> desirable.
> ---
> 
> Note, I'm not sure if this is wise or not. The previous patch alone
> fixes the issue, so this is just an efficiency saving. It might be
> that this is needed - e.g. if you have any encrypted volume on top
> of some other mapped device such as RAID, so please only apply this
> patch if you are sure it will not cause regressions!!

Actually, after some more testing with this particular patch, I'm not so
sure about it.  I have encrypted devices that depend on other encrypted
devices.  With this patch applied I sometimes get prompted for
passphrases out of order.

I'll try to do some more digging and figure out why.

Thanks,

James
