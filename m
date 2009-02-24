From: Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 14:40:24 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0902241430270.22015@kenzo.iwr.uni-heidelberg.de>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
  <49A301FF.2090303@redhat.com> <1235434056.28090.28.camel@sentry-no.fnordovax.org>
 <49A3AB75.1010805@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49A3AB75.1010805-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 24 Feb 2009, Seewer Philippe wrote:

> Though I see a small problem: Ever thought about what happens if 
> there are multiple interfaces on different networks? Only one is 
> valid to mount the root-fs...

The Debian initramfs-tools documents as following here the rule from 
the kernel's nfsroot.txt which allows an ip=... kernel command line 
parameter which can contain the name of the device. Is this an option 
that would fit your purpose ?

From what I know, there is no automated way to get that information 
automatically in the format described, so you'd have to maintain it, 
possibly in a PXE config file; it's possible to find out what 
interface was used for PXE booting when using PXELINUX with the 
'IPAPPEND 2' option which will add a BOOTIF=mac_address to the kernel 
command line.

This might however not be enough: there could be a case where the 
booting (via PXE) is done on a different network (and interface) than 
the one where the root NFS is exported. I know that this sounds 
complicated, but it has been implemented in real life ;-)

-- 
Bogdan Costescu

IWR, University of Heidelberg, INF 368, D-69120 Heidelberg, Germany
Phone: +49 6221 54 8240, Fax: +49 6221 54 8850
E-mail: bogdan.costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
