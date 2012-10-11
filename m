From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 0/2] two ssh-client module fixes
Date: Thu, 11 Oct 2012 16:07:57 +0800
Message-ID: <20121011080757.285843621@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

1/2: remove cttyhack checking
2/2: add random feeding code
---
 modules.d/95ssh-client/module-setup.sh   |   10 ++--------
 modules.d/95ssh-client/random-seeding.sh |    7 +++++++
 2 files changed, 9 insertions(+), 8 deletions(-)
