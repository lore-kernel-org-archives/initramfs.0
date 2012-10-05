From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] X86 ACPI: Use #ifdef not #if for CONFIG_X86 check
Date: Fri, 05 Oct 2012 15:05:34 -0700
Message-ID: <506f59ae9600b36a4@agluck-desktop.sc.intel.com>
References: <201209251712.17678.trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201209251712.17678.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, initramfs@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, yinghai@kernel.org, hpa@zytor.com

Fix a build warning on ia64:

include/linux/acpi.h:437:5: warning: "CONFIG_X86" is not defined

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4f42332..f70f18d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -434,7 +434,7 @@ void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_sleep(u8 sleep_state,
 				  u32 pm1a_control, u32 pm1b_control);
-#if CONFIG_X86
+#ifdef CONFIG_X86
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
 static inline void arch_reserve_mem_area(acpi_physical_address addr,
