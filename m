From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: fix missing slash
Date: Sun, 24 Apr 2011 00:22:50 +0200
Message-ID: <1303597371-6280-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Trivial fix, though /sys is mounted just a few lines earlier, so maybe
the 2nd check should simply be removed ?

Michal Soltys (1):
  modules.d/99base/init: missing slash in ismounted check

 modules.d/99base/init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
1.7.4.2
