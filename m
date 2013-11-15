From: Nathanael Noblet <nathanael-sGhsi8tFlmY@public.gmane.org>
Subject: Re: ntpd to set clock prior to mount
Date: Thu, 14 Nov 2013 20:48:13 -0700
Message-ID: <5285997D.5090005@gnat.ca>
References: <CAF-o458j3=kA8FWMLzg9VSg-Pg5SrOjzPY4sN64U9kZv0i-j7g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAF-o458j3=kA8FWMLzg9VSg-Pg5SrOjzPY4sN64U9kZv0i-j7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Rex Vaughn <rvaughn-6nyMWi6rSIjR7s880joybQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/14/2013 04:23 PM, Rex Vaughn wrote:
> I have a set of machines that don't have battery backups for the real
> time clock. when the power is cycled on these machines, the real time
> clock resets to the BIOS epoch time which is usually a year or two in
> the past.  Each time I boot, I get fsck failure because the superblock
> time is in the future.  I am aware of the e2fsck configuration file
> that I can put into /etc with the broken_clock option, however I
> still get log files that have the time set in the past.  Having
> invalid times in the log files can make debugging boot problems very
> problematic.
>
> I have hacked together a dracut ntpd module that will set the time but
> it requires modifications to the network module to turn on the network
> even when netroot is not set.
So I'm looking at writing a module that requires network access but does 
not require netroot, so I'd be interested in any improvements to the 
network module that allowed for early networks.
