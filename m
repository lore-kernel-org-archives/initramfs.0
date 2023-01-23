From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] hook-functions: dep_add_modules_mount: kill unreadable eval
Date: Mon, 23 Jan 2023 13:55:23 +0900
Message-ID: <20230123045523.697916-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane-mx.org@lists.debian.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674449739;
	bh=rUi3g66D5AqkwsAKNyi4K91gjylKNNT4euy6NgcrAnE=;
	h=From:To:Cc:Subject:Date:From;
	b=XPOZs+86R6lmGxU0xGYgaSaVV/PM4dzYjgZgzlpIU5hRY22HSB5LdJMBokeQ46Qmw
	 6fSZcn0770s7PN+/W9Gs/EHRHYZVxqPS+kGY3R7jCcS/jxFHnXd+YoWyFUqjCIoK1b
	 DnItDBBFdl95jXjYrtgKy442EzwXAhPaCHqBNTkT+g9BTEf3IzyZiWWutRK75MpGeU
	 Ij4Uq1Us45OTDO9uDOLquhaFWKsADsKpIJqOsxBp62fftxsXJRVnD6LS1ll+f2LsXH
	 zP23f/75MHYJJr55+85N2zVvreAfxw6WJ67qqzQXK6eOaCQCqknma16SM4C3gMhhB3
	 9a7r82lOmlIXw==
Resent-Message-ID: <hhKTwGkHD7B.A.olC.yNhzjB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20230123045523.697916-1-masahiroy@kernel.org
Content-Type: text/plain; charset="us-ascii"
To: initramfs-tools@packages.debian.org
Cc: debian-kernel@lists.debian.org, initramfs@vger.kernel.org, Ben Hutchings <benh@debian.org>, Masahiro Yamada <masahiroy@kernel.org>

The 'eval' is here because we evaluated the code returned by AWK.

Commit 9249db649ced ("MODULES=dep: awk free version for root dev search")
stopped using AWK, so 'eval' is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---
 hook-functions | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hook-functions b/hook-functions
index 95bd584..fa49990 100644
--- a/hook-functions
+++ b/hook-functions
@@ -416,10 +416,13 @@ dep_add_modules_mount()
 
 	# find out block device + fstype
 	# shellcheck disable=SC2034
-	eval "$(while read -r dev mp fs opts rest ; do \
-		[ "$mp" = "$dir" ] && [ "$fs" != "rootfs" ] \
-		&& printf "dev_node=%s\\nFSTYPE=%s" "$dev" "$fs"\
-		&& break; done < /proc/mounts)"
+	while read -r dev mp fs opts rest; do \
+		if [ "$mp" = "$dir" ] && [ "$fs" != "rootfs" ]; then
+			dev_node=$dev
+			FSTYPE=$fs
+			break;
+		fi
+	done < /proc/mounts
 
 	# Only the root mountpoint has to exist; do nothing if any other
 	# directory is not a mountpoint.
