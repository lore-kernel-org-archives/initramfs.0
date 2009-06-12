From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH 2/5] network/netroot
Date: Fri, 12 Jun 2009 23:19:50 +0200
Message-ID: <4A32C676.6000308@bfh.ch>
References: <4A32703A.8080603@bfh.ch> <4A3271CC.9090608@bfh.ch> <4A32B75A.4090405@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A32B75A.4090405-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Warren Togami wrote:
> On 06/12/2009 11:18 AM, Seewer Philippe wrote:
>> +    # Default: We don't know the interface to use, handle all
>> +    else +    printf 'ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup
>> $env{INTERFACE}"\n'
>> +    fi
> 
> "else +"?
*sigh* Why does this ever only happen with bigger patches?

> BTW, could you please remove the die() and push all of this to a git 
> repo so it can be pulled cleanly?

Can you recommend a place to set up a public git repo? Can't do it here 
I'm afraid.

And: With what should I replace die()?

Thanks!
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
