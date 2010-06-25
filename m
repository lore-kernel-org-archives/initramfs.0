From: Dave Stone <fsck1234-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut modules
Date: Fri, 25 Jun 2010 13:53:49 +0000 (UTC)
Message-ID: <loom.20100625T153101-235@post.gmane.org>
References: <loom.20100624T143213-57@post.gmane.org> <4C24911F.4010503@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald Hoyer <harald@...> writes:

> 
> On 06/24/2010 02:38 PM, Dave Stone wrote:
> > Hi everyone.  Are there any documents describing how to add new modules
> > to /usr/share/dracut/modules.d?  I have looked at what is available with 
RHEL6
> > Beta 1 version.  I would need to insert my own drivers before lvm.
> > Thanks in advance for your help.
> >
> > -Dave
> >
> 
> own drivers == kernel driver modules?
> 
> /etc/dracut.conf:
> 
> # additional kernel modules to the default
> #add_drivers+=""
> 
> or put it in /etc/dracut.conf.d/mykernelmodules.conf
> add_drivers+=" mykernelmodule "
> 
> or put it on the kernel command line (see man dracut):
> 
> rdloaddriver=<drivername>
>       force loading kernel module <drivername> This parameter can be 
specified 
> multiple times.
> 

Thanks for the responses guys.  I have read the REDAME file and other related 
docs.  I think my first inquiry was not sufficient so I'll try to explain a 
little better.

What I'm trying to do is to insert a third party multi-pathing package before 
root "/" is mounted.  This needs to be done in BFS(boot from SAN) 
environment.  The equivalent of this with SLES11 was to write 71-setup-MP.sh 
and 21-boot-MP.sh scripts.  Then use mkinitrd with -f to add this new feature 
to the initrd image.  I need to simulate the same setup and boot scripts to do 
the same thing for RHEL6.

I assume this is possible with dracut.  I also think I need to use pre-mount 
hook to do this.  I'm still not sure of what I should use for two digit 
numeric code.

One other question when using rdloaddriver=<drivername> at what stage of boot 
process does this driver gets loaded?  

Regards,
-Dave



