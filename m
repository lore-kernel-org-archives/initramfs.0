From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Dracut generation modes
Date: Thu, 28 May 2009 14:58:07 -0400
Message-ID: <4A1EDEBF.4080009@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

So this might not have been clear earlier, but stating it on the list to 
be sure everyone is on the same page.

* Default Dracut
Dracut without any parameters should generate an initrd image capable of 
booting a generic machine.  This means it must not detect anything of 
the current running system to determine what to install in the image. 
This includes stuff in /proc, /sys, lsmod, /proc/mounts and possibly more.

By necessity, stuff in the filesystem are usable to dracut in 
determining what to install in the image.

* --hostonly mode
Host only mode is permitted to use runtime detection to generate an 
image capable of booting the current system.  What exactly does this 
mean?  Is this primarily for smaller sizes by avoiding irrelevant modules?

* (Some other generation mode)
Perhaps we need more generation modes for other purposes.  One likely 
case is where you need to generate a machine specific image for a 
non-local system.  A combination of command line options and/or .conf 
file would define the dracut image for a non-local system.  This might 
be necessary for cases like:

- netboot initrd needs to be as small as possible for resource 
constraint reasons
- embedded systems with resource constraints
- certificates or passwords for iscsi or kerberized nfs

How should this mode be specified from the command line?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
