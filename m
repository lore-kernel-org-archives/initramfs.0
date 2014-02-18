From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: kdump in dracut
Date: Tue, 18 Feb 2014 11:41:32 +0800
Message-ID: <20140218034132.GG18964@dhcp-17-89.nay.redhat.com>
References: <1644005.SfM4K48qYX@skinner>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1644005.SfM4K48qYX@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Julian Wolf <juwolf-l3A5Bk7waGM@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

CC Vivek, Bao

On 02/17/14 at 04:10pm, Thomas Renninger wrote:
> Hi,
> 
> it looks like Redhat has made up their own kdump dracut module
> in the kexec-tools Fedora package:
> http://pkgs.fedoraproject.org/cgit/kexec-tools.git/tree/
> 
> dracut-kdump.sh
> dracut-module-setup.sh
> dracut-monitor-dd-progress.sh
> 
> I wonder whether there are any plans to get those into the
> dracut mainline git repository.

Hi, Thomas

AFAICT, we don't have any plan to move these files into dracut.
We want to maintain these files separately, because kdump initrd serves
for a different purpose comparing to a normal initrd created by dracut
by default. Basically we are reusing the dracut framework to achieve our
own purpose (kdump).

> Otherwise we (SUSE) and others will have to come up with our
> own implementations and we are where we do not want to end up:
> Different initrd implementations, setups, configurations across
> Linux distributions.

This kdump module is highly associated with other scripts we provide in
our kexec-tools package. What's the worse is that some parts are
hardcoded for Fedora.

Thank you for bringing this up. It's really not my call. I'd like to
hear from others in our team. And an ACK from Harald is also a must.

Thanks
WANG Chao
