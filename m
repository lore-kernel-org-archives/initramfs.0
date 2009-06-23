From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: NFS why root=nfs and root=nfs4?
Date: Mon, 22 Jun 2009 23:48:00 -0400
Message-ID: <1245728880.13352.106.camel@obelisk.thedillows.org>
References: <4A3FF836.6080208@redhat.com>
	 <1245710475.13352.31.camel@obelisk.thedillows.org>
	 <4A402CEF.4030506@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A402CEF.4030506-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-22 at 21:16 -0400, Warren Togami wrote:
> On 06/22/2009 06:41 PM, David Dillow wrote:
> > root=nfs was a shortcut to root=/dev/nfs
> > root=nfs4 was a shortcut to root=/dev/nfs4, which is something I made up
> > when adding nfsroot support to dracut, as it seemed to have a certain
> > symmetry with the kernel's support for NFSv3.
> 
> With all due respect, I was hesitant to suggest strongly on this earlier 
> because it was against your opinion and you have been an important 
> contributor to this project.  It is of my opinion that having too many 
> ways of configuring the same behavior has too many drawbacks.  For 
> brevity I will not restate the many reasons why the Legacy nfsroot.txt 
> syntax is deprecated and it makes even less sense to invent additional 
> shortcuts that immediately become deprecated as well.

You'll notice I wasn't arguing to keep them -- I was answering your
question about why they exist. I've already given up on root=nfs[4] and
root=/dev/nfs4. While I am not in complete agreement, you at least have
a point that we shouldn't make up new ways in addition to our preferred
syntax and I'm tired of kicking that particular horse.

As for the many reasons nfsroot.txt syntax is deprecated, I can only
think of three that you have mentioned:
1) User confusion
2) Code complexity
3) Kernel-only support

We currently disagree on user confusion, and I think Phillipe and I have
shown that it need not add large amounts of complexity to translate the
legacy syntax into our preferred one. And you mentioned that debian
emulates the syntax.

Are there others? I apologize if you went over this before, as I dislike
asking other to repeat themselves as much as I like doing it myself. But
those are the reasons I found on the mailing list, and since my house
lost power while I was on vacation, my IRC logs are gone.

> If I had it my way, I would advocate dropping Legacy entirely including 
> the nfsroot.txt syntax and all netboot syntaxes supported (poorly) by 
> mkinitrd.  However it seems that a reasonable compromise is to tolerate 
> this particular legacy syntax because it is supported well by Debian's 
> initramfs-tools.

You've been advocating this even if you don't have it your way. ;)

I'll bow down to a good argument, or to consensus of the project if
there's no compelling argument either way. Get Harald to say they need
to go after hearing both sides and I'll help rip them out.

But if you don't mind, that discussion should happen here on the list.
While IRC is a good place to discuss details and brainstorm, policy
discussions need to have a more permanent record; making those kind of
decisions via IRC excludes those who happen to not be in the room at the
right time, and offers no insight as to why things are the way they are
to late comers to the project.

> This is a difference in design philosophy.  We have a native syntax that 
> seems fully feature capable.  Allowing redundancy and variation in this 
> syntax can confuse people less technically savvy than us who follow 
> documentation and examples.

The people that do "config by example" are going to find the old HOWTOs
that discuss using nfsroot.txt syntax. A current search for "linux nfs
root" returns the NFS-root mini-HOWTO (circa 1996) and
Diskless-root-NFS-other-HOWTO (circa 2001) as the top two results. In
fact 5 of the top 6 results refer to the nfsroot.txt syntax and the
sixth one refers one to the NFS-root mini-HOWTO for the kernel command
line setup.

Now, some of those also talk about configuring and compiling your kernel
to support NFS root, which if followed means dracut would not be used.
But I've known more than one config-by-example person that would just
try the command line argument on the assumption the the distro kernel
would have that built in. I do not know the percentage of the population
that would do this, so I don't know which way the argument cuts.

> A strong argument against this is only if it can be pointed out that a 
> feature is not capable under the native syntax.

Another one is if the examples they are going to find are going to be
the legacy ones.

In the HOWTO, README. and examples we provide, we should describe and
show the preferred method, and point to a different section that
documents the legacy methods, but marks them clearly as such. No
examples need be given, as if you are using the legacy methods you
should know what they look like.

I've put this idea forward a few times now, and it seems to get ignored
or brushed aside with hand-waving. If it won't work, give me some
reasoned discussion as to why. I don't buy that the users are going to
be confused by all the legacy syntax variants because as I've shown
above, that's the examples I expect they will find.

Or is this both of us arguing from our gut and we'll have to disagree
until Harald lays down the law about syntactic support?


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
