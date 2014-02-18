From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: kdump in dracut
Date: Tue, 18 Feb 2014 06:45:15 -0500
Message-ID: <20140218114515.GA12633@redhat.com>
References: <1644005.SfM4K48qYX@skinner>
 <20140218034132.GG18964@dhcp-17-89.nay.redhat.com>
 <1745934.e2BrRKeI5B@skinner>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1745934.e2BrRKeI5B@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Julian Wolf <juwolf-l3A5Bk7waGM@public.gmane.org>, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Tue, Feb 18, 2014 at 11:58:38AM +0100, Thomas Renninger wrote:
> On Tuesday, February 18, 2014 11:41:32 AM WANG Chao wrote:
> > CC Vivek, Bao
> > 
> > On 02/17/14 at 04:10pm, Thomas Renninger wrote:
> > > Hi,
> > > 
> > > it looks like Redhat has made up their own kdump dracut module
> > > in the kexec-tools Fedora package:
> > > http://pkgs.fedoraproject.org/cgit/kexec-tools.git/tree/
> > > 
> > > dracut-kdump.sh
> > > dracut-module-setup.sh
> > > dracut-monitor-dd-progress.sh
> > > 
> > > I wonder whether there are any plans to get those into the
> > > dracut mainline git repository.
> > 
> > Hi, Thomas
> > 
> > AFAICT, we don't have any plan to move these files into dracut.
> > We want to maintain these files separately, because kdump initrd serves
> > for a different purpose comparing to a normal initrd created by dracut
> > by default. Basically we are reusing the dracut framework to achieve our
> > own purpose (kdump).
> "Own" purpose sounds strange. Kdump is something every distribution has
> or should have.
> I also do not understand the "kdump initrd serves for a different purpose"
> argue.
> Dracut is made to build an initrd for any purpose?
>  
> > > Otherwise we (SUSE) and others will have to come up with our
> > > own implementations and we are where we do not want to end up:
> > > Different initrd implementations, setups, configurations across
> > > Linux distributions.
> > 
> > This kdump module is highly associated with other scripts we provide in
> > our kexec-tools package. What's the worse is that some parts are
> > hardcoded for Fedora.
> 
> That's bad.
> The stuff should (at least in dracut git repo) be compatible with:
> ftp://kernel.org/pub/linux/utils/kernel/kexec
> https://sourceforge.net/projects/makedumpfile
> and other mainline projects.
> We also had some specialities implemented in our mkinitrd solution.
> But it should not be hard to put a basic dracut kdump module together
> which is compatible.

Hi Thomas,

I think in general sharing code is a good idea. Though kdump as a
mechanism is common across distributions but when it comes to user
space tooling around it, every distributions went their own way. All
the init scripts, configuration files, all graphical configuration
utilities etc.

In fact, IIRC, initially SuSE had taken the approach of dumping to
Swap (like LKCD) instead of dumping from initramfs to various kind
of targets and then recover dump from swap over next reboot. But that
was long ago and things might have changed since then.

Given the fact that we developed all user space tooling in isolation,
current dracut module is closely tied to configuration options we provide
in /etc/kdump.conf. And it might be very different on SuSE. One simple
example is "default" action. Which specifies what action to take if
saving dump to intended target fails. 

In fact almost all the code of kdump dracut module seems to be cosely
tied to /etc/kdump.conf. Parsing various options and making sure that
these user specified options can be executed. 

So if there is a common dracut module, that most likely will mean to
have some kind of common understanding on what various constructs mean
in /etc/kdump.conf.

Hence, I think first we will have to figure out what functionality we
are expecting to have in that common kdump dracut module and how to
come up with some common understanding on /etc/kdump.conf which tweaks
the behavior of kdump module.

So personally, I am not opposed to the idea of having common dracut
module code in dracut repository. I think it is a good idea to have
common code base which can be used by other distributions too. It just
means more people can contribute to that common code and make it even
better.

Thanks
Vivek
