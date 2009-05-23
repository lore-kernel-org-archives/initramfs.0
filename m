From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] Add a README.modules that describes how dracut modules work.
Date: Fri, 22 May 2009 19:24:35 -0700 (PDT)
Message-ID: <42aa1bcb8123652cb755e3588f6535cabcbe663f.1243045308.git.victor.lowther@gmail.com>
References: <97274286f3d147cdb21897569d71a1cf5ff4eb07.1243045308.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=jqAudpMA+TqnBPkQr/oM+/Zm5j8hoiPkEy7TuNLxDwo=;
        b=T7GD1nIXQMj4H19373GvsF0rQ10i/OjoJLZ9+8tsYLOPUqyjykBnPgskA22GwO2n3v
         jQjYc7/8bbIgVC4k5cap4SR56LVmfZctWpRsPxwZt8kTqprX239Q5IruPypu6OJ45VW3
         V0SvAwnoIRIEBsxUrb66Mmg3JLzR95l7/aufE=
In-Reply-To: <97274286f3d147cdb21897569d71a1cf5ff4eb07.1243045308.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 README.modules |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/README.modules b/README.modules
new file mode 100644
index 0000000..d968f56
--- /dev/null
+++ b/README.modules
@@ -0,0 +1,52 @@
+Most of the functionality that dracut implements are actually implemented
+by dracut modules.  Dracut modules live in modules.d, and have the following
+structure:
+
+dracut_install_dir/modules.d/
+	00modname/
+		install
+		check
+		<other files as needed by the hook>
+
+00modname: The name of the module prefixed by a two-digit numeric sort code.
+	   The numeric code must be present and in the range of 00 - 99.
+	   Modules with lower numbers are installed first.  This is important
+	   because the dracut install functions (which install files onto
+	   the initrd) refuse to overwrite already installed files. This makes 
+	   it easy for an earlier module to override the functionality of a 
+	   later module, so that you can have a distro or system specific
+	   module override or modify the functionality of a generic module
+	   without having to patch the mode generic module.
+
+install: dracut sources this script to install the functionality that a 
+	 module implements onto the initrd.  For the most part, this amounts
+	 to copying files from the host system onto the initrd in a controlled
+	 manner.  dracut supplies several install functions that are
+	 specialized for different file types.  Browse through dracut-functions
+	 fore more details.  dracut also provides a $moddir variable if you
+	 need to install a file from the module directory, such as an initrd
+	 hook, a udev rule, or a specialized executable.
+
+check: Dracut calls this program to check and see if a module can be installed
+       on the initrd.
+       
+       When called without options, check should check to make sure that
+       any files it needs to install into the initrd from the host system
+       are present.  It should exit with a 0 if they are, and a 1 if they are
+       not.
+
+       When called with -h, it should perform the same check that it would
+       without any options, and it should also check to see if the 
+       functionality the module implements is being used on the host system.
+       For example, if this module handles installing support for LUKS
+       encrypted volumes, it should return 0 if all the tools to handle
+       encrpted volumes are available and the host system has the root
+       partition on an encrypted volume, 1 otherwise.
+
+       Check may take additional options in the future.  
+       We will most likely grow a module dependency checking system in the
+       near future, and check will need to handle a -d option when we do.
+
+Any other files in the module will not be touched by dracut directly. 
+
+You are encouraged to provide a README that descrobes what the module is for.
\ No newline at end of file
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
