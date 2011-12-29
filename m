From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] allow ifup bring up network mannually even without netroot
Date: Thu, 29 Dec 2011 17:55:37 +0800
Message-ID: <4EFC3919.9090404@redhat.com>
References: <20111229031342.GA6829@darkstar.nay.redhat.com> <1325149504.19896.13.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325149504.19896.13.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/29/2011 05:05 PM, David Dillow wrote:

> On Thu, 2011-12-29 at 11:13 +0800, Dave Young wrote:
>> sometimes we need bring up network even without netroot
>>
>> Here implement this by adding one param to ifup script, user can use:
>> /sbin/ifup $netif -m; to bring up eth0, note currently ifup will see
>> anything in param $2 as same.
>>
>> `ifup eth0 -m` will create /tmp/net.eth0.mannual stamp file,
>> later dhclient-script can check this and pass $2 to netroot,
>> then netroot script will bring eth0 up
> 
> 'Manual' is misspelled throughout the patch, and your commit message is
> a bit broken -- you say '/sbin/ifup $netif -m' will bring up eth0. You
> put the command line that actually would in the next paragraph.


Thanks for comments.
Will check and fix the spelling.
For broken commit message you means 's/$netif/eth0' ? will fix

> 
> What's the use case? I'm sure there probably is one, but it's better to
> be specific in the commit message when giving an example. I'm assuming
> this is for your kdump work?


Yes, kdump will need scp vmcore to remote machine which need net up
without netroot
Also will add to v2 patch description

> 
> 
>> --- dracut.orig/modules.d/40network/dhclient-script
>> +++ dracut/modules.d/40network/dhclient-script
>> @@ -74,7 +74,12 @@ case $reason in
>>              echo "$line"
>>          done >/tmp/dhclient.$netif.dhcpopts
>>          echo online > /sys/class/net/$netif/uevent
>> -        initqueue --onetime --name netroot-$netif netroot $netif
>> +        if [ -e /tmp/net.$netif.mannual ]; then
>> +            /sbin/netroot $netif -m
>> +            rm -f /tmp/net.$netif.mannual
>> +        else
>> +            initqueue --onetime --name netroot-$netif netroot $netif
>> +        fi
> 
> And if we want to use kdump with NFS root?


If nfsroot is already mounted as sysroot, ifup eth0 -m will return as
nop; If ifup eth0 -m run firstly then the shared codes will pass-through
and still will run netroot specific code.

> 
> I think it would be cleaner to add either conditionally add netroot to
> the initqueue only when there is actually a netroot used, or
> make /sbin/netroot not care... it currently exits with a nonzero value
> if /tmp/root.info isn't there, or $netroot is empty. I assume that
> causes problems elsewhere -- I haven't kept up with dracut for a while
> -- but perhaps not and it is safe to just always call it.


I'm not sure I fully understand your option. can you elaborate more detail?

> 
>> --- dracut.orig/modules.d/40network/ifup
>> +++ dracut/modules.d/40network/ifup
> 
>> @@ -50,7 +52,11 @@ do_ipv6auto() {
>>  
>>
>>      echo online > /sys/class/net/$netif/uevent
>> -    initqueue --onetime --name netroot-$netif netroot $netif
>> +    if [ -z "$2" ]; then
>> +        initqueue --onetime --name netroot-$netif netroot $netif
>> +    else
>> +        /sbin/netroot $netif -m
>> +    fi
>>  }
> 
> Same comment here, with the added bonus that "$2" will reference the
> function's arguments, not the scripts, so you'll always do the initqueue
> call. 


Good catch, will fix

> 
> Why are you wanting to run netroot immediately if you aren't using a
> network root? 


I want it behave like a manual operation.

> 
> If it's just to copy the configuration over when you have a kdump, is it
> going to hurt things to not copy in that case? Do the network scripts in
> the real root care? They have to handle the case when you don't have a
> kdump anyway -- assuming you don't bring up the network in dracut unless
> you have a dump push.


we need to scp to nics other than nfs root nic also.

> 
> If they really do care, then perhaps consider splitting out the copying
> of the config to a separate step that can be shared, rather than making
> things uglier than they already are. It'd probably be a good cleanup on
> it's own merits.

>

I firstly tried to split the code and isolate some code out, but finally
find it become more complex become current dracut is fully oriented to
rootfs mounting...

> Dave
> 
> 
> 
> 



-- 
Thanks
Dave
