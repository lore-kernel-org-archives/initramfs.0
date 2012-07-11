From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: nfs: install modprobe config file
Date: Wed, 11 Jul 2012 14:42:38 +0800
Message-ID: <4FFD205E.8050005@redhat.com>
References: <20120711050818.GA10940@dhcp-16-143.nay.redhat.com> <4FFD1B89.7060208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FFD1B89.7060208-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/11/2012 02:22 PM, Harald Hoyer wrote:

> Am 11.07.2012 07:08, schrieb Dave Young:
>> install nfs modprobe config file
>>
>> For nfs4, in case nfs.ko is not loaded mount.nfs4 will try to load
>> nfs4.ko instead of nfs.ko. Fedora nfs-utils creates a lib/modprobe.d/nfs.conf
>> in which there's below alias:
>> alias nfs4 nfs
>>
>> Dracut also need this file to auto load nfs kernel module.
>>
>> Tested booting to a fedora 17 nfsroot share.
>>
>> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  modules.d/95nfs/module-setup.sh  |    6 ++++++
>>  modules.d/95nfs/parse-nfsroot.sh |    7 -------
>>  2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> --- dracut.orig/modules.d/95nfs/module-setup.sh
>> +++ dracut/modules.d/95nfs/module-setup.sh
>> @@ -35,6 +35,12 @@ install() {
>>          mount.nfs4 umount rpc.idmapd sed /etc/netconfig
>>      dracut_install /etc/services /etc/nsswitch.conf /etc/rpc /etc/protocols /etc/idmapd.conf
>>  
>> +    if [ -f /lib/modprobe.d/nfs.conf ]; then
>> +        dracut_install /lib/modprobe.d/nfs.conf
>> +    else
>> +        echo "alias nfs4 nfs" > $initdir/etc/modprobe.d/nfs.conf
>> +    fi
>> +
>>      inst_libdir_file 'libnfsidmap_nsswitch.so*' 'libnfsidmap/*.so' 'libnfsidmap*.so*'
>>  
>>      _nsslibs=$(sed -e '/^#/d' -e 's/^.*://' -e 's/\[NOTFOUND=return\]//' /etc/nsswitch.conf \
>> --- dracut.orig/modules.d/95nfs/parse-nfsroot.sh
>> +++ dracut/modules.d/95nfs/parse-nfsroot.sh
>> @@ -88,13 +88,6 @@ nfsroot_to_var $netroot
>>  # Set fstype, might help somewhere
>>  fstype=${nfs#/dev/}
>>  
>> -# NFS actually supported? Some more uglyness here: nfs3 or nfs4 might not
>> -# be in the module...
>> -if ! incol2 /proc/filesystems $fstype ; then
>> -    modprobe nfs
>> -    incol2 /proc/filesystems $fstype || die "nfsroot type $fstype requested but kernel/initrd does not support nfs"
>> -fi
>> -
>>  # Rewrite root so we don't have to parse this uglyness later on again
>>  netroot="$fstype:$server:$path:$options"
>>  
>>
> 
> 
> Hmm... that modprobe.d conf file should have been already copied to the initramfs:
> 
> modules.d/90kernel-modules/module-setup.sh:    dracut_install $(find -L
> /etc/modprobe.d/ -maxdepth 1 -type f -name '*.conf')
> 
> Oh.. I see ... it's /lib/modprobe.d and not /etc/modprobe.d


Yes, then should update the 90kernel-modules instead. but if the
distribution does not ship the nfs.conf, this will still be a problem, I
think 95nfs should also add the alias file in case ! -f
/lib/modprobe.d/nfs.conf, what do you think?

> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
