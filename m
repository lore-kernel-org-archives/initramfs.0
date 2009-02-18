From: Thiago Galesi <ro-ubUvw2JwXcZg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/1] added extention to module files
Date: Wed, 18 Feb 2009 09:36:14 -0300
Message-ID: <1234960574-32612-1-git-send-email-ro@duskblue.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Here's a simple patch to add the .sh extention to modules/ files as
suggested in a previous message

I'm not sure if more modifications are needed in dracut though.


Signed-off-by: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules/{00dash => 00dash.sh}                     |    0 
 modules/{10redhat-i18n => 10redhat-i18n.sh}       |    0 
 modules/{90crypt => 90crypt.sh}                   |    0 
 modules/{90kernel-modules => 90kernel-modules.sh} |    0 
 modules/{90lvm => 90lvm.sh}                       |    0 
 modules/{95debug => 95debug.sh}                   |    0 
 modules/{95terminfo => 95terminfo.sh}             |    0 
 modules/{95udev-rules => 95udev-rules.sh}         |    0 
 modules/{99base => 99base.sh}                     |    0 
 9 files changed, 0 insertions(+), 0 deletions(-)
 rename modules/{00dash => 00dash.sh} (100%)
 rename modules/{10redhat-i18n => 10redhat-i18n.sh} (100%)
 rename modules/{90crypt => 90crypt.sh} (100%)
 rename modules/{90kernel-modules => 90kernel-modules.sh} (100%)
 rename modules/{90lvm => 90lvm.sh} (100%)
 rename modules/{95debug => 95debug.sh} (100%)
 rename modules/{95terminfo => 95terminfo.sh} (100%)
 rename modules/{95udev-rules => 95udev-rules.sh} (100%)
 rename modules/{99base => 99base.sh} (100%)

diff --git a/modules/00dash b/modules/00dash.sh
similarity index 100%
rename from modules/00dash
rename to modules/00dash.sh
diff --git a/modules/10redhat-i18n b/modules/10redhat-i18n.sh
similarity index 100%
rename from modules/10redhat-i18n
rename to modules/10redhat-i18n.sh
diff --git a/modules/90crypt b/modules/90crypt.sh
similarity index 100%
rename from modules/90crypt
rename to modules/90crypt.sh
diff --git a/modules/90kernel-modules b/modules/90kernel-modules.sh
similarity index 100%
rename from modules/90kernel-modules
rename to modules/90kernel-modules.sh
diff --git a/modules/90lvm b/modules/90lvm.sh
similarity index 100%
rename from modules/90lvm
rename to modules/90lvm.sh
diff --git a/modules/95debug b/modules/95debug.sh
similarity index 100%
rename from modules/95debug
rename to modules/95debug.sh
diff --git a/modules/95terminfo b/modules/95terminfo.sh
similarity index 100%
rename from modules/95terminfo
rename to modules/95terminfo.sh
diff --git a/modules/95udev-rules b/modules/95udev-rules.sh
similarity index 100%
rename from modules/95udev-rules
rename to modules/95udev-rules.sh
diff --git a/modules/99base b/modules/99base.sh
similarity index 100%
rename from modules/99base
rename to modules/99base.sh
-- 
1.5.4.3

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
