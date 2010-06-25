From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut modules
Date: Fri, 25 Jun 2010 13:21:03 +0200
Message-ID: <4C24911F.4010503@redhat.com>
References: <loom.20100624T143213-57@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20100624T143213-57-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Stone <fsck1234-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/24/2010 02:38 PM, Dave Stone wrote:
> Hi everyone.  Are there any documents describing how to add new modules
> to /usr/share/dracut/modules.d?  I have looked at what is available with RHEL6
> Beta 1 version.  I would need to insert my own drivers before lvm.
> Thanks in advance for your help.
>
> -Dave
>

own drivers == kernel driver modules?

/etc/dracut.conf:

# additional kernel modules to the default
#add_drivers+=""

or put it in /etc/dracut.conf.d/mykernelmodules.conf
add_drivers+=" mykernelmodule "


or put it on the kernel command line (see man dracut):

rdloaddriver=<drivername>
      force loading kernel module <drivername> This parameter can be specified 
multiple times.
