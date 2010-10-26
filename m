From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: udev question
Date: Tue, 26 Oct 2010 13:04:29 +0200
Message-ID: <4CC6B5BD.2020603@redhat.com>
References: <4CC5C26B.9060002@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CC5C26B.9060002-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/25/2010 07:46 PM, Mr Dash Four wrote:
> A simple question: in /etc/udev/rules.d/ (on the root partition!) I have a
> .rules file for one of my smartcard devices which has, among other things, this
> statement:
>
> PROGRAM="/bin/sleep 0.1"
>
> This program is not on the initramfs image, but it is in the /bin directory on
> the root partition. I was under the impression that root is not mounted until
> udev has finished its job - is that not the case? If so, how is this program
> executed then? I also have a lot of other statements with RUN+=... which also
> refer to executables not present in initramfs - they are all present in the root
> partition. When/How do these execute then?
>
> Am I missing something fundamental here?

udev runs a second time in the real root, just because of this limitation of the 
initramfs.
