From: Felix Blanke <felixblanke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dracut and fstab.sys problem
Date: Thu, 02 Feb 2012 00:45:33 +0100
Message-ID: <4F29CE9D.1070604@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=lxLDC0B/4dAI9R5GXTyMHtFVj5qTVBWr27UdgsJbH+E=;
        b=MBjvjiV+RGWP2EZIeQRS8prc/6831PYSvy4p/flpjTLGETanIJMfoNCRzKYrTrf3Ix
         CrgZKayTMzU/Yey6TthuFHd2LnkBjmduP9eQxdSS0ZwIhLjJUh+W53/ZUKobUtjwuOhN
         L+0UoRdSVeiMqOiYId7qTnQOil83GEOb0q958=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I'm using dracut since tonight and really like this kind of approach. 
Makes the life a lot more easy. So thanks for this piece of software.

My problem:

I'm using btrfs as my root fs. I have subvolumes for better snapshot 
control, like /etc, /var, /root and so on. In etc is a lot of stuff need 
during boot time (like fstab, inittab). Therefore it must be mounted 
before dracut is starting the real boot.

I tried to put it /etc into the fstab.sys. But whenever I boot I get a 
msg like "/dev/sda3 is allready mounted or /sysroot/etc is busy". Ofc. 
/dev/sda3 is allready mounted, I just want to mount a subvolume from 
that disk.
Is there a way to force the mount? I tried the "force" option in the 
fstab.sys (like "mount -o force"), but I does not work.

Any thoughts?


Please CC me as I'm not subscribed to the list. Thanks a lot in advice.



Kind regards,
Felix Blanke
