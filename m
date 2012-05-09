From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut options for installing files and drivers
Date: Wed, 09 May 2012 14:40:23 +0200
Message-ID: <4FAA65B7.9040209@redhat.com>
References: <4FAA1E44.2090006@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FAA1E44.2090006-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Am 09.05.2012 09:35, schrieb Dave Young:
> Hi, harald
> 
> Dracut options '-I' and '-a' both mean optionally install file/ko

this is wrong

$ man dracut

"-a" means

       -a, --add <list of dracut modules>
           add a space-separated list of dracut modules to the default set of
modules. This parameter
           can be specified multiple times.

               Note
               If [LIST] has multiple arguments, then you have to put these in
quotes. For example:

                   # dracut --add "module1 module2"  ...

"-I" means

       -I, --install <file list>
           install the space separated list of files into the initramfs.

               Note
               If [LIST] has multiple arguments, then you have to put these in
quotes. For example:

               +

                   # dracut --install "/bin/foo /sbin/bar"  ...
