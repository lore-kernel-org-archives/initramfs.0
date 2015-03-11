From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] systemd: services should never be targets for the OOM killer
Date: Wed, 11 Mar 2015 15:14:55 -0300
Message-ID: <1426097695-3729-1-git-send-email-crrodriguez@opensuse.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cristianrodriguez.net; s=google;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HpyzHFm0a9k0NzKTUMjLDoabOQgcN7gChRBd6aMV+mc=;
        b=X6pgpv0lbU4Y78nzSF69c0PiJvivxDSFlJnbR6WzPgyIY2f4z/NGnPF4AzA2QYLpTD
         Os1jTE7IcCAgw9qKVh8fzwjaywwY58ooB0sxn4Eb5o/KAI+kqMkVX+hW9PpqHOXZRaes
         f4mtDfEsa7b0ich2S4Mr6aPha6B/NJ5BEKpLI=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

Otherwise systems with limited memory will fail to
boot.
---
 modules.d/98systemd/dracut-cmdline-ask.service | 2 +-
 modules.d/98systemd/dracut-cmdline.service     | 2 +-
 modules.d/98systemd/dracut-emergency.service   | 2 +-
 modules.d/98systemd/dracut-initqueue.service   | 1 +
 modules.d/98systemd/dracut-mount.service       | 2 +-
 modules.d/98systemd/dracut-pre-mount.service   | 2 +-
 modules.d/98systemd/dracut-pre-pivot.service   | 2 +-
 modules.d/98systemd/dracut-pre-trigger.service | 2 +-
 modules.d/98systemd/dracut-pre-udev.service    | 2 +-
 modules.d/98systemd/dracut-shutdown.service    | 1 +
 modules.d/98systemd/emergency.service          | 2 +-
 11 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/modules.d/98systemd/dracut-cmdline-ask.service b/modules.d/98systemd/dracut-cmdline-ask.service
index 9a34b35..81447b3 100644
--- a/modules.d/98systemd/dracut-cmdline-ask.service
+++ b/modules.d/98systemd/dracut-cmdline-ask.service
@@ -27,7 +27,7 @@ StandardError=inherit
 RemainAfterExit=yes
 KillMode=process
 IgnoreSIGPIPE=no
-
+OOMScoreAdjust=-1000
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
 KillSignal=SIGHUP
diff --git a/modules.d/98systemd/dracut-cmdline.service b/modules.d/98systemd/dracut-cmdline.service
index 6eeb991..de03a65 100644
--- a/modules.d/98systemd/dracut-cmdline.service
+++ b/modules.d/98systemd/dracut-cmdline.service
@@ -31,7 +31,7 @@ StandardOutput=syslog
 StandardError=syslog+console
 KillMode=process
 RemainAfterExit=yes
-
+OOMScoreAdjust=-1000
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
 KillSignal=SIGHUP
diff --git a/modules.d/98systemd/dracut-emergency.service b/modules.d/98systemd/dracut-emergency.service
index 5a6d525..ba7f2c9 100644
--- a/modules.d/98systemd/dracut-emergency.service
+++ b/modules.d/98systemd/dracut-emergency.service
@@ -28,7 +28,7 @@ StandardOutput=inherit
 StandardError=inherit
 KillMode=process
 IgnoreSIGPIPE=no
-
+OOMScoreAdjust=-1000
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
 KillSignal=SIGHUP
diff --git a/modules.d/98systemd/dracut-initqueue.service b/modules.d/98systemd/dracut-initqueue.service
index 5d772f7..722fd23 100644
--- a/modules.d/98systemd/dracut-initqueue.service
+++ b/modules.d/98systemd/dracut-initqueue.service
@@ -34,6 +34,7 @@ StandardOutput=syslog
 StandardError=syslog+console
 KillMode=process
 RemainAfterExit=yes
+OOMScoreAdjust=-1000
 
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
diff --git a/modules.d/98systemd/dracut-mount.service b/modules.d/98systemd/dracut-mount.service
index 1b14f4a..5d0295f 100644
--- a/modules.d/98systemd/dracut-mount.service
+++ b/modules.d/98systemd/dracut-mount.service
@@ -26,7 +26,7 @@ StandardOutput=syslog
 StandardError=syslog+console
 KillMode=process
 RemainAfterExit=yes
-
+OOMScoreAdjust=-1000
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
 KillSignal=SIGHUP
diff --git a/modules.d/98systemd/dracut-pre-mount.service b/modules.d/98systemd/dracut-pre-mount.service
index 96ea995..78a8ed4 100644
--- a/modules.d/98systemd/dracut-pre-mount.service
+++ b/modules.d/98systemd/dracut-pre-mount.service
@@ -28,7 +28,7 @@ StandardOutput=syslog
 StandardError=syslog+console
 KillMode=process
 RemainAfterExit=yes
-
+OOMScoreAdjust=-1000
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
 KillSignal=SIGHUP
diff --git a/modules.d/98systemd/dracut-pre-pivot.service b/modules.d/98systemd/dracut-pre-pivot.service
index f5a85ce..45a2eff 100644
--- a/modules.d/98systemd/dracut-pre-pivot.service
+++ b/modules.d/98systemd/dracut-pre-pivot.service
@@ -34,7 +34,7 @@ StandardOutput=syslog
 StandardError=syslog+console
 KillMode=process
 RemainAfterExit=yes
-
+OOMScoreAdjust=-1000
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
 KillSignal=SIGHUP
diff --git a/modules.d/98systemd/dracut-pre-trigger.service b/modules.d/98systemd/dracut-pre-trigger.service
index 826b89b..b6649d3 100644
--- a/modules.d/98systemd/dracut-pre-trigger.service
+++ b/modules.d/98systemd/dracut-pre-trigger.service
@@ -28,7 +28,7 @@ StandardOutput=syslog
 StandardError=syslog+console
 KillMode=process
 RemainAfterExit=yes
-
+OOMScoreAdjust=-1000
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
 KillSignal=SIGHUP
diff --git a/modules.d/98systemd/dracut-pre-udev.service b/modules.d/98systemd/dracut-pre-udev.service
index 73740be..cd87b10 100644
--- a/modules.d/98systemd/dracut-pre-udev.service
+++ b/modules.d/98systemd/dracut-pre-udev.service
@@ -31,7 +31,7 @@ StandardOutput=syslog
 StandardError=syslog+console
 KillMode=process
 RemainAfterExit=yes
-
+OOMScoreAdjust=-1000
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
 KillSignal=SIGHUP
diff --git a/modules.d/98systemd/dracut-shutdown.service b/modules.d/98systemd/dracut-shutdown.service
index 21c9d29..aff764b 100644
--- a/modules.d/98systemd/dracut-shutdown.service
+++ b/modules.d/98systemd/dracut-shutdown.service
@@ -19,3 +19,4 @@ RemainAfterExit=yes
 Type=oneshot
 ExecStart=/bin/true
 ExecStop=/usr/lib/dracut/dracut-initramfs-restore
+OOMScoreAdjust=-1000
diff --git a/modules.d/98systemd/emergency.service b/modules.d/98systemd/emergency.service
index 5f1eaa2..5b13417 100644
--- a/modules.d/98systemd/emergency.service
+++ b/modules.d/98systemd/emergency.service
@@ -27,7 +27,7 @@ StandardOutput=inherit
 StandardError=inherit
 KillMode=process
 IgnoreSIGPIPE=no
-
+OOMScoreAdjust=-1000
 # Bash ignores SIGTERM, so we send SIGHUP instead, to ensure that bash
 # terminates cleanly.
 KillSignal=SIGHUP
-- 
2.3.1
