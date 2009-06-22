From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: 13 NFS syntax variations
Date: Mon, 22 Jun 2009 16:56:07 -0400
Message-ID: <4A3FEFE7.7080907@redhat.com>
References: <4A39A9AF.6070009@redhat.com> <4A3A13A8.6050100@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3A13A8.6050100-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/18/2009 06:15 AM, Seewer Philippe wrote:
>> What should we cut?
>>
>> 1) The most obvious to cut are the Legacy Variations. Why should
>> dracut invent three new syntaxes and immediately declare them Legacy?
>> Removing these would be the simplest.
>
> If I understand David Dillow correctly they were meant as shortcuts.
> Removing them doesn't break anything, so I agree.

Soon pushing this.  This removes 3 variations of the nfsroot.txt syntax 
that are new inventions of dracut.

>>
>> 2) Harald and I think we should cut Group B. The netroot= syntax is
>> necessary only for remote block device protocols like iscsci and nbd
>> when you want to use LVM or crypto on those block devices. For NFS it
>> is only redundant.
>
> Reduntant: Yes. But it keeps the argument scheme consistent. And dracut
> is allowed to introduce new syntaxes if they make sense.

root= and netroot= redundant syntaxes with redundant tests make sense how?

* netroot= NFS variation adds to confusion understanding the 
documentation and examples.
* Complaints about the tests taking too long?  Remove all the redundant 
tests that do identical root= and netroot=.
* Separate netroot= only exists for remote block devices, useless for NFS.

This would remove 3 redundant new syntaxes.

>> 3) I personally think we should cut the "nfs:" prefixed syntaxes from
>> Group A, B and C because they have no precedent and we're better off
>> with fewer variations. Others have disagreed though.

Alternatively, how do people feel about removing the NFS syntax that is 
missing the nfs: prefix?  It was poorly supported (did not support 
nfs-options) in mkinitrd, lacked DHCP support, and non-existent in 
Debian's initramfs-tools.

root=[<server-ip>:]<root-dir>[:<nfs-options>]
root=dhcp
	root-path=[<server-ip>:]<root-dir>[:<nfs-options>]

RHEL5 supported the former without nfs-options, but without the ability 
to load network drivers it was almost useless.
Fedora 10+ supported the latter with root=dhcp but without nfs-options.

Options:
1) Leave it as-is.
2) Remove it.
3) Support it but print deprecation warnings like Legacy nfsroot.txt.

Opinions?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
