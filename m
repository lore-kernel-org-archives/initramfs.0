From: Florian Feldhaus <florian.feldhaus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut fails to install libraries on Debian / Ubuntu systems
Date: Mon, 4 Feb 2013 13:58:35 +0000 (UTC)
Message-ID: <loom.20130204T140305-929@post.gmane.org>
References: <loom.20130204T110507-984@post.gmane.org> <CAGEveXp94E6HAQjcC+ETp1ipR5BKC+V-46Nv6yr68U5PkvwPow@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Jon Ander Hernandez <jonan.h@...> writes:

> 
> 2013/2/4 Florian Feldhaus <florian.feldhaus@...>:
> > Due to the multiarch approach of debian [1] some libraries such as
> > libnss_files* are not located in /lib64 but instead in
> > /lib/x86_64-linux-gnu . As the dracut function inst_libdir_file() only
> > searches in the /lib and /lib64 folders without checking their
> > subfolders, some required libraries are not included on Debian / Ubuntu
> > systems. There is an unsolved bug report on Ubuntu launchpad from 2011
> > with more details [2].
> >
> > I would like to propose two different solutions and be glad to create a
> > patch for one of them, as soon as I could get some feedback what
> > approach would be best:
> > 1) Include /lib/x86_64-linux-gnu when detecting the libdirs in
> > dracut-functions.sh
> > 2) Change inst_libdir_file() to recursively search the lib folders for
> > the required libraries e.g. by using the find utility
> >
> > I would be glad if we could solve this issue, as it blocks using dracut
> > with NFSv3 on Debian / Ubuntu systems.
> 
>
http://git.kernel.org/?p=boot/dracut/dracut.git;a=commit;h=c9143a63fef0d6f2dfd7cc37b09fc68d744d900f

Thanks for the link. I wasn't aware of the paramter --libdirs, probably 
as it is not shown when calling dracut --help. Besides that, I expected 
that dracut would by default search all relevant lib locations for 
Debian.

I will try to create a patch for updating the help and the 
documentation. 

Is there a reason why /lib/x86_64-linux-gnu is not 
included by default in the libdirs?
