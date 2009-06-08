From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH 00/11] More test suite stuff (and bug fixes)
Date: Mon, 08 Jun 2009 00:42:44 -0400
Message-ID: <1244436164.23139.8.camel@obelisk.thedillows.org>
References: <cover.1244435634.git.dave@thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2009-06-08 at 00:40 -0400, David Dillow wrote:
> This add more comprehensive tests to the NFS test suite, such as
> verifying that we used the right server IP address, and that we
> added mount options appropriately. It may be a bit too comprehensive,
> as it takes over 7 minutes to run for me.
> 
> Also of note, I addded support for a default NFS path and %s
> substitution as done by the kernel's nfsroot handling.
> 
> This also has the first round of testing for NBD root, and a fix
> for a bug found by the test suite.

Of course, I forgot to mention that this series is based on the one I
posted Saturday morning.

You can get all of the changes at http://thedillows.org/dracut.git

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
