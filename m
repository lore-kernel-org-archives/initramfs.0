From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: modules.d/40nfsroot/install questions
Date: Tue, 26 May 2009 15:59:34 -0400
Message-ID: <1243367974.19603.13.camel@lap75545.ornl.gov>
References: <4A1C38A9.80405@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A1C38A9.80405-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-05-26 at 14:44 -0400, Warren Togami wrote:
> bash-4.0# ./dracut -l -f /boot/initrd-2.6.29.4-162.fc11.i586.img 
> 2.6.29.4-162.fc11.i586
> E: Failed to install strace
> 
> # XXX debug stuff
> dracut_install rpcinfo ping strace dmesg nc free df
> 
> So I realize this is only temporary, but it is preventing it from 
> working.  Is there a long-term plan to make these debug stuff non-fatal?
> 
> Also why is nc included in this list?  Nothing appears to use it in the 
> initramfs.

None of it is needed; remember, I posted a work in progress not thinking
it would be applied. I warned you there were warts. :)

I was using the tools to test an unrelated issue with qemu and a kernel
interaction causing the network interface to go away under load, which
was holding up NFS root testing. Swapping to e1000 emulation seems to
have fixed it.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
