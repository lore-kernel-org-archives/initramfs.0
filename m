From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] add iSCSI module
Date: Tue, 02 Jun 2009 07:04:59 -0500
Message-ID: <1243944299.647.39.camel@sentry-no.fnordovax.org>
References: <1243942901-5474-1-git-send-email-harald@redhat.com>
	 <1243942901-5474-2-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=XhqHMQ5dNp0DrPFeq4LYRNmYgu2s4QcZ9Th35OULP8M=;
        b=Vz59EzK6Ako/7HY0hhw95TARuqc6mRAYHfETW3HMMR3X5aCqzdFUQ4/PLq3Ki9/U9Y
         jnwacCp9C/fUe8dVS9C36AdfLFs/akYCHvriRod9AhjjXFR15kZ3eJzvjgsPDRf2YJbA
         X1kMrUhYi/ig381qzNjgTFr/ggF/UJIfK4jMw=
In-Reply-To: <1243942901-5474-2-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-06-02 at 13:41 +0200, Harald Hoyer wrote:
> ---
>  modules.d/95iscsi/check              |   11 +++
>  modules.d/95iscsi/install            |    8 ++
>  modules.d/95iscsi/iscsi-netroot.sh   |   13 ++++
>  modules.d/95iscsi/iscsiroot          |  121 ++++++++++++++++++++++++++++++++++
>  modules.d/95iscsi/parse-iscsiroot.sh |   37 ++++++++++
>  test/TEST-30-ISCSI/Makefile          |   10 +++
>  test/TEST-30-ISCSI/create-root.sh    |   34 ++++++++++
>  test/TEST-30-ISCSI/cryptroot-ask     |    6 ++
>  test/TEST-30-ISCSI/hard-off.sh       |    2 +
>  test/TEST-30-ISCSI/test.sh           |   68 +++++++++++++++++++
>  10 files changed, 310 insertions(+), 0 deletions(-)
>  create mode 100755 modules.d/95iscsi/check
>  create mode 100755 modules.d/95iscsi/install
>  create mode 100755 modules.d/95iscsi/iscsi-netroot.sh
>  create mode 100755 modules.d/95iscsi/iscsiroot
>  create mode 100755 modules.d/95iscsi/parse-iscsiroot.sh
>  create mode 100644 test/TEST-30-ISCSI/Makefile
>  create mode 100755 test/TEST-30-ISCSI/create-root.sh
>  create mode 100755 test/TEST-30-ISCSI/cryptroot-ask
>  create mode 100755 test/TEST-30-ISCSI/hard-off.sh
>  create mode 100755 test/TEST-30-ISCSI/test.sh

Perhaps I missed it, but where do you create the VM that hosts the isci
target?  That would make fully automating this test much easier for
those of us who do not have a spare iscsi target lying around.

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
