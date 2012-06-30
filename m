From: Paulius Zaleckas <paulius.zaleckas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dracut does not load pata_atiixp module
Date: Sat, 30 Jun 2012 15:16:55 +0300
Message-ID: <4FEEEE37.4070105@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=tGIDnYlbRACROysoLbkJ5fR2Zmb8drwhhPGmltjtguo=;
        b=wHHqQKmUGTO2erwQC/lbIyvHr+sqN3ZV1nVPYVxEep2Ax+I7Kk6k/RjG5Lcfif9/YV
         w9Y9jDi1UUUUzSnZWwrfWp9t+M2xRVYty3eL74XNQX+d+89DBnC7+pQTKI2n30/mud+o
         PHzCbK5Um4Mi+VeYx7AF/p1cU/WBcKlcecyk8JuQC4HmNFVq3/RJNAA9aFAWKw8szd36
         JrxJM3z+7tcHapPNJfebGwS/PltFWMaWiwNaS4AeUNDpx4qs40gIWPWuN1Q1C1MmwxEb
         NVZwhKFi2W5teazELei7JOqTz2yivcga2D+D1/r+U264sMJkeist1y9yxywMuCwNcPiB
         PeSg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I have upgraded F16->F17 with preupgrade and booting
with F17 kernel fails. The reason is that dracut fails
to find my root HDD (sdb). Module pata_atiixp has to be
loaded for it to appear. This module exists in initramfs,
but dracut does not load it... F16 initramfs loads it
and boots OK. I am really willing to help nail this bug.

Dracut version is: 018-40.git20120522.fc17
failing kernel: 3.4.3-1.fc17.x86_64
