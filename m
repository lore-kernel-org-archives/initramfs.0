From: Rex Vaughn <rbvaughn.misc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ntpd to set clock prior to mount
Date: Fri, 15 Nov 2013 15:49:28 +0000 (UTC)
Message-ID: <loom.20131115T160349-696@post.gmane.org>
References: <CAF-o458j3=kA8FWMLzg9VSg-Pg5SrOjzPY4sN64U9kZv0i-j7g@mail.gmail.com> <l657h9$b13$1@ger.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Colin Guthrie <gmane@...> writes:

 
> While I appreciate you don't have a question as such, I should really
> point out that for e2fsck to complain like this is totally broken. It
> should be fixed upstream so the config file is just a hack at best.
> Relying on system clocks for any kind of mount check is just
> fundamentally broken.
> 
> Anyway, back to the case in point, if debugging is your main problem
> then systemd-journal is likely the best course of action. It will allow
> you to present your logs in such a way that the timestamp is monotonic
> from the boot time and thus has no relation to wall-clock time in any
> shape or form.
> 
> This is much better for ordering or messages and such like.
> 
> Requiring ntp and thus working network links etc. seems vastly overkill
> here if all you need is to sort out the time.
> 

Since I am running into problems with e2fsck and no battery backup on the
clock, I totally agree with you that the system clock check is fundamentally
broken. :-)

My application requires network access and accurate time in order to
function properly, but I suppose in the strictest sense I don't need the
time set prior to the root filesystem being mounted.  I could wait until
after boot and ensure that the clocks are set at that time.  

As to the debugging, I am more concerned with a system that goes out to a
customer, they run into a problem and tell us the problem started on date x,
now I need to go into the logs and find the date time that the problem occurred.

Thank you for your input, it is appreciated.

RBV


