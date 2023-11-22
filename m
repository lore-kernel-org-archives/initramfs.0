Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FIkm2BEk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3947810C;
	Wed, 22 Nov 2023 05:25:03 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1994B40E0258;
	Wed, 22 Nov 2023 13:25:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0ArRJ98NsNWj; Wed, 22 Nov 2023 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700659498; bh=tfmB5kIO1KjZIKpASvFX87u56VKgZHav99DyvY9sqVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIkm2BEkpLgPj5wpM1geMfClp93ikKBJoNFZjuSANkN8X7QaX7raZTR0GBVKM8jte
	 pwvnSPf4iQkvXgFQK4H3EkaeI367oCM6+qAjxNMGVEVlaw0yf17XQ+MXcBp3dARkec
	 pgVCtwTorFnS7NFvcbzoHTNLoNaQQuPhI/HWBfW2RECz/95xoEyM+39zZW86q2aw7m
	 WpzIvO/I/XmbPJWqL2bg1a/FFP8+Utnw4x5NwMKu0UWEPfcLtXmxVxeRLU9OuzVj7D
	 lOiyiChmkcUb6g1NHMBX7WmnQKeJmwyQhkJkCGp63ee9wpjOsQ23N2zoD0e8T7LUnX
	 dpHqE2GDJ/SKkEpykLrUZ05KNQPEfR//boi5hp7TqmCeJItc5DsE80EUxUQzXhB2lq
	 LEYS7wXsy4vkCLbW9hZEkWv9IpNtUL6iKesNgV09ybHl71HNG46tSy2BNysqaHw+U3
	 lIKbU/xlQFYyeBCJ9IUT1o8DEm+SPHQZroQu5Zlf6qitQSIFtk78grkuBbbvfzwS74
	 nnP8UGB2xhn/Agj90HI3Cw4h+ocx49Z7sDt1RHHOG9MsWByJhPt+Oq+CKLOc0O+Tu3
	 Q+sQJ9ZU/bMeC8qv2TTQ6TrTmijzlFqOm2xhukhQnYN5pLg+Ujt1SNP9MzFPgM53Ee
	 m5dDBsHNXa65wZFpv3g0Wt5U=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A78840E0257;
	Wed, 22 Nov 2023 13:24:48 +0000 (UTC)
Date: Wed, 22 Nov 2023 14:24:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
	initramfs@vger.kernel.org
Subject: [PATCH] x86: Add a "x86" ELF note namespace
Message-ID: <20231122132419.GBZV4BA399sG2JRFAJ@fat_crate.local>
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info>
 <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
 <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>

On Wed, Nov 22, 2023 at 12:58:26PM +0100, Borislav Petkov wrote:
> On Wed, Nov 22, 2023 at 10:15:42AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > [1] unless you fiddle with things obviously internal; not sure if this
> > case would qualify for him, but somehow I doubt it -- but I might be
> > wrong there.
> 
> Well, think about it - by that logic, if CONFIG_* items are an ABI, we
> will never ever be able to change any of them. Now that would be awful.
> 
> > Any progress on this?
> 
> We're thinking...

Turns out this is easier than I think and people have solved this
problem already - all I need to do is use it. Wonderful.

Lemme Cc initramfs@vger.kernel.org as an FYI and see whether dracut
folks would have any comments about this.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 22 Nov 2023 13:59:40 +0100

Add a "x86" ELF note namespace to put ELF note structures with which to
communicate in a ABI-compliant manner what a kernel image supports.

Also, add the first note type of this - X86_ELFNOTE_MICROCODE - which
denotes that microcode support is built into the kernel image and thus
initrd-generating tools like dracut can parse the ELF .notes section for
this.

$ readelf -n vmlinux

Displaying notes found in: .notes
  Owner                Data size        Description
  ...
  x86                  0x00000004       Unknown note type: (0x00000000)
  description data: 01 00 00 00
  ^^^^^^^^^^^^^^

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/uapi/elfnote.h      | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/microcode/core.c |  5 +++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/x86/include/uapi/elfnote.h

diff --git a/arch/x86/include/uapi/elfnote.h b/arch/x86/include/uapi/elfnote.h
new file mode 100644
index 000000000000..bef26c4944e8
--- /dev/null
+++ b/arch/x86/include/uapi/elfnote.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _X86_UAPI_ELFNOTE_H_
+#define _X86_UAPI_ELFNOTE_H_
+
+/*
+ * "x86" namespaced ELF note structures to communicate features
+ * supported by the kernel binary to external utilities which need that
+ * info in order to do additional preparatory work based on the target
+ * kernel image.
+ */
+
+/*
+ * Used by the microcode loader to communicate support to external
+ * initrd generators like dracut.
+ */
+#define X86_ELFNOTE_MICROCODE	0
+
+#endif /* _X86_UAPI_ELFNOTE_H_ */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 232026a239a6..f35444bafbbc 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -24,6 +24,7 @@
 #include <linux/capability.h>
 #include <linux/firmware.h>
 #include <linux/cpumask.h>
+#include <linux/elfnote.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
@@ -32,6 +33,8 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 
+#include <uapi/elfnote.h>
+
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
 #include <asm/perf_event.h>
@@ -859,3 +862,5 @@ static int __init microcode_init(void)
 
 }
 late_initcall(microcode_init);
+
+ELFNOTE32("x86", X86_ELFNOTE_MICROCODE, CONFIG_MICROCODE);
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
