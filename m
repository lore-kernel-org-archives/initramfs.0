From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: test suite work
Date: Fri, 05 Jun 2009 00:32:34 -0400
Message-ID: <1244176354.29842.1.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I've fixed up the NFS tests to work with the framework, and also set
things up so you can easily test with a different kernel than you are
running. Also, getting the NFS test working revealed that we need grep
for the NFS module, so I fixed that as well.

I'll reply with the patches, or you can get them at
http://thedillows.org/dracut.git

Dave

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
