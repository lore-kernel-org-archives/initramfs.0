From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: SUSE mkinitrd wrapper
Date: Thu, 28 Nov 2013 15:05:28 +0100
Message-ID: <52974DA8.4090008@redhat.com>
References: <529746E9.4040708@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <529746E9.4040708-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 11/28/2013 02:36 PM, Hannes Reinecke wrote:
> Hi Harald,
> 
> I've updated the current 'mkinitrd-dracut.sh' script to function as
> a wrapper to the old SUSE mkinitrd script.
> However, as some arguments clash between SUSE mkinitrd and
> mkinitrd-dracut.sh I've put them into a separate script,
> mkinitrd-suse.sh.
> 
> What do you prefer? Having two separate scripts?
> As I'm not sure if anybody is actually using the
> 'mkinitrd-dracut.sh' script I could as well merge the changes into
> that one.
> 
> Just tell me what you prefer.
> 
> Cheers,
> 
> Hannes
> 

Hmm, I think "mkinitrd" is still used by some scripts. Not sure.
Can it be merged and switch behavior depending on the $ID in /etc/os-release ?
