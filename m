From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch] busybox module: parse busybox defined functions dynamically
Date: Thu, 21 Jul 2011 15:36:25 +0800
Message-ID: <CAM_iQpUgtNtTozr89xesTF9yAh0H_dHymDcq=ptpZiq7v9hX+g@mail.gmail.com>
References: <CAM_iQpWn9SMU8NXKd-XzdXX7WZv3ba6swRcf2yYTwEJvGHN35w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=A0SGg1svUh4TP8btNSnq5pBAHzjMuXECNRscUbjeXBk=;
        b=wOH+miEaiZB1msL0nRqQpbvM+guVN9zV5MreAaOZ4suz4LWq0cU2vYnu23TJQBnckA
         i2L/4nME0Jk1CR1OKc7H+xOwhmIFjhXEMjLxqiaRYzxoLQhllh7feAgII2GoCDuGqqBA
         4qnmh/p2HYoQuGndlE14i+U4xJhs1qS2YgK3E=
In-Reply-To: <CAM_iQpWn9SMU8NXKd-XzdXX7WZv3ba6swRcf2yYTwEJvGHN35w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="macroman"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Jul 21, 2011 at 3:33 PM, Am=C3=A9rico Wang <xiyou.wangcong@gmai=
l.com> wrote:
> Currently in dracut busybox module, we hard-code the list of binaries
> available in busybox. Actually we can get this list by running busybo=
x
> without any arguments.

Note, we used this trick in mkdumprd for a long time.
