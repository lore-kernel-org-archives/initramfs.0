From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 10/10] add "rdshell" command line argument
Date: Sun, 5 Jul 2009 21:53:14 -0400
Message-ID: <20090706015313.GA70037@redhat.com>
References: <1246639520-3094-1-git-send-email-harald@redhat.com> <1246639520-3094-11-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1246639520-3094-11-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Friday, July 03 2009, Harald Hoyer said:
> Only drop to an interactive shell if "rdshell" is specified on the
> command line. This prevents malicious users from gaining easy shell
> access to the host system (grub might be secured with a password).

I don't have a strong opinion about doing this vs not, but how could
they end up getting easy shell access?  If grub is secured with a
password, they can't change kernel arguments.  If they can change kernel
arguments, they can just add rdshell rather than change the root=
specifier.  

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
