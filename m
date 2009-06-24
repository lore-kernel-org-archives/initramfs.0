From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 0/5] Netroot updates and multinic test-suite
Date: Wed, 24 Jun 2009 20:08:27 +0200
Message-ID: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

This is a first start at a multinic testsuite, some
improvements to netroot and a bugfix.

Patches can be pulled from 
git://github.com/seewer/dracut-seewer.git
as well

Philippe Seewer (5):
  Bugfix: Fix BOOTIF argument translation
  Give the kernel some time to up interfaces
  Be a bit more optimistic when setting mtus
  Add DAD do dhclient-script
  Add multinic test suite

 modules.d/40network/dhclient-script |   19 +++-
 modules.d/40network/ifup            |    3 +-
 modules.d/40network/net-genrules.sh |    2 +-
 test/TEST-50-MULTINIC/Makefile      |   10 ++
 test/TEST-50-MULTINIC/client-init   |    9 ++
 test/TEST-50-MULTINIC/dhcpd.conf    |   36 ++++++
 test/TEST-50-MULTINIC/exports       |    1 +
 test/TEST-50-MULTINIC/hard-off.sh   |    2 +
 test/TEST-50-MULTINIC/hosts         |    5 +
 test/TEST-50-MULTINIC/server-init   |   30 +++++
 test/TEST-50-MULTINIC/test.log      |   48 ++++++++
 test/TEST-50-MULTINIC/test.sh       |  225 +++++++++++++++++++++++++++++++++++
 12 files changed, 384 insertions(+), 6 deletions(-)
 create mode 100644 test/TEST-50-MULTINIC/Makefile
 create mode 100755 test/TEST-50-MULTINIC/client-init
 create mode 100644 test/TEST-50-MULTINIC/dhcpd.conf
 create mode 100644 test/TEST-50-MULTINIC/exports
 create mode 100755 test/TEST-50-MULTINIC/hard-off.sh
 create mode 100644 test/TEST-50-MULTINIC/hosts
 create mode 100755 test/TEST-50-MULTINIC/server-init
 create mode 100644 test/TEST-50-MULTINIC/test.log
 create mode 100755 test/TEST-50-MULTINIC/test.sh

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
