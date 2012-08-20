From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch 2/3] Add for_each_host_dev for device only checking
Date: Mon, 20 Aug 2012 13:56:27 +0800
Message-ID: <5031D18B.2070208@redhat.com>
References: <20120817123519.082687047@redhat.com> <20120817123905.206266546@redhat.com> <20120817170217.GB11604@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120817170217.GB11604-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/18/2012 01:02 AM, Vivek Goyal wrote:

> On Fri, Aug 17, 2012 at 08:35:21PM +0800, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
>> For lvm, multipath, iscsi modules they do not care about the filesystem,
>> Also there could be devcie in host_devs but it does not get formated.
>>
>> For these kind of modules, use for_each_host_dev will be better than use
>> for_each_host_dev_fs, here add a new function to iterate the host_devs.
>>
> 
> If we decide not to add slave devices in host_devs, then this will not
> work.


If we add a line in fstab, then the dev|fs are added to host_fs_types.
What I'm confusing now is why the for_each_host_dev_fs works without the
slave devices in host_fs_types.

> 
> Vivek
> 


-- 
Thanks
Dave
