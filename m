From: Rex Vaughn <rvaughn-6nyMWi6rSIjR7s880joybQ@public.gmane.org>
Subject: Re: ntpd to set clock prior to mount
Date: Fri, 15 Nov 2013 09:52:44 -0500
Message-ID: <CAF-o4588To4AYj08RtxD+569J=LQ6gRNZ=jek5otvcArxJUPGw@mail.gmail.com>
References: <CAF-o458j3=kA8FWMLzg9VSg-Pg5SrOjzPY4sN64U9kZv0i-j7g@mail.gmail.com>
	<5285997D.5090005@gnat.ca>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+B+3U3Xvx17NogVDvXjatXHB14NwfXoXOrWBd7Ss9JA=;
        b=1E5BXYtmlyxUXFq9C0yZfSJ9TVNlO2CBwpLL+8Gc7jjMbFrDeg3lgWrrTQzAM0nzKF
         3kCk7PbwHOighW6J68f+aVsuwxHRxQXhE0fxJU90cJTpY2QpJ3rlN0ztIdIEl63XcrcU
         NIfB/3nRJxr74P7Y6ZVlILpwFmVuSpvhM3a8hj//12WzFR8rzfrDWjsXP6xiC2HMIu9D
         MobGrowfeySaKmcy7/xX/fByggu5uLRuaqknbRTKULObgSMdteWLnfZDYH3jJJYe3bN3
         INsRdOo++myunynp3WD/AYrGtSGlNNUtejeJ7zqjyEZsFe+Jh/erHVAUVJbVCyzPG/am
         DaSg==
In-Reply-To: <5285997D.5090005-sGhsi8tFlmY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathanael Noblet <nathanael-sGhsi8tFlmY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>
> So I'm looking at writing a module that requires network access but does not
> require netroot, so I'd be interested in any improvements to the network
> module that allowed for early networks.
>

I am running RHEL6.4 which uses dracut-004, in that version I
commented out the checks for netroot in parse-ip-opts.sh, ifup, and
net-genrules.sh and in netroot I commented out the netroot check at
the top and delayed the netroot check at the bottom to right before
source_all netroot.  I will post patch files in a second post.  I
decided to look at dracut-034 to see what changes would be necessary
there, and those lines have changed to seemingly allow network in more
conidtions than 004 did, but I have not figured out if those
conditions are sufficient for me to turn on the network with a simple
command line option.

here are the patches I made to dracut-network-004-303.el6.noarch (from
the RHEL6.4 distro):
*** ./ifup
--- ./ifup
***************
*** 121,127 ****
  [ -f "/tmp/net.$netif.up" ] && exit 0
  [ -f "/tmp/root.info" ] || exit 0
  . /tmp/root.info
! [ -z "$netroot" ] && exit 0

  # loopback is always handled the same way
  if [ "$netif" = "lo" ] ; then
--- 121,127 ----
  [ -f "/tmp/net.$netif.up" ] && exit 0
  [ -f "/tmp/root.info" ] || exit 0
  . /tmp/root.info
! #[ -z "$netroot" ] && exit 0

  # loopback is always handled the same way
  if [ "$netif" = "lo" ] ; then

*** ./parse-ip-opts.sh
--- ./parse-ip-opts.sh
***************
*** 17,28 ****
  . /lib/dracut-lib.sh

  # Check if ip= lines should be used
! if getarg ip= >/dev/null ; then
!     if [ -z "$netroot" ] ; then
!       echo "Warning: No netboot configured, ignoring ip= lines"
!       return;
!     fi
! fi

  # Don't mix BOOTIF=macaddr from pxelinux and ip= lines
  getarg ip= >/dev/null && getarg BOOTIF= >/dev/null && \
--- 17,28 ----
  . /lib/dracut-lib.sh

  # Check if ip= lines should be used
! #if getarg ip= >/dev/null ; then
! #    if [ -z "$netroot" ] ; then
! #     echo "Warning: No netboot configured, ignoring ip= lines"
! #     return;
! #    fi
! #fi

  # Don't mix BOOTIF=macaddr from pxelinux and ip= lines
  getarg ip= >/dev/null && getarg BOOTIF= >/dev/null && \

*** ./net-genrules.sh
--- ./net-genrules.sh
***************
*** 14,20 ****
  }

  # Don't continue if we don't need network
! [ -z "$netroot" ] && return;

  # Write udev rules
  {
--- 14,20 ----
  }

  # Don't continue if we don't need network
! #[ -z "$netroot" ] && return;

  # Write udev rules
  {

*** ./netroot
--- ./netroot
***************
*** 13,19 ****
  [ -e /tmp/root.info ] || exit 1
  . /tmp/root.info
  [ -d $NEWROOT/proc ] && exit 0
! [ -z "$netroot" ] && exit 1

  # Let's see if we have to wait for other interfaces
  # Note: exit works just fine, since the last interface to be
--- 13,19 ----
  [ -e /tmp/root.info ] || exit 1
  . /tmp/root.info
  [ -d $NEWROOT/proc ] && exit 0
! #[ -z "$netroot" ] && exit 1

  # Let's see if we have to wait for other interfaces
  # Note: exit works just fine, since the last interface to be
***************
*** 65,73 ****
  handler=${netroot%%:*}
  handler=${handler%%4}
  handler="/sbin/${handler}root"
- if [ -z "$netroot" ] || [ ! -e "$handler" ] ; then
-     die "No handler for netroot type '$netroot'"
- fi

  # We're here, so we can assume that upping interfaces is now ok
  [ -z "$IFACES" ] && IFACES="$netif"
--- 65,70 ----
***************
*** 96,101 ****
--- 93,102 ----
      esac
  fi
  [ -n "$dest" ] && arping -q -f -w 60 -I $netif $dest
+
+ if [ -z "$netroot" ] || [ ! -e "$handler" ] ; then
+     die "No handler for netroot type '$netroot'"
+ fi

  # Source netroot hooks before we start the handler
  source_all netroot
