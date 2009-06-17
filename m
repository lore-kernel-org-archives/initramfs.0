From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Redundant nfsroot cmdline options
Date: Wed, 17 Jun 2009 09:18:56 +0200
Message-ID: <4A3898E0.8090700@bfh.ch>
References: <4A36A510.5010709@redhat.com> <20090617034849.GA22705@thedillows.org> <4A386B20.9010205@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A386B20.9010205-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami wrote:
> On 06/16/2009 11:48 PM, Dave Dillow wrote:
>> On Mon, Jun 15, 2009 at 03:46:24PM -0400, Warren Togami wrote:
>>> I am concerned about the proliferation of too many redundant ways of
>>> configuring netboot.  We should clearly document each supported method
>>> on this Wiki page and figure out which methods should be cut.  The most
>>> obvious methods to cut are NEW inventions of dracut that are redundant
>>> to other methods.
>>
>>> root=nfs       nfsroot=...
>>> root=nfs4      nfsroot=...
>>> root=/dev/nfs4 nfsroot=...
>>>
>>> These are all new inventions in dracut, redundant to the following
>>> native methods already supported.
>>
>> These short cuts are simple, and fall naturally out of the current 
>> command
>> line parsing. I don't expect validating them to be any harder than the
>> translation I already do into the canoncical nfs[4]:IP:/path:options
>> format -- you validate the canonical. Documenting them is not very
>> difficult, either. Maybe there is a potential of user confusion, but you
>> hide them away in the "Legacy support" or "Non-recommended" appendix.
>>
>> I simply don't see the problem.
>>
>> But, I'm tired of having this same coversation every few days and I
>> don't care enough to continue it now. I'm not going to lose sleep if 
>> these
>> options are gone, so rip them out if that's your fancy.
> 
> I have great respect for the work and effort you've put into this, but 
> it just doesn't make sense to add multiple redundant syntaxes of doing 
> exactly the same thing.  I accepted it earlier because I was under the 
> impression that all of the above were Legacy syntax from kernel's 
> nfsroot.txt.  But now I realize it is invented for dracut.

Same here, only I though the syntaxes not involving /dev/ (and nfs4) 
were a redhattish invention. Which they aren't as Warren's already 
pointed out.

> 
> Furthermore it makes less sense to add redundant syntaxes immediately 
> for them to be classified as Legacy.

For parsing it doesn't actually really matter much how many 
[net]root=*nfs* variants we have. As long as nfsroot stays in for 
compatibility all is well.

> Also,
> 
> root=/dev/nfs4 nfsroot=...
> 
> How is this a shortcut for
> 
> root=nfs4:...

For one root=/dev/nfs[4] nfsroot=server:/path[:,]options is translated
to netroot=nfs[4]:server:/patch:options. This is not really a shortcut, 
but simplifies transition to a newer syntax or let's people try out nfs 
without changing much.

And then there's the option (as documented in kernel nfsroot.txt) of 
leaving nfsroot= away, forcing us to use a rather special variant of 
dhcp root-path.

If it's really that important I suggest we rip out the mentioned 
[net]root=[nfs,nfs4,/dev/nfs4]. root=/dev/nfs is required for kernel 
legacy support. If someone wants nfs4, they should use the preferred 
syntax [net]root=nfs4:server...

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
