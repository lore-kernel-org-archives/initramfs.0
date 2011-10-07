From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: minor corrections
Date: Sat,  8 Oct 2011 00:20:49 +0200
Message-ID: <1318026050-5891-1-git-send-email-soltys@ziu.info>
References: <4E86385C.6040706@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E86385C.6040706-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

No need for unsetting vars in [1/4]; apart from that - make sure we
remove trailing slashes, and normalize before checks.

Michal Soltys (1):
  dracut-functions: conv/normalize minor corrections

 dracut-functions |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

-- 
1.7.5.3
