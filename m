From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut: ordering of modules
Date: Mon, 13 Feb 2012 11:29:08 +0100
Message-ID: <4F38E5F4.9070009@redhat.com>
References: <1328886121.2472.19.camel@falcor> <4F38DEF0.8010202@redhat.com> <4F38E337.7030200@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F38E337.7030200-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, selinux-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, Daniel J Walsh <dwalsh-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 13.02.2012 11:17, schrieb Roberto Sassu:
> Hi Harald
> 
> this functionality seems to be broken in dracut due to a change in the
> SELinux load_policy tool.
> After enabling the selinux module in dracut, i obtain:
> 
> [    3.369059] dracut: Loading SELinux policy
> [    3.449850] dracut: /sbin/load_policy: Can't load policy: No such file or
> directory
> [    3.659899] dracut: Switching root
> 

This error can have multiple causes... Dan?
