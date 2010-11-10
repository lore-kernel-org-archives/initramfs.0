From: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Subject: Re: [PATCH] add fake root support
Date: Wed, 10 Nov 2010 16:54:41 +0200
Message-ID: <4CDAB231.80903@hoster-ok.com>
References: <4CBDB007.4090802@hoster-ok.com> <4CCECBB0.3030609@hoster-ok.com> <4CDAAA70.1070302@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CDAAA70.1070302-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

10.11.2010 16:21, Harald Hoyer wrote:
> On 11/01/2010 03:16 PM, Vladislav Bogdanov wrote:
>> 19.10.2010 17:49, Vladislav Bogdanov wrote:
>>> Attached is a patch for "fake" root functionality,
>>> I'm (mostly) duplicating issue's description from my previous e-mail
>>> (for commit message if this is to be pushed):
>>>
>>
>> Sorry for being annoying, but... Any comments?
>>
>> Best,
>> Vladislav
>>
> 
> I like it, but I don't like the parameters...
> 
> Maybe we can express it like this:
> 
> netroot=fake:xxx.yyy.zzz.www:/mnt root=live:blablabla

This can be used not only with nfs I think...
nfs is just one use case which I needed for my project.

And information after fake: should be some-how handled in dracut, but I
currently do not see any use-cases for that. Do you see them? iSCSI? Is
it really needed so early if it is not for root?

And, I'd not mount not-root nfs from within dracut, we need to know
mount point on a real system for that. Additionally, I've already had
much fun with nfs4 and root user access to files. This requires
rpcidmapd, and it has too many dependencies (and properly configured
resolver).

I'd keep it generic, thus making it possible to start network-enabled
node solely from PXE. It is much easier to exploit generic solutions
(IMHO) for own needs.

> 
> and find another name for "fake".. maybe "container"?
Hmmm....
The main idea was to have networking configured without real networked root.
Current dracut policy is to skip networking if no networked root is
configured. That's why I called it 'fake' - I'm cheating with this policy.
I agree that 'fake' is not a best name.
Container... then there should be some contents, but I do not see it...

netroot=force?
networking=force?
Later would require additional efforts, but sounds quite nice for me.

> 
> netroot=container:nfs:xxx.yyy.zzz.www:/mnt root=live:blablabla
> 
> Which reminds me, that we should probably have the possibility to
> concatenate several stages.
> 
> root=nfs:xxx.yyy.zzz.www:/mnt|loop:test.img|live:blablabla

This is quite interesting. But this is from another story.

> 
> comments?
