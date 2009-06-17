From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Redundant nfsroot cmdline options
Date: Wed, 17 Jun 2009 16:38:21 -0400
Message-ID: <4A39543D.9040206@redhat.com>
References: <4A36A510.5010709@redhat.com> <20090617034849.GA22705@thedillows.org> <4A386B20.9010205@redhat.com> <4A3898E0.8090700@bfh.ch> <4A394352.1010007@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A394352.1010007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/17/2009 03:26 PM, Warren Togami wrote:
>> # "/tftpboot/%s" will be used.
>
> This part about /tftpboot/ and the accompanying implementation in
> 95nfs/nfsroot seems baffling.
>
> * In what cases does hostname lookup actually work here?
> * Where does this precedent come from? This seems to be a really narrow
> implementation from some specific past software with hard-coded
> assumptions.
> * For example /tftpboot isn't used by default configurations of tftp
> servers on modern Debian, Ubuntu or Fedora anymore. They've moved to
> FHS-compliant /var/lib/tftpboot. But then again nothing demands that the
> sysadmin sticks with any particular path for the tftp server.
> * What does tftpboot have to do with initrd? The initrd doesn't have
> anything to do with tftp at this stage.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/filesystems/nfsroot.txt

OK, I see in the Legacy documentation...

/tftpboot is only a default set if no path is provided.  You can 
apparently have any path with an optional %s which is replaced by the 
kernel.  In our case however we need to replace the %s ourselves.

> 62   <root-dir>    Name of the directory on the server to mount as root.
> 63                 If there is a "%s" token in the string, it will be
> 64                 replaced by the ASCII-representation of the client's
> 65                 IP address.

The documentation only mentions "ASCII-representation of the client's IP 
address", not hostname that 95nfs/nfsroot seems to indicate.

Where did the idea that %s is hostname come from?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
