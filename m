From: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/1] Convert MAC in BOOTIF parameter to lower case
Date: Wed, 27 Jun 2012 20:33:14 +1000
Message-ID: <20120627203314.2e0136c1@kryten>
References: <4FEA00BC.8090505@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FEA00BC.8090505-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Srinivasa T N <seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi,

> The patch at
> http://comments.gmane.org/gmane.linux.kernel.initramfs/2244 takes
> care of only the MAC conversion to lower case in the interface name.
> But the same has to be taken care for BOOTIF also.  This patch takes
> care of changing the BOOTIF to lower case.
> 
> Note that sed has been used instead of tr, as dracut does not install
> tr to the initramfs, atleast on RHEL 6.x.

Good to know, could you replace the existing interface MAC conversion
with sed too?

Thanks,
Anton
