From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 5 Jun 2009 21:37:33 +0200
Message-ID: <4A2973FD.1030305@bfh.ch>
References: <4A2907E7.1080008@bfh.ch> <20090605155832.GH5107@nostromo.devel.redhat.com> <4A2941CD.1070709@redhat.com> <4A295FB4.6020306@bfh.ch> <20090605182106.GA26921@redhat.com> <1244227068.6963.37.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244227068.6963.37.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



David Dillow wrote:
> On Fri, 2009-06-05 at 14:21 -0400, Dave Jones wrote:
>> Just because the scripts don't use it, doesn't mean it doesn't have
>> value in the initramfs.  Being dropped to a rescue shell and not
>> being able to cat files for diagnostics is sort of annoying.
> 
> So build cat as a shell function :)
> 
> More seriously, I agree it is helpful to have some tools available when
> trying to debug, or develop dracut. But when I move this into production
> in a cluster here, I'm going to want my image as lean as I can get it.
> 
> What do you think of making a module, say 99useful-tools, what installs
> various tools that would be helpful, and have it installed by default.
> That way, it is easy to have the best of both worlds.

Not quite. Since 99useful-tools (or 95debug come to that) would have to 
be pulled in as a dependency if your module-scripts use tools from there.

debugging on the console: yes, I agree completely. Inside scripts: 
Please use only if there's no other (readable) way.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
