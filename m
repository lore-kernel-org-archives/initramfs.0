From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH 1/1] added extention to module files
Date: Wed, 18 Feb 2009 17:17:30 +0100
Message-ID: <ac3eb2510902180817y380a7cddh940ba268bb46da97@mail.gmail.com>
References: <1234960574-32612-1-git-send-email-ro@duskblue.org>
	 <9594AD60-9303-4345-8FC6-B59FAA2C60EE@gmail.com>
	 <82ecf08e0902180756u2e007426vdd7116c03e72925e@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <82ecf08e0902180756u2e007426vdd7116c03e72925e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Feb 18, 2009 at 16:56, Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> You will also need to modify the dracut script to only source modules with
>> the .sh extension, and make sure the $dracutmodules functionality still
>> works as expected.
>
> Well, the current match:
>
> # source all our modules
> for f in "$dsrc/modules"/*[^~]; do
>
> Worked for reading the .sh files (but not only the .sh files, of course)
>
> However, I'm not that familiar enough to bash to adapt this match to
> only .sh files (I tried a couple of things)

You mean:
  for f in "$dsrc/modules"/*.sh; do
?

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
