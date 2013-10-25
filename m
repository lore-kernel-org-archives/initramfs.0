From: EatDirt <dirteat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Fri, 25 Oct 2013 15:44:34 +0200
Message-ID: <l4dsjp$20r$1@ger.gmane.org>
References: <5253DD0C.7050506@redhat.com> <l4dk8e$fv8$1@ger.gmane.org> <526A7412.8030804@redhat.com>
Reply-To: dirteat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <526A7412.8030804-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 25/10/13 15:37, Harald Hoyer wrote:

>
> Hmmm, the usrmount module is automatically included, if /sbin/init is on /usr.
> If it is not on /usr, normally /sbin/init can mount /usr via fstab.
>

Interesting, thanks for the answer. On mga we have made some funny linkage:

/sbin/init -> ../lib/systemd/systemd*

and

/lib -> usr/lib/

Do you think that we may have involuntary fooled the automatic inclusion 
with symlinks?
