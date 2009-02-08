From: Szabolcs Szakacsits <szaka-IyvsvuGDJ8VBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Sun, 8 Feb 2009 19:08:44 +0000 (UTC)
Message-ID: <loom.20090208T185018-19@post.gmane.org>
References: <20090206164019.GD552@redhat.com> <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com> <20090206165601.GF11144@nostromo.devel.redhat.com> <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com> <20090206173814.GA3541@nostromo.devel.redhat.com> <498C7AD8.6080105@intel.com> <2c0cae741a7229789cd777d93180072a.squirrel@neil.brown.name> <20090206200330.GB6150@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Bill Nottingham <notting@...> writes: 
> OK, so:
> 
> 1) kernel sends write request. If error....
> 2) <some error occurs>
> 3) kernel sends error to userspace
> 4) mdmon wakes up
> 5) mdmon decides where to record this
> 6) mdmon writes to super blocks
> 7) go to step one, hope you don't hit step 2 this time
> 
> This now means that reliable suspend and resume is completely
> impossible on RAID devices, just as it is on FUSE. 

It's not clear from the context but I suppose you mean only FUSE 
root file systems (e.g. what Ubuntu/WUBI has on NTFS via NTFS-3G).

One of the solutions is to apply the same mechanism what swapfiles 
use. That avoids user space completely. The suspend information 
go to a dynamically (userspace involved) and a statically (no 
userspace involved) allocated space on the suspend device.

Regards,  Szaka

--
NTFS-3G: http://ntfs-3g.org

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
