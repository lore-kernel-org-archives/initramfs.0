From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 2/2] efi/x86: Always relocate the kernel for EFI handover entry
Date: Mon,  6 Apr 2020 14:06:14 -0400
Message-ID: <20200406180614.429454-2-nivedita@alum.mit.edu>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200406180614.429454-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>, hpa@zytor.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>, initramfs@vger.kernel.org, Donovan Tremura <neurognostic@protonmail.ch>, Harald Hoyer <harald@hoyer.xyz>

Commit

  d5cdf4cfeac9 ("efi/x86: Don't relocate the kernel unless necessary")

tries to avoid relocating the kernel in the EFI stub as far as possible.

However, when systemd-boot is used to boot a unified kernel image [1],
the image is constructed by embedding the bzImage as a .linux section in
a PE executable that contains a small stub loader from systemd that will
call the EFI stub handover entry, together with additional sections and
potentially an initrd. When this image is constructed, by for example
dracut, the initrd is placed after the bzImage without ensuring that at
least init_size bytes are available for the bzImage. If the kernel is
not relocated by the EFI stub, this could result in the compressed
kernel's startup code in head_{32,64}.S overwriting the initrd.

To prevent this, unconditionally relocate the kernel if the EFI stub was
entered via the handover entry point.

[1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reported-by: Sergey Shatunov <me@prok.pw>
Fixes: d5cdf4cfeac9 ("efi/x86: Don't relocate the kernel unless necessary")
---
 drivers/firmware/efi/libstub/x86-stub.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index e7af6d2eddbf..7583e908852f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -742,8 +742,15 @@ unsigned long efi_main(efi_handle_t handle,
 	 * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
 	 * KASLR uses.
 	 *
-	 * Also relocate it if image_offset is zero, i.e. we weren't loaded by
-	 * LoadImage, but we are not aligned correctly.
+	 * Also relocate it if image_offset is zero, i.e. the kernel wasn't
+	 * loaded by LoadImage, but rather by a bootloader that called the
+	 * handover entry. The reason we must always relocate in this case is
+	 * to handle the case of systemd-boot booting a unified kernel image,
+	 * which is a PE executable that contains the bzImage and an initrd as
+	 * COFF sections. The initrd section is placed after the bzImage
+	 * without ensuring that there are at least init_size bytes available
+	 * for the bzImage, and thus the compressed kernel's startup code may
+	 * overwrite the initrd unless it is moved out of the way.
 	 */
 
 	buffer_start = ALIGN(bzimage_addr - image_offset,
@@ -753,8 +760,7 @@ unsigned long efi_main(efi_handle_t handle,
 	if ((buffer_start < LOAD_PHYSICAL_ADDR)				     ||
 	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
 	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
-	    (image_offset == 0 && !IS_ALIGNED(bzimage_addr,
-					      hdr->kernel_alignment))) {
+	    (image_offset == 0)) {
 		status = efi_relocate_kernel(&bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
-- 
2.24.1

