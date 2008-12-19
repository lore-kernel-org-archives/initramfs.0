From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Dracut questions
Date: Fri, 19 Dec 2008 09:03:03 +0100
Message-ID: <494B5537.7020307@bfh.ch>
References: <494B2E2F.5090203@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <494B2E2F.5090203-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Warren Togami wrote:
> https://fedoraproject.org/wiki/Initrdrewrite
>> Probe at runtime instead of buildtime - Include all drivers, not just
>> the drivers necessary for the hardware being run. (For storage, the
>> common ones will be built-in to the kernel anyway)
> 
> This means include all storage drivers and firmware for the storage 
> drivers?

 From the description I'd guess so. Although I'd like to see both 
options. A full one with all drivers for generic boots and another one 
tailored for specific systems and fast booting (and maybe small memory 
footprint).

> 
> Does this also mean we only add network drivers if the initrd is 
> explicitly built for netboot?
Makes sense, otherwise the image gets huge! My current 2.6.27 netboot 
initrd reaches almost 8Megs...

> 
> How do we plan on dealing with the location of various standard 
> utilities being different on other Linux distributions?
> 
> Fedora        Debian
> /sbin/lspci    /usr/bin/lspci
> /sbin/lsmod    /bin/lsmod
> (just off the top of my head)
> 
> Perhaps use "which" to find it?  But then how do we choose its 
> destination path in the initrd chroot if the distributions disagree on 
> where they expect a command to go?  Will they disagree?

Maybe the LSB might help a bit. It doesn't say anything about where the 
utilities actually have to go, but read this:
[quote]
16.4. Path For System Administration Utilities

Certain utilities used for system administration (and other privileged 
commands) may be stored in /sbin, /usr/sbin, and /usr/local/sbin. 
Applications requiring to use commands identified as system 
administration utilities should add these directories to their PATH. By 
default, as described in ISO POSIX (2003), standard utilities shall be 
found on the PATH returned by getconf PATH (or command -p getconf PATH 
to be guaranteed to invoke the correct version of getconf).
[/quote]

Cheers,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
