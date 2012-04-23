From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount
 option
Date: Mon, 23 Apr 2012 12:09:01 +0800
Message-ID: <1335154141.18028.11.camel@cr0>
References: <20120418222829.GG2224@redhat.com> <4F8FD3E5.90103@redhat.com>
	 <1334904333.20684.23.camel@cr0> <4F91217A.6080905@redhat.com>
	 <20120420155143.GK22419@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120420155143.GK22419-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Fri, 2012-04-20 at 11:53 -0400, Vivek Goyal wrote:
> On Fri, Apr 20, 2012 at 10:42:34AM +0200, Harald Hoyer wrote:
> 
> [..]
> > >> Why is it "-m kdumpbase" and not "--add kdumpbase" ???
> > > 
> > > I thought "--add" is plus for "-m", so the initial module has to be
> > > added via "-m" in cmdline? Seems I was wrong, but could this be the
> > > reason that causes iscsi module not loaded?
> > > 
> > > Thanks!
> > > 
> > 
> > You can send me the output of dracut with the "--debug" option added to inspect
> > it further.
> 
> Hi Harald,
> 
> I ran dracut from command line (could not figure out how to capture the
> output of service to a file with systemd) and captured the output of
> --debug with "-m kdumpbase" and "--add kdumpbase".
> 
> For some reason it was complaining that module kdumpbase not found but
> I see that it is present in /lib/dracut/modules.d. Anyway, I am attaching
> both the outputs for you to have a look. Files are gzipped as they were
> big.

Just fyi, that is because kdump module checks an env variable at start,
so you can use 'kdumpctl start' to run it manually instead of using
dracut directly. :)
