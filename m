From: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Subject: Re: NFS root with Dracut not calling nfsroot script
Date: Tue, 05 Oct 2010 10:56:57 +1100
Message-ID: <20101005105657.11522adk3xakzt1c@webmail.zoltak.com>
References: <20101002062617.5730102kmedzh6uo@webmail.zoltak.com>
 <20101004152252.15833xc2gkzz1mdc@webmail.zoltak.com>
 <4CA9998F.7060701@redhat.com>
 <20101004222036.53485185m6mhh11c@webmail.zoltak.com>
 <20101004222420.11791ue5kephey5c@webmail.zoltak.com>
 <4CA9BC07.3090008@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CA9BC07.3090008-omB+W0Dpw2o@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Quoting Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>:
>
> Would you mind trying with the older dhclient and removing the '-4'  
> option? Might help seeing where/what the problem is.

Harald and your suggestion worked! I down graded to dhclient 3.1.2 and  
removed the -4 from the dracut scripts and BINGO! Worked first go!

Going back to the issue with dhclient 4.1.0 the error indicated the  
address was already assigned. I wounder if dracut needs to un-assign  
the PXE assigned address from the interface before calling dhclient?

