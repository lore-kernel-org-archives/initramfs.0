From: olivier.lahaye1-GANU6spQydw@public.gmane.org
Subject: bug (option --local) /bin/dracut: line 1719:
 /usr/lib/dracut/lsinitrd.sh: No such file or directory
Date: Fri, 24 Mar 2017 16:37:42 +0100 (CET)
Message-ID: <1568226327.12431096.1490369862327.JavaMail.root@spooler6-g27.priv.proxad.net>
References: <1510197854.12430576.1490369847277.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1510197854.12430576.1490369847277.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi,

I've found another bug:
if using --local, then dracut tries to run /usr/lib/dracut/lsinitrd.sh instead of lsinitrd

On fedora 25 (dracut-044-78.fc25.x86_64), the problem is line 1719.

Regards,

-- 
   Olivier LAHAYE
