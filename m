From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [dracut] rd.shell won't work if "root=" is missing
Date: Fri, 15 Apr 2016 12:04:23 +0200
Message-ID: <5710BCA7.30204@redhat.com>
References: <trinity-fb369bfb-8623-46c4-8628-71f8a6be4d9a-1451985097774@3capp-webde-bs44>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <trinity-fb369bfb-8623-46c4-8628-71f8a6be4d9a-1451985097774@3capp-webde-bs44>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: tammo-v8BkjJTOJzf1qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05.01.2016 10:11, tammo-v8BkjJTOJzf1qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org wrote:
> Hi,
>  
> i just stumbled upon a detail in dracut that i found surprising and appears as a small bug to me. 
> 
> If you boot a dracut image without giving a "root=" parameter (or e.g. a misspelled argument to that parameter) the system will _not_ drop you into a shell, even if rd.shell is set. IMHO this is not the expected behavior, as the manual says that rd.shell will drop you into a shell if rd.shell is set and no root is found. So i would suggest to change the "die()" function in the dracut-lib.sh and add a test for rd.shell in line 460 (getargbool 0 "rd.debug=" && emergency_shell) too. The system will already drop you in a shell if you have a "rd.debug" parameter set, but i think that rd.shell (and probably "rdshell" too) alone should be sufficient, as this is more convinient and less surprising.
> 
> I could prepare a patch, if you prefer that.
> 
> If this is not some kind of bug, you may call it a "wishlist item" and/or change the documentation accordingly.
> 
> kr
> Tammo
> 

yes... changed with

https://github.com/dracutdevs/dracut/commit/9d74747f926d038f2e149d70a9c8f955861ab354
