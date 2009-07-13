From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/10] Defer mount to the real mount loop
Date: Mon, 13 Jul 2009 12:21:26 +0200
Message-ID: <4A5B0AA6.9020406@redhat.com>
References: <1246639520-3094-1-git-send-email-harald@redhat.com> <1246639520-3094-4-git-send-email-harald@redhat.com> <4A4F4B41.2060205@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4F4B41.2060205-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/04/2009 02:29 PM, Seewer Philippe wrote:
>> -echo "iscsi_lun=$iscsi_lun . /bin/mount-lun.sh " > /mount/iscsi.sh
>> +echo "iscsi_lun=$iscsi_lun . /bin/mount-lun.sh " > /mount/01-$$-iscsi.sh
>
> I'd do that after iscsistart. That way the file is only written if
> iscsistart succeeded.

right

>
>>
>> iscsistart -i $iscsi_initiator -t $iscsi_target_name \
>> -g $iscsi_target_group -a $iscsi_target_ip \
>> diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
>> index ad2e906..ecac211 100755
>> --- a/modules.d/95nbd/nbdroot
>> +++ b/modules.d/95nbd/nbdroot
>> @@ -93,9 +93,10 @@ done
>> # If we didn't get a root= on the command line, then we need to
>> # add the udev rules for mounting the nbd0 device
>> if [ ! -e /etc/udev/rules.d/99-mount.rules ]; then
>> - printf 'KERNEL=="%s", RUN+="/sbin/initqueue /bin/mount -t %s -o %s
>> %s %s"\n' \
>> - nbd0 "$nbdfstype" "$fsopts" /dev/nbd0 "$NEWROOT" \
>> - > /etc/udev/rules.d/99-mount.rules
>> + printf 'KERNEL=="nbd0", SYMLINK+="root"\n'>
>> /etc/udev/rules.d/99-mount.rules
>> + printf '/bin/mount -t %s -o %s %s %s\n' \
>> + "$nbdfstype" "$fsopts" /dev/nbd0 "$NEWROOT" \
>> + > /mount/01-$$-nbd.sh
>> fi
>
> Same here, I'd only write a mount-script if nbdclient succeeds.

yep
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
