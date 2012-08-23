From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch v2 0/3] add --device option
Date: Thu, 23 Aug 2012 11:02:21 +0800
Message-ID: <20120823030221.587864989@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This series contains 3 patches.

1/3: wait host devs in base module
2/3: Add for_each_host_dev_and_slaves for device only checking
3/3: Add a dracut option --device to bring up a device in initramfs

this patch series fixes below problems:
move fstab wait_for_dev to 99base, convert to persistent name for initramfs
kdump iscsi setup fail due to check_block_and_slaves break if helper
    function success with one of the slaves. 
add --device option.
