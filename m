From: <haruo.tomita-g3qfMnKXm6lL9jVzuh4AOg@public.gmane.org>
Subject: RE: (PATCH) force LANG=C for selinux load policy
Date: Wed, 1 Jun 2011 08:02:48 +0000
Message-ID: <4915AF3239D2024A92BCEC8BDAC566CE0116FC7E@TGXML315.toshiba.local>
References: <4915AF3239D2024A92BCEC8BDAC566CE0116FA8A@TGXML315.toshiba.local>
 <4DE4B247.6010005@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DE4B247.6010005-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: ja-JP
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> Hmm, why are the messages garbled? Is the console not set up correctly?

I think that the console's being not able to display Japanese is a cause 
though the language setting is Japanese.
Therefore, force LANG=C set with dracut.
Is there something a good idea?
 --
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
