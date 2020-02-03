From: "Milan P. Gandhi" <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: Verify multipath config_dir option
Date: Mon, 3 Feb 2020 17:19:03 +0530
Message-ID: <41b94406-a790-90e0-796f-9ea461351e75@redhat.com>
References: <20200121120834.GA23866@machine1>
 <2c0c0f100442edd43b10085fa47177b54cd6d0c9.camel@suse.com>
 <20200131075840.GA4169@machine1>
 <cc660dff208809a5511ab837f4d781d8faeae442.camel@suse.com>
Reply-To: mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580730550;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0ROVAfQG1E4F+QgAXuuiHOq6xIKBt/ilYNkn82WHT0=;
        b=IrBWK8dAkHUrDXtp1lMQryfognLkwNE/0HOtcaGtKBDbnoL3H814XtuZaIxrKuWnl3i88d
        xLGosPy1EuQJbaMsgCOy6KKdYgs1tNZcTw7cDYEij/hOdjzemk917UcCGWBmTYDRsQQdE9
        HFgvv+i1vi47KAWkrO+JSBuzXYJ9B5s=
In-Reply-To: <cc660dff208809a5511ab837f4d781d8faeae442.camel-IBi9RG/b67k@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 1/31/20 2:05 PM, Martin Wilck wrote:
> Hello Milan,
> 
> thanks a lot for your response. I'm fine with your suggestions.
> 
> On Fri, 2020-01-31 at 13:28 +0530, Milan P. Gandhi wrote:
>> On Wed, Jan 29, 2020 at 10:49:21AM +0100, Martin Wilck wrote:
>>>
>>> The path (/usr/sbin/multipath) is inconsistent with what we use in
>>> multipathd.service (/sbin/multipath). I'm not against changing this
>>> to
>>> /usr, but we should be consistent.
>>
>> I used (/usr/sbin/multipath) because location of multipath binary is
>> shown in /usr/sbin. I will change it to /sbin/multipath to make it
>> more
>> consistent with the systemctl output for multipathd.service
> 
> Well, Fedora made the /usr move, which openSUSE hasn't completed yet.
> In general IMO using /usr/sbin is fine, distributions can
> patch this as it fits. But for clarity, the move should be made in a
> separate patch, so I for your patch, sticking with /sbin is better.
> 
>> $ whereis multipath
>> multipath: /usr/sbin/multipath /usr/lib64/multipath [...]
>>  
>>> And: fall back to /etc/multipath/conf.d if the command fails for
>>> some
>>> reason?
>>
>> The 'multipath -t' command runs successfully even when multipathd
>> itself
>> is stopped. And config_dir option is one of the built-in parameters,
>> so
>> if users do not modify it then it is automatically set to 
>> /etc/multipath/conf.d
> 
> Right, that makes sense. If "multipath -t" fails, something is really
> fishy and we should probably error out.
> 
>> I can add a check to verify if the config_dir parameter read from
>> multipath -t is an actual directory, and if not, fall back to above
>> default path - /etc/multipath/conf.d
> 
> I'm not sure about that. If config_dir exists and is not a directory,
> we should error out. If it doesn't exist, we should just skip it. 

Thanks Martin!
I have just now sent an updated patch with the changes.

> Btw, while you are at it: There's also the "multipath_dir" config
> option that specifies the location of the "plugin" libraries for
> multipath. This stuff is currently installed via 
> 
>    inst_libdir_file "libmultipath*" "multipath/"
> 
> But in theory at least, users can change this directory, and if dracut
> supports a modified "config_dir", it might as well support a modified
> "multipath_dir." You may argue that that's unlikely to be modified, but
> the same can be said about config_dir. Just a suggestion.
> 

Users can change "multipath_dir" config option as well, but currently
there is no check for this option. I will soon send a patch to verify
"multipath_dir" option as well.

Regards,
Milan.

