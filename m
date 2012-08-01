From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: Re: [PATCH] Revert "dracut-functions: $_x should exist, no need to
 test."
Date: Wed, 01 Aug 2012 22:44:45 +0200
Message-ID: <5019953D.6080203@ziu.info>
References: <1343791422-8391-1-git-send-email-chaowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343791422-8391-1-git-send-email-chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wangchao19890207-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

On 2012-08-01 05:23, Chao Wang wrote:
> This reverts commit b2d225a6698607bbcb73b6e6d12fbfc5be014102.
>

For the record, your original commit could work after setting:

shopt -s nullglob

For failing globs this expands to empty string and the loop is never 
executed. All kinds of such checks could go away in any bash-expecting 
script.
