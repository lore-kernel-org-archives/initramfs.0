From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 09:45:44 -0500
Message-ID: <49A40818.1000209@redhat.com>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>	 <49A301FF.2090303@redhat.com>  <49A3A924.9000003@bfh.ch> <1235474964.28090.53.camel@sentry-no.fnordovax.org> <49A3E70D.9050006@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49A3E70D.9050006-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: 
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Seewer Philippe wrote:
> 
> Question: Do you we want to agree on a specific scheme for setting root 
> options? I'm thinking (for example) about having one initramfs for both 
> nfsroot and nbdroot.
> 

This is exactly what I proposed.  If root=dhcp is given as a kernel 
cmdline from the bootloader, the initrd brings up the ethernet 
interface, dhclient, parses the output, and mounts whatever is defined 
in DHCP root-path parameter.  Fedora 10+ mkinitrd does this today.

Alternatively, root= can explicitly define a root-path in exactly the 
same syntax that it would get from DHCP root-path.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
