From: olivier.lahaye1-GANU6spQydw@public.gmane.org
Subject: dracut module writing howto/doc?
Date: Wed, 29 Apr 2015 10:44:53 +0200 (CEST)
Message-ID: <168899060.1173304576.1430297093239.JavaMail.root@spooler6-g27.priv.proxad.net>
References: <868592098.1173300648.1430297012192.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <868592098.1173300648.1430297012192.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi, 

I'm looking forward how to write a dracut module named 98systemimager. Despite my googling, I was unable to find somting enought sofisticated that would help me. 
Right now, The following stuff is working: 

dracut --force \ 
    --install " $(FOUND_INITRD_BINARIES) " \ 
    --filesystems "ext2 ext3 ext4 xfs jfs hfs reiserfs nfs" \ 
    --include $ ( INITRD_BUILD_DIR ) / \ 
    --no-hostonly --no-hostonly-cmdline \ 
    --add network \ 
    --add syslog \ 
    --add debug \ 
    --omit usrmount \ 
    $(INITRD_DIR)/initrd.img $(KVER) 

What I want is: 

dracut --force --add systemimager $(INITRD_DIR)/initrd.img $(KVER) 

I've started writing module-init.sh with basic skeleton 
So in other works I'd like to create a dracut module that would do the following stuffs: 
    - Depends on network and syslog (already ok)
    - disable usrmount module: is it possible to do that? 
    - enable --filesystems "ext2 ext3 ext4 xfs jfs hfs reiserfs nfs" so kernel modules (if not in kernel) and fs utils (mount, ...) are automatically included. 
    - include a full subtree: should I use (cd $ ( INITRD_BUILD_DIR ); tar cpf -)|(cd $initrdtemp; tar xpf -) ? 
    - enable by default --no-hostonly --no-hostonly-cmdline so most drivers are put into the initramfs. 

Aside that, I'm trying to understand the differences between the dracut hooks and native .services files. Currently, I'm using my own .services files to start network. If I replace this file with a hook (starting dhclient), would it work on centos6 that lacks systemd? 

Thanks a lot for any tips, infos or docs that would help me fullfill this need. 

Best regards. 

-- 
   Olivier LAHAYE
