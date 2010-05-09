From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH] Do not require .conf suffix for files in /etc/modprobe.d
Date: Sun, 9 May 2010 21:05:40 +0200
Message-ID: <h2kac3eb2511005091205wab35af61ib3eefefb7d5c1598@mail.gmail.com>
References: <20100509182404.3768.46609.stgit@cooker>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100509182404.3768.46609.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, May 9, 2010 at 20:24, Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org> wrote:
> Currently dracut will install only modprobe configuration files
> matching *.conf. module-init-tools itself does not have this restriction
> and uses blacklist for known pre-/suffixes instead. Some distributions
> (e.g. Mandriva) widely use files without .conf suffix. Let dracut
> accept the same set of files as module-init-tools will.

Module-init-tools plans to require that, for now it just prints an
error for conf files without this suffix, that states that this will
no longer work in a future version. Distros should better fix all
these files instead.

Kay
