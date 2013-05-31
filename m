From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 1/2] 99fs-lib/fs-lib.sh: Let user specify the action
 after fail for fsck
Date: Fri, 31 May 2013 09:30:02 +0200
Message-ID: <51A8517A.8080400@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe@redhat.com> <20130530170240.GH2864@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130530170240.GH2864-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/30/2013 07:02 PM, Vivek Goyal wrote:
> On Wed, May 29, 2013 at 04:38:31PM +0800, Baoquan He wrote:
>> The fsck is ignored when replace emergency_shell with action_on_fail,
>> now add it.
> 
> should action_on_fail be named rd.action_on_fail to make it explicit that
> this is an initramfs option and not a kernel command line option as such.
> 
> Vivek

Yes, please
