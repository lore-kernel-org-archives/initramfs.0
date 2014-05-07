From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Intend of hostonly-cmdline?
Date: Wed, 07 May 2014 14:08:02 +0200
Message-ID: <536A2222.50606@redhat.com>
References: <2263850.UM9clb02rz@skinner>	<536A19D7.2010405@redhat.com> <20140507154733.386369cd@work.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140507154733.386369cd-d/9N6kaejYfpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07.05.2014 13:47, Alexander Tsoy wrote:
> Actually hostonly-cmdline is partially broken with systemd in
> initramfs. For example systemd-cryptsetup-generator does not
> read /etc/cmdline.d/*.conf files, so rd.luks* parameters must be
> appended to kernel cmdline anyway.
> 

True! Good point!
Although /etc/crypttab is included with hostonly.
