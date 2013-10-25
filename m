From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Fri, 25 Oct 2013 16:31:53 +0200
Message-ID: <526A80D9.4060907@gmail.com>
References: <5253DD0C.7050506@redhat.com> <l4dk8e$fv8$1@ger.gmane.org> <526A7412.8030804@redhat.com> <l4dsjp$20r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=6CTRtOd7dyC4+t3CoQwIpGwYQoKEwFpVap9ogUP5Bg4=;
        b=C9urw5cApygLljo6QKlQ6k+yapyE6TY0v/cHYYonOriRuJdvXFCx09curu79NwOKMG
         i/DtfjXWmvgEJuahES/ecwsET7p1hMjbSeVSwxxFgHtOe9PksB5ltqxIbQXi6Sn/yyc4
         b4BJBXjGKNvtpZeBBnY+F9oYz+gPuFgOp3oedCFr80+1ORR6gG494DE22vNGzoxp8P9z
         pO49CGD6tefXtjvhR0w5NXjbXIpnmeriTtTe2lrurZrD3JPVvwCgLPO6nTVFfMyK9xEY
         MnLr+tZqNbm9tyKEPdsQ3/E+yRVzLVR49uGOA9cxSQTf6O+X2ZzhUQnvlHiHusszVjRm
         Xufw==
In-Reply-To: <l4dsjp$20r$1@ger.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: dirteat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/25/2013 03:44 PM, EatDirt wrote:
> On 25/10/13 15:37, Harald Hoyer wrote:
> 
>>
>> Hmmm, the usrmount module is automatically included, if /sbin/init is on /usr.
>> If it is not on /usr, normally /sbin/init can mount /usr via fstab.
>>
> 
> Interesting, thanks for the answer. On mga we have made some funny linkage:
> 
> /sbin/init -> ../lib/systemd/systemd*
> 
> and
> 
> /lib -> usr/lib/
> 
> Do you think that we may have involuntary fooled the automatic inclusion with
> symlinks?
> 

What's the output of:

# readlink -f /sbin/init

??
