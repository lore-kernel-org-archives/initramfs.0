From: EatDirt <dirteat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Mon, 28 Oct 2013 15:58:11 +0100
Message-ID: <l4lu1q$ff8$1@ger.gmane.org>
References: <5253DD0C.7050506@redhat.com> <l4dk8e$fv8$1@ger.gmane.org> <526A7412.8030804@redhat.com> <20131028134216.049c6a01@work.puleglot> <20131028164537.5e464c82@work.puleglot>
Reply-To: dirteat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131028164537.5e464c82-d/9N6kaejYfpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 28/10/13 13:45, Alexander Tsoy wrote:

>
> Same applies to systemd installed in "/". I think there are only 2
> cases when usrmount module can be omitted:
> 1. systemd module is included
> 2. hostonly + non-separate /usr

Agreed, I tested with systemd included and that indeed works fine.

