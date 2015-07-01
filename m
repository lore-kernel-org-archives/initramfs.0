From: "Nathanael D. Noblet" <nathanael-sGhsi8tFlmY@public.gmane.org>
Subject: initramfs / cryptsetup decryption
Date: Wed, 01 Jul 2015 08:48:08 -0600
Message-ID: <1435762088.18436.4.camel@gnat.ca>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

  So I've been trying to figure out how to have remote systems with
encrypted partitions (including / ) be encrypted but be able to reboot
them remotely.

  Originally I had found the mandos project. However due to one of its
dependencies you can't have one server handle multiple clients of
different types. Plus modifying dracut so that the network works
properly was just a huge headache.

  That left me with a thought. What if I was able to give an argument
to a special 'reboot' command. This would place the password somewhere
(either in the initramfs, or elsewhere) and then dracut would read it
on boot and then remove it afterwards. So if the computer is shutdown
or normally rebooted you would have to input the encryption key.
However if I rebooted it remotely using this 'script/wrapper command'
it could reboot completely.

  So I'm wondering does this sound doable? Secure enough? Would you
expect that modifying the initramfs is plausible or should I be writing
to a file in /boot or something like that? Thoughts?

-- 
Nathanael
