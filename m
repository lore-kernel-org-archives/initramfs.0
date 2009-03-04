From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/4] Steal rules we need from the latest udev package.
Date: Tue, 3 Mar 2009 19:25:35 -0500
Message-ID: <20090304002535.GB96609@redhat.com>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com> <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tuesday, March 03 2009, Victor Lowther said:
> This should arguably be done by importing the udev git repo as a submodule,
> but I am too lazy to figure out how to do that right now.
> 
> I suppose this could also be done by rewriting the 95udev-rules.sh module
> for each distribution, but that is something best left to the distro 
> maintainers once we acheive some sort of widespread adoption.  Until then,
> stealing rules from upstream udev seems like the most portable solution.

Stealing rules, though, means that they're almost certain to be out of
date as soon as they're present.  The right fix here is for distros not
to go off and think that they know better than upstream on how to write
udev rules.  But I'll let Kay chime in if he really wants to here ;-)

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
