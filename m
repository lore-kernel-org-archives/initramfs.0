From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Dracut -- Cross distribution initramfs infrastructure
Date: Wed, 17 Dec 2008 13:54:54 -0500
Message-ID: <1229540094.28858.150.camel__36712.7056736082$1232286216$gmane$org@aglarond.local>
Reply-To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org

As davej started talking about a few months ago at Kernel Summit and
LPC, there's a lot of duplication between distros on the tools used to
generate the initramfs as well as the contents and how the initramfs
works.  Ultimately, there's little reason for this not to be something
that is shared and worked on by everyone.  Added to this is the fact
that everyone's infrastructures for this have grown up over a long-ish
period of time without significant amounts of reworking for the way that
the kernel and early boot works these days.

Therefore I've started on a new project, dracut, to try to be a new
initramfs tool that can be used across various distributions.  From the
README...

Unlike existing initramfs's, this is an attempt at having as little as
possible hard-coded into the initramfs as possible.  The initramfs has
(basically) one purpose in life -- getting the rootfs mounted so that we
can transition to the real rootfs.  This is all driven off of device
availability.  Therefore, instead of scripts hard-coded to do various
things, we depend on udev to create device nodes for us and then when we
have the rootfs's device node, we mount and carry on. This helps to keep
the time required in the initramfs as little as possible so that things
like a 5 second boot aren't made impossible as a result of the very
existence of an initramfs.  It's likely that we'll grow some hooks for
running arbitrary commands in the flow of the script, but it's worth
trying to resist the urge as much as we can as hooks are guaranteed to
be the path to slow-down.

Also, there is an attempt to keep things as distribution-agnostic as
possible.  Every distribution has their own tool here and it's not
something which is really interesting to have separate across them. So
contributions to help decrease the distro-dependencies are welcome.

The git tree can be found at git://fedorapeople.org/~katzj/dracut.git
for now.  See the TODO file for things which still need to be done and
HACKING for some instructions on how to get started using the tool.
There is also a mailing list that is being used for the discussion --
initramfs-u79uwXL29TaiAVqoAR/hOA@public.gmane.org  

Currently, there are a few Fedora-isms which have crept in just as a
result of it being the shortest path to solving some problems, but I'm
actively trying to get those out sooner rather than later as well as
getting to where I'm using it to boot my laptop.

Comments and discussion welcome

Jeremy

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
