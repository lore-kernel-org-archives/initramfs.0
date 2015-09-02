From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut --reproducible by default
Date: Wed, 2 Sep 2015 12:16:21 +0200
Message-ID: <55E6CC75.5080206@redhat.com>
References: <87a8tnvhs0.fsf@foo.bar.baz> <87vbc3fpd5.fsf@foo.bar.baz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vbc3fpd5.fsf-QWOdrvsUieXjVZl2hYKjvQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Giuseppe Scrivano <gscrivan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 25.08.2015 15:51, Giuseppe Scrivano wrote:
> ping?
> 
> Giuseppe Scrivano <gscrivan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:
> 
>> Hi,
>>
>> We are currently considering to feed Dracut with --reproducible in the
>> rpm-ostree[1] project when creating a new OStree[2] tree image.  In this
>> way there won't be need to store an additional file when the new initrd
>> file matches an older one.  Everything works very well (except the
>> additional step of providing a patched GNU cpio for now).
>>
>> Reproducible images seem to make a lot of sense, also for users that
>> don't know about the --reproducible option.  Is there any reason why
>> this is not done by default?
>>
>> Thanks,
>> Giuseppe
>>
>> 1) https://github.com/projectatomic/rpm-ostree
>> 2) https://github.com/GNOME/ostree/

No significant reason, except the penalty of the extra step, which fixes all
the timestamps.
