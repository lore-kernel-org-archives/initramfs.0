From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut: automatically add "unix" kernel module
Date: Fri, 12 Aug 2011 08:01:20 +0200
Message-ID: <4E44C1B0.7050605@redhat.com>
References: <1824774.VrzXCv2fyA@ernie>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1824774.VrzXCv2fyA@ernie>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12.08.2011 01:01, Dennis Schridde wrote:
> Hello!
> 
> Dracut currently does not seem to automatically include the "unix" kernel 
> module in the initramfs, which causes udev to be unable to start ("address 
> family not supported by protocol").
> 
> It should be adjusted to include it if possible.
> 
> I am using dracut-011 and had to set add_drivers+="unix" in dracut.conf to be 
> able to boot my system.
> 
> Kind regards,
> Dennis

Just add a file /etc/modprobe.d/myaliases.conf to your system, containing:
alias net-pf-1 unix
