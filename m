From: "Nathanael D. Noblet" <nathanael-sGhsi8tFlmY@public.gmane.org>
Subject: Mandos support in Dracut
Date: Tue, 29 Oct 2013 17:03:07 -0600
Message-ID: <52703EAB.4080102@gnat.ca>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

   So I've spent about two days on this and I think it may be over my 
head. I'm trying to add mandos to both EPEL and Fedora systems.

   The project provides a client that sets up a TLS connection to a 
server and receives its encryption keys over that connection and in a 
pgp encrypted message. This allows for unattended servers to reboot and 
have an encrypted root fs.

   Unfortunately I'm totally lost, the upstream project is looking into 
adding support but I don't know how long that will take. I don't mind 
doing some of the work however I'm so lost that its hard to know where 
to go, what to do.

   I'm wondering if there is someone who wants to mentor me on what 
needs to happen. I somewhat get the ask-password system. I've taken the 
ask-password agent code from systemd and modified it to call the mandos 
client. I've got little idea on how to compile it to test it though. I'm 
also very much confused as to how I can say that the network will have 
to be up before it tries to get the key for decryption.

   The project itself is part of debian but their initsystem *and* 
crypttab are sufficiently different that there wasn't much to learn by 
how they go about doing it.

   I would really appreciate any pointers/help possible. I have many 
questions and few answers...

-- 
Nathanael d. Noblet
t 403.875.4613
