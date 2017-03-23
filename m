From: olivier.lahaye1-GANU6spQydw@public.gmane.org
Subject: Most effective way to find dracutbasedir (needed in a Makefile that
 will install my dracut module)
Date: Thu, 23 Mar 2017 17:57:45 +0100 (CET)
Message-ID: <1172218691.8801059.1490288265869.JavaMail.root@spooler6-g27.priv.proxad.net>
References: <1003446364.8786805.1490288037769.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1003446364.8786805.1490288037769.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi,

Is there a simple way to display the dracutbasedir as it seems that it's not always the same. Sometimes it's /usr/share/dracut, sometimes it's /usr/lib/dracut, maybe other paths?

I'd like that my makefile works on all distros where dracut is available.

Thanks in advance.

-- 
   Olivier LAHAYE
