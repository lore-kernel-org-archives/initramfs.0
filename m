From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Update FC22 - doesn't find root fs and doesn't boot
Date: Mon, 15 Jun 2015 11:42:13 +0200
Message-ID: <557E9DF5.2070809@redhat.com>
References: <CAA91j0UysOKJG6LpuvCdrh3jcRMdj9+=XaD-R+Shw7WFZSvbUw@mail.gmail.com> <5565B7BF.4010604@redhat.com> <5565BAEA.6080202@wiesinger.com> <5565BBF8.1050509@redhat.com> <5565C0AC.2070106@wiesinger.com> <5565C182.30709@redhat.com> <5565C4E7.6010301@wiesinger.com> <5565C654.3000101@redhat.com> <556707B5.4000707@wiesinger.com> <556ABD81.9010501@gmail.com> <20150531180858.GA27097@wolff.to> <55794FA1.3070107@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55794FA1.3070107-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: poma <pomidorabelisima-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bruno Wolff III <bruno-bdMChIhFSYk@public.gmane.org>
Cc: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>, Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, For testing and quality assurance of Fedora releases <test-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org>

On 11.06.2015 11:06, poma wrote:
> On 31.05.2015 20:08, Bruno Wolff III wrote:
>>> And already we have fought for this user's side simplification, but it seems developers are very persistent when they do not need to be.
>>
>> In the past changes with this effect were reverted. This time they were not. 
>> This generally just affects people upgrading, as anaconda has been adding 
>> the needed stuff on the kernel command line for a while now.
>>
>> You can also hostonly_cmdline=yes to the dracut config or set hostonly=no 
>> if you are willing to have a larger initramfs file. The latter will also help 
>> if you switch out hardware.
>>
>> I am not sure why hostonly_cmdline=yes is not the default when hostonly=yes. 
>> That would seem to be a better default.
>>
> 
> 
> dracut.conf.d/fedora.conf.example
> +hostonly_cmdline="no"
> 
> http://pkgs.fedoraproject.org/cgit/dracut.git/commit/0001-fedora.conf-do-not-store-cmdline-in-image-by-default.patch?id=43a1228
> http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/dracut.conf.d/fedora.conf.example?id=38e2177
> 
> no explanation why this was done


Basically it's because compiled in arguments are hard to override and people
could not boot after they changed disk configuration.

I guess, s.th. like "rd.cmdline=clean rd.auto" or "rd.helpIwanttobootnow" is
the better solution.
