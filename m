From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4 branch usrmove] add ssh client module
Date: Mon, 26 Dec 2011 12:53:41 +0800
Message-ID: <CAM_iQpXF-mm0O1mQftE_-DTHH6RSufFMuJxbODsGyPnAYBOyFw@mail.gmail.com>
References: <20111223080416.GA12662@darkstar.nay.redhat.com>
	<jd73sv$rf9$4@dough.gmane.org>
	<4EF7D6F8.2040909@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fa6NmFcK2I/5HiyQEFxpoSXK26lYyLj+n6kKPBK625o=;
        b=gwnRgpwa/o8E7kjZwqzIoDQPFNzs/j+15qt9mGpS9chhQuqGtucy5IXyT8VBGxYjtP
         IFdX+GASNFAYi6JW3VW7GjaSZ1BOsPC74O9Igvrh3kYbhbAL6IXFb+di5WwTKxWHoT6P
         l10OhzMRbAQWyjHn9tqVzwOu8s16ZORsnza/c=
In-Reply-To: <4EF7D6F8.2040909-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Dec 26, 2011 at 10:07 AM, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 12/25/2011 08:11 PM, Cong Wang wrote:
>
>> On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> Hi,
>>>
>>> This is a ssh-client module for dracut. The first user could be kdump
>>> because kdump need to scp vmcore to remote machine.
>>>
>>
>> Nitpick: why not call it "ssh" module instead of "ssh-client" module?
>
>
> ssh-client is better, maybe future there will be ssh-server come in.
> In debian they are also two different packages.
>

Ok, makes sense, it is better to put this into the patch description.
