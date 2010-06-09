From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/4] Do not worry at all about selinux stuff if we cannot
 find load_policy
Date: Wed, 09 Jun 2010 17:38:21 +0200
Message-ID: <4C0FB56D.1060403@redhat.com>
References: <4b22ffbe9ef3f55ac4fad54bd58f9cf9fc345b22.1275480426.git.victor.lowther@gmail.com> <d0ba9e0f511ab3e4b0cca6d3d0551ae7a881385f.1275480426.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d0ba9e0f511ab3e4b0cca6d3d0551ae7a881385f.1275480426.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/02/2010 02:07 PM, Victor Lowther wrote:
> Forcing users to pass selinux=0 when operating on a system that does not and
> never has used selinux is really annoying.
...

hmm, I moved selinux to a separate module and will think of another mechanism
