From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Tainting the initrd
Date: Thu, 19 Feb 2009 16:56:20 +0530
Message-ID: <t7sv66-dk4.ln1@news.researchut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I hope it is not too late to discuss this problem.
I have a bugzilla filed for this, filed here:
https://bugzilla.redhat.com/show_bug.cgi?id=435033

The problem described in the above bugzilla entry is about "How do we 
authenticate initrd images"
We sure have a huge dependency on the initrd. And day-by-day that dependency 
is increasing. Multipath SAN Boot, NFS et cetera all depend on the proper 
execution of an initrd image.

We see a lot of problems in the SAN space, where users end up shuffling among 
2 versions of HBA drivers. One from the OS Vendor, the other from the HBA 
vendor. And then we see IHVs and ISVs using their own set of utils to tamper 
the initrd. This is just an example.

Currently, we don't have a way to identify, like what initrd image has the 
OS booted from. And we don't have a way to verify whether the initrd image 
from which the OS has booted from (and ended up with a bug), is the same 
initrd image that the OS vendor generates.

Since this is a re-write effort, I'd like to know opinions here.
* Do we see this situation as a problem ?
* If yes, how can we overcome it ?

I have some proposals listed in the bugzilla, but all are half-baked. I hope 
with your help, we can come up with a better approach. Probably, we just 
need a set of strict and enforcing assumptions.

Ritesh
-- 
If possible, Please CC me when replying. I'm not subscribed to the list.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
