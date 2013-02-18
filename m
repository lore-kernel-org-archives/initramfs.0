From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/2] add parameter continue_on_fail
Date: Mon, 18 Feb 2013 14:21:41 +0800
Message-ID: <cover.1361167889.git.bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

v1->v2:
    Discard previous implementation, take a direct and simpler
    method.

By adding pamameter 'continue_on_fail=initqueue|mount_root',
user can decide if continue after these points timeout. And
can extend to other delay or loop point later if needed.

Baoquan He (2):
  Add parameter continue_on_fail to make dracut continue after
    initqueue timeout
  Continue when mount rootfs failed by specifing
    'continue_on_fail=mount_root'

 dracut.cmdline.7.asc                    |    3 +++
 modules.d/98systemd/dracut-initqueue.sh |   10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)
