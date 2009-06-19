From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/4] 2009-06-19 patchset 2
Date: Fri, 19 Jun 2009 14:01:15 +0200
Message-ID: <1245412879-4418-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Moved dracut to /usr/share/dracut and prepared everything for a first release

Harald Hoyer (4):
  /usr/lib/dracut -> /usr/share/dracut
  add README.generic
  specfile changes
  add target for "dist" and "gitrpm"

 Makefile         |   16 +++++++++++++---
 README.generic   |   10 ++++++++++
 dracut           |    6 +++---
 dracut-functions |    2 +-
 dracut.8         |    4 ++--
 dracut.spec      |   41 +++++++++++++++++++++++++++++++++--------
 6 files changed, 62 insertions(+), 17 deletions(-)
 create mode 100644 README.generic

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
