From: Andy Grover <agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [systemd-devel] [RFC] iscsid / systemd / dracut integration effort
Date: Wed, 12 Dec 2012 16:45:46 -0800
Message-ID: <50C9253A.6060409@redhat.com>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com> <50C67697.7020208@gmail.com> <20121211232646.GC5307@straylight.hirudinean.org> <20121212204545.GA23313@mother.jarsat.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121212204545.GA23313-bmXekecGUa3k6X4NQihNpw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?ISO-8859-1?Q?=22J=F3hann_B=2E_Gu=F0mundsson=22?= <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/12/2012 12:45 PM, Tomasz Torcz wrote:
> On Tue, Dec 11, 2012 at 03:26:46PM -0800, Chris Leech wrote:
>> Thanks, this got me going in the right direction.  These unit files
>> seems to be working much better for me, with the startup and shutdown
>> ordering between iscsi, iscsid, and remote-fs mounts sorted out.  I'm
>> not sure about the tgtd/targetcli stuff, not sure what the original need
>> there was.
> 
>   "After tgtd" was added in Fedora for cases when system accesses targets
> exported by the same system. So targets would be configured first, and
> only then accessed by iscsid.  "after tgtd" was added, "after targetcli" is natural
> expansion of it.

See, I figured target should come after initiator, so target could
re-export iscsi-initiator-backed block devices :-)

-- Andy
