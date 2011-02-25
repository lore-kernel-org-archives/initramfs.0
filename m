From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] load dracut.conf.d before dracut.conf
Date: Fri, 25 Feb 2011 13:43:10 +0100
Message-ID: <4D67A3DE.5030107@redhat.com>
References: <201007140205.35944.maarten.vanraes@gmail.com> <4C46DCD0.3020608@redhat.com> <4D280724.8050405@mandriva.org> <4D5E46DC.4020303@redhat.com> <4D614F8D.10505@mandriva.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D614F8D.10505-4qZELD6Fgxhg9hUCZPvPmw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Anssi Hannula <anssi-4qZELD6Fgxhg9hUCZPvPmw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 20.02.2011 18:29, schrieb Anssi Hannula:
> What's the purpose of /etc/dracut.conf then?
> 
> If you don't think my previous patch was reasonable, I suggest removing
> it completely :)
> 

True, indeed we can think about it. Like /etc/modprobe.conf is gone now in
favour of /etc/modprobe.d.
