From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: chrome-os like switching partitions while update
Date: Tue, 16 Feb 2016 19:43:43 +0300
Message-ID: <CACaajQuwQxA40eTXktE1mW3p53t6CG5te=iTPurUYH-GV5sGBA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=17yxulbZo4NQ4NyhpHwhEkHegul8fUI0AGvnixuWIWw=;
        b=RPxIdkHRVSndVNIseBtsTwXwlFe0c1L2N0jVLSuNmX/+lUclAvRIBgIkiAWHRL5Df9
         gZFaj3C9fD+huVvG9c/vEtk7iPGPTxqIoV5e7l8MqIufcpqMQoTC1/Laf1V0LTqKtez+
         abW07km5zBtCpJJ1BGP52wWAbNM6woB5uQ5jU=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi! I'm interesting in chrome-os like system updates, i can create
partition layout , but how to best understand how to determine
successful boot? Best of all - avoid touching files because of
readonly fs...

-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
