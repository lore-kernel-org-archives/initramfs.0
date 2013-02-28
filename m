From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/2] add parameter continue_on_fail
Date: Thu, 28 Feb 2013 11:38:54 +0800
Message-ID: <512ED14E.5050909@redhat.com>
References: <cover.1361167889.git.bhe@redhat.com> <51220277.1010507@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51220277.1010507-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 02/18/2013 06:29 PM, Harald Hoyer wrote:
> Am 18.02.2013 07:21, schrieb Baoquan He:
>> v1->v2:
>>     Discard previous implementation, take a direct and simpler
>>     method.
>>
>> By adding pamameter 'continue_on_fail=initqueue|mount_root',
>> user can decide if continue after these points timeout. And
>> can extend to other delay or loop point later if needed.
>>
>> Baoquan He (2):
>>   Add parameter continue_on_fail to make dracut continue after
>>     initqueue timeout
>>   Continue when mount rootfs failed by specifing
>>     'continue_on_fail=mount_root'
>>
>>  dracut.cmdline.7.asc                    |    3 +++
>>  modules.d/98systemd/dracut-initqueue.sh |   10 ++++++++--
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> Why don't you just remove all "finished" scripts and install your own "finished"
> checking scripts, when your kdump device is ready?

Grep emergency_shell usages, I find there's other points which will
break out, like fsck, selinux policy loading etc. It's not only limited
to initqueue...

Baoquan, looks like you only handled initqueue in the patches.

I thought to add a wrapper function like below, then replace all
emergency_shell caller to call failaction instead:
failaction()
{
    if rd.failaction=continue;
        return
    fi

    emergency_shell ...

}

I think no need to add "continue_on_fail=initqueue|mount_root", one
global switch is enough, nobody will want this except kdump..

Harald, do you have better solution? If I'm wrong here please correct me.

> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Thanks
Dave

