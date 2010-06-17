From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: One warning message when switching root to /sysroot (which is
 the 	mount point for NFS)
Date: Thu, 17 Jun 2010 11:29:17 +0200
Message-ID: <4C19EAED.5020104@redhat.com>
References: <AANLkTimBgxVQ4C-dUBPVhG6BHNDQVpD2XFL8NmuhaDZB@mail.gmail.com> <AANLkTik38g1JnWlVZTTCRV2QNlQythULFrtHzu9E1tw5@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTik38g1JnWlVZTTCRV2QNlQythULFrtHzu9E1tw5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/12/2010 09:27 AM, Min Jun,Xi wrote:
> I have found the reason for "mount: only root can do that (effective
> UID is -2)",
> The nfs server is NFSv4-powered, NFSv4 has a concept of a root of the
> overall exported file system. The export point exported with fsid=0 is
> used as this root. If we didn't specify "fsid=0" in the /etc/exports
> file, when it is mounted by the NFS client, all the owner of the
> overall exported file system will become "nfsnobody:nfsnobody".
> Because of this, the owner of "/bin/mount" is changed to
> "nfsnobody:nfsnobody" from "root:root". when "mount" is called, the
> warning message is shown.
>

For RHEL6 you want at least dracut-004-18 to get NFS4 working.
dracut-005-3 in Fedora 13 should work as well.
