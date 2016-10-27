From: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC/PATCH] Give --persistent_policy precedence over
 /dev/mapper names
Date: Thu, 27 Oct 2016 09:18:30 +0200
Message-ID: <1477552710.3553.1.camel@suse.de>
References: <20161005121303.31582-1-mwilck@suse.de>
         <e8384369-a93f-63b1-9422-21c9d5bce657@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e8384369-a93f-63b1-9422-21c9d5bce657-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Harald,

thanks for your reply.

On Wed, 2016-10-26 at 13:45 +0200, Harald Hoyer wrote:
> On 05.10.2016 14:13, Martin Wilck wrote:
> > There is currently no way to override dracut's preference for
> > /dev/mapper device names. But using these is problematic in
> > different scenarios: For example, if a user has a multipath-
> > enabled system but wants to disable multipath, or if the
> > names of multipath maps change because of configuration changes
> > (e.g. toggling user_friendly_names in /etc/multipath.conf).
> > 
> > This patch makes dracut prefer the user-specified
> > --persistent_policy names over /dev/mapper names.
> > 
> > It might be worthwhile to discuss why dracut prefers /dev/mapper
> > of /dev/disk/by-uuid at all. This preference was introduced
> > in 9037b63e with the argument "dm devices maintain /dev/mapper/* as
> > persistent names", but that's wrong for the scenarios mentioned
> > above, and is not a compelling reason for preferring /dev/mapper
> > over /dev/disk/by-uuid.
> > 
> > 
[...]

> 
> looks good to me.
> I would even do:
> <https://github.com/dracutdevs/dracut/pull/166/files>
> in PR
> <https://github.com/dracutdevs/dracut/pull/166>
> 
> Which lets us set persistent_policy to something like:
> persistent_policy="mapper by-uuid by-label"
> or
> persistent_policy=(by-label by-id by-path by-partuuid)
> 
> What do you think?

That patch needs a fix, because /dev/disk/mapper doesn't exist. I
commented on github.

IMO, being able to override only the first choice would be sufficient
for almost every use case. But of course it doesn't hurt to have the
option to customize more, either ... I'm uncertain.

I'd rather like to discuss the default again, which your patch leaves
at "mapper". As I argued before, I think "by-uuid" would be the better
choice. The awareness level for the "persistent_policy" option is low
among users, few people are likely to use it. The default should be
such that only the strangest setups out there should create a need to
change it. 

Thus I'd like to know why "mapper" should continue to be favored over
UUID-based policy in the future. The obvious advantage of the UUID-
based approach for multipath setups is that it enables booting even if
multipathd fails or refuses to set up the map (think of a setup using
the "find_multipaths" option, where only a single path is up during
boot).

Best Regards,
Martin
