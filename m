From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 1/9] Have the test framework always run the cleanup script
Date: Sat,  6 Jun 2009 05:23:22 -0400
Message-ID: <261d02965986566d9455f0374136f28213657855.1244279679.git.dave@thedillows.org>
References: <cover.1244279679.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

Also remove some extra semicolons, and put the pointer to the test log
on its own line.
---
 test/test-functions |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/test/test-functions b/test/test-functions
index 7b219ba..cf0768b 100644
--- a/test/test-functions
+++ b/test/test-functions
@@ -1,27 +1,33 @@
 while (($# > 0)); do
     case $1 in
         --run) 
-	    echo "TEST RUN: $TEST_DESCRIPTION";
-	    test_run;
+	    echo "TEST RUN: $TEST_DESCRIPTION"
+	    test_run
 	    exit $?;;
         --setup) 
-	    echo "TEST SETUP: $TEST_DESCRIPTION";
-	    test_setup;
+	    echo "TEST SETUP: $TEST_DESCRIPTION"
+	    test_setup
 	    exit $?;;
         --clean) 
-	    echo "TEST CLEANUP: $TEST_DESCRIPTION";
-	    test_cleanup;
+	    echo "TEST CLEANUP: $TEST_DESCRIPTION"
+	    test_cleanup
 	    exit $?;;
         --all) 
 	    echo -n "TEST: $TEST_DESCRIPTION ";
-	    { test_setup && test_run && test_cleanup; } </dev/null >test.log 2>&1;
-	    ret=$?;
+	    (
+		test_setup && test_run
+		ret=$?
+		test_cleanup
+		exit $ret
+	    ) </dev/null >test.log 2>&1
+	    ret=$?
 	    if [ $ret -eq 0 ]; then
-               rm test.log;
-	       echo "[OK]";
+               rm test.log
+	       echo "[OK]"
 	    else
-	       echo "[FAILED] see $(pwd)/test.log";
-	    fi;
+	       echo "[FAILED]"
+	       echo "see $(pwd)/test.log"
+	    fi
 	    exit $ret;;
         *) break ;;
     esac
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
