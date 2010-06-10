From: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Subject: Re: dracut and multiple iscsi/network disks
Date: Thu, 10 Jun 2010 09:06:47 +0200
Message-ID: <20100610070647.GA23726@maude.comedia.it>
References: <4C0FB779.30005@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C0FB779.30005-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Jun 09, 2010 at 05:47:05PM +0200, Harald Hoyer wrote:
> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=commitdiff;h=169f16715145fd087d61ef7fdfd7e9a3cbb68fc9
>
> adds support for multiple iscsi disks with the syntax:
>
> root=<normal block path or UUID or LABEL>  \
> netroot=iscsi:...  netroot=iscsi:... netroot=iscsi:...
>
> which is suboptimal, because you can't specify it in the dhcp protocol.
>
> A better syntax would be a single netroot (also for FCoE disk) something like:
>
> netroot=netdisks:iscsi:...[separator]iscsi:...[separator]fcoe:...
>
be warned that DHCP option format is generally
code: 1 byte
lenght: 1 byte
data: lenght bytes

which would limit the lenght of the netroot string to 255 charachters
anyway.

L.

-- 
Luca Berra -- bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org
          Communication Media & Services S.r.l.
   /"\
   \ /     ASCII RIBBON CAMPAIGN
    X        AGAINST HTML MAIL
   / \
