From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/2] add parameter continue_on_fail
Date: Tue, 19 Feb 2013 16:02:21 +0800
Message-ID: <5123318D.1030207@redhat.com>
References: <cover.1361167889.git.bhe@redhat.com> <51220277.1010507@redhat.com> <51230787.7090706@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51230787.7090706-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 02/19/2013 01:03 PM, Baoquan wrote:
> On 02/18/2013 06:29 PM, Harald Hoyer wrote:
> 
>> Am 18.02.2013 07:21, schrieb Baoquan He:
>>> v1->v2:
>>>     Discard previous implementation, take a direct and simpler
>>>     method.
>>>
>>> By adding pamameter 'continue_on_fail=initqueue|mount_root',
>>> user can decide if continue after these points timeout. And
>>> can extend to other delay or loop point later if needed.
>>>
>>> Baoquan He (2):
>>>   Add parameter continue_on_fail to make dracut continue after
>>>     initqueue timeout
>>>   Continue when mount rootfs failed by specifing
>>>     'continue_on_fail=mount_root'
>>>
>>>  dracut.cmdline.7.asc                    |    3 +++
>>>  modules.d/98systemd/dracut-initqueue.sh |   10 ++++++++--
>>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> Why don't you just remove all "finished" scripts and install your own "finished"
>> checking scripts, when your kdump device is ready?

Even if none of kdump devices are ready, kdump still need ignore
previous failure of dracut, so kdump can handle it according to kdump
config options user specified. ie. some customized scripts..

> 
> Hi Harald,
> 
> Thanks for your comment.
> 
> Even though use "finished" scripts method, a parameter as switch to user
> is necessary. There are various kdump targets, sometime maybe it's
> unnecessary to continue on fail, because kdump target may not be started
> in initqueue.
> 
> In initqueue, adding parameter and change are because when a specific
> device failed to setup, later rootfs can be tried.
> 
> E.g For kdump, there can be 2 dump target, one is remote target through
> network with higher priority, the other is local rootfs with lower
> priority. So in initqueue, even though the network device failed to
> setup, we need go ahead to try local rootfs dumping, but not entering
> into emergency shell.
> 
> Baoquan
> Thanks a lot!
> 


-- 
Thanks
Dave

