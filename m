From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 06/10] Install /bin/mount
Date: Thu, 28 Nov 2013 15:08:42 +0100
Message-ID: <52974E6A.70500@redhat.com>
References: <1385567061-13247-1-git-send-email-hare@suse.de> <1385567061-13247-7-git-send-email-hare@suse.de> <529743C7.80906@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <529743C7.80906-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/28/2013 02:23 PM, Hannes Reinecke wrote:
> On 11/27/2013 04:44 PM, Hannes Reinecke wrote:
>> systemd relies on /bin/mount to be present, so install it.
>>
>> Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
>> ---
>>  modules.d/99fs-lib/module-setup.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/modules.d/99fs-lib/module-setup.sh b/modules.d/99fs-lib/module-setup.sh
>> index 7979bab..b24207d 100755
>> --- a/modules.d/99fs-lib/module-setup.sh
>> +++ b/modules.d/99fs-lib/module-setup.sh
>> @@ -85,4 +85,5 @@ install() {
>>      fi
>>  
>>      inst_multiple -o $_helpers fsck
>> +    inst /usr/bin/mount /bin/mount
>>  }
>>
> After much debate and soul-searching it was found that
> 
> a) /bin/mount is _REQUIRED_ to be present
> b) dracut will only copy /usr/bin/mount
> 
> So if /bin is _not_ a symlink to /usr/bin, but the individual
> programs are, /bin/mount doesn't find it's way into the initrd.
> Nor do several other programs.
> 
> How to approach this fundamentally?
> I would prefer to have 'inst' checking for symlinks, and copy them
> over if required.
> Adding them manually seems ineffectual to me.
> But I'll do whatever is desired here ...
> 
> Cheers,
> 
> Hannes
> 

Like already discussed, we should alter dracut-install to search all PATH
elements, instead of just taking the first one.

http://git.kernel.org/cgit/boot/dracut/dracut.git/tree/install/dracut-install.c#n787

http://git.kernel.org/cgit/boot/dracut/dracut.git/tree/install/dracut-install.c#n851

http://git.kernel.org/cgit/boot/dracut/dracut.git/tree/install/dracut-install.c#n883

Will do, and also cleanup dracut-install.c in the process.
