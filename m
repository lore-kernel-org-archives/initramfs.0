From: Leonid Bloch <lb.workbox@gmail.com>
Subject: Adding initramfs as an ELF section to bzImage
Date: Tue, 23 Oct 2018 14:29:22 +0300
Message-ID: <CAOwCge2F92GninYqckfrpOaTghsAUiESqpNUUpQLzvvBwOS87g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GxaUldInxt8S0WOf96/f1dggEVygmb1yXVURh5ZUr7A=;
        b=OAP3h7O060GVB81SnN62qM9o3uJ0DeOVq9JnlEkYlTw8hDX9BZCJjcEFRaiIYTH99t
         HIOfLeQ+y7j09q4vfhzPtVpNFR/4TooErcD78R0k5z3J0KBBgFcsNkM81e10PFxt/tCl
         NHAVPEE7kVRY8av/OntQ9pkqoFzrkJ/ne47dwVRORwSlBt487F7WQNebK8AZQBRjgrs0
         M7h+GTAEEW+sHdCFvGVEaA20Zyqv8Or3DHyPDQWaAqLVqLeSxF/DLNg8dWbeS4afXIGP
         zH0hiTXutB+LLWH2c8nnDtewkowP3gsLCrHliZTfvKhThq6MraVg3Tcy0ZlDgH6izd+T
         JJaw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, initramfs@vger.kernel.org

Hello,

I am wondering if it is possible to add initramfs as an ELF section to
the bzImage, and if so - how?

I am aware that it is possible to compile-in an initramfs or to supply
it as an external file. Both of these options don't fit my needs. The
first one doesn't fit because it is very difficult to manipulate after
compilation, and the second - because I need a single file.

It looks like there should be no problem to append a section to the
bzImage for loading into memory as initramfs, but I didn't find a way
to do it yet.

Regards,
Leonid.
