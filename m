From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 33/33] nfs: Add ip=... and root=nfs... parameters to internal dracut
Date: Fri, 21 Nov 2014 11:34:40 +0100
Message-ID: <1536472.dhthQso2R4@skinner>
References: <1416495428-36978-1-git-send-email-trenn@suse.de> <1416495428-36978-34-git-send-email-trenn@suse.de> <546F0546.8080007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <546F0546.8080007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: hare-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Friday, November 21, 2014 10:26:30 AM Harald Hoyer wrote:
> On 20.11.2014 15:57, Thomas Renninger wrote:
...
> > -        mount.nfs4 umount rpc.idmapd sed /etc/netconfig
> > +        mount.nfs4 umount rpc.idmapd sed /etc/netconfig host sed
> 
> Why "host" and "sed" ?? Just because it's used in cmdline() does not mean it
> has to be installed in the initramfs?
Right and sed is already added anyway.
Corrected version will show up on re-submit.

Thanks,

      Thomas
