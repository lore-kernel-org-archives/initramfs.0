From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 10/10] add "rdshell" command line argument
Date: Mon, 13 Jul 2009 12:29:41 +0200
Message-ID: <4A5B0C95.3030609@redhat.com>
References: <1246639520-3094-1-git-send-email-harald@redhat.com> <1246639520-3094-11-git-send-email-harald@redhat.com> <20090706015313.GA70037@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090706015313.GA70037-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/06/2009 03:53 AM, Jeremy Katz wrote:
> On Friday, July 03 2009, Harald Hoyer said:
>> Only drop to an interactive shell if "rdshell" is specified on the
>> command line. This prevents malicious users from gaining easy shell
>> access to the host system (grub might be secured with a password).
>
> I don't have a strong opinion about doing this vs not, but how could
> they end up getting easy shell access?  If grub is secured with a
> password, they can't change kernel arguments.  If they can change kernel
> arguments, they can just add rdshell rather than change the root=
> specifier.
>
> Jeremy

If root is on a network device, they can just unplug the network cable and end 
up with a shell, then they can replug the cable and do whatever they want in the 
shell.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
