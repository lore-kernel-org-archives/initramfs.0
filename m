From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Sat, 20 Dec 2008 13:22:54 -0500
Message-ID: <20081220182254.GA2996@redhat.com>
References: <1229540094.28858.150.camel@aglarond.local> <20081217190700.GA15377@infradead.org> <4949FD67.6040906@suse.de> <494B5031.5080306@bfh.ch> <20081219091841.207bc951@kopernikus.site> <494BA7CE.2020007@suse.de> <20081219152708.GE9871@mit.edu> <9C4F1B7D-CCBC-48D7-8624-9A7C314C1590@redhat.com> <87skojrm5e.fsf@rimspace.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87skojrm5e.fsf-zvVxMF7wGoXk1uMJSBkQmQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Pittman <daniel-zvVxMF7wGoXk1uMJSBkQmQ@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Theodore Tso <tytso-3s7WtUTddSA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Dec 21, 2008 at 12:50:21AM +1100, Daniel Pittman wrote:

 > One of the features of the Debian / Ubuntu initramfs infrastructure,
 > which sounds remarkably like your design (or vice-versa), is that it
 > drops all the "standard" drivers into the initramfs.
 > 
 > This is, to me, worth several minutes of additional boot time, in terms
 > of flexibility: being able to modify the hardware and be confident that
 > the appropriate drivers are in place already makes life much, much
 > easier.

There's another reason this is really useful.
If something goes wrong, remotely debugging a users initrd right is
a lot easier if you know what it looks like.  Right now, in Fedora for eg,
where we generate an initrd for each users system at runtime, we need
to get a copy of the generated initrd, and pull it apart just to find
out what modules ended up in there, what didn't, and then somehow
try to work backwards to try and figure out how the generator got into
that state.  After doing this for five years, let me tell you it's
_really_ _really_ painful.

 > (In practice I doubt this adds more than a second or five to boot time;
 >  certainly, it takes no longer to get to rootfs mounted than the RHEL 4
 >  systems that have nothing but what is essential in the initrd...)

At least in theory, with a kernel-event/udev driven system, the additional
modules shouldn't cause any additional boot time. There wouldn't be
events generated to cause them to be loaded, so they'd just be taking
up space.  And the additional load time for a bigger initrd should be
really lost in the noise of the overall boot.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
