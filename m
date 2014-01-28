From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Dracut: Add a new argument "--rebuild"
Date: Tue, 28 Jan 2014 15:40:42 +0100
Message-ID: <52E7C16A.2000306@redhat.com>
References: <20140116064127.13510.80220.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140116064127.13510.80220.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hari Bathini <hbathini-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mahesh J Salgaonkar <mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Manik Bajpai <manibajp-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

On 01/16/2014 07:41 AM, Hari Bathini wrote:
> Add "rebuild" option to dracut to  append the current  arguments
> to those with  which the input initramfs image was  built.  This
> option helps in incrementally building initramfs for testing.
> 
>     Usage: dracut [output_file] --rebuild input_file
> 
> If optional output file  is not provided, input file provided to
> rebuild will be used as output file.
> 
> This patch alters  the creation of the initramfs image by adding
> the file "/tmp/params.txt" to the image. Command line parameters
> excluding "--rebuild",  input  &  output image names and "kernel
> version" are stored in this file.  In case "--rebuild" parameter
> is specified, "/tmp/params.txt" file, if present in input image,
> is read and its contents "prepend"ed to the current command line
> parameters, that is if such a file is already present. Also,  it
> stores the  cumulative parameters to the file "/tmp/params.txt",
> in the  new image. This patch  has been tested successfully on a
> PowerBox with f19. It does not alter the behaviour of any of the
> existing  options.
> 
> Signed-off-by: Manik Bajpai <manibajp-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Hari Bathini <hbathini-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> ---
>  dracut.sh |  386 +++++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 260 insertions(+), 126 deletions(-)

Thanks! Pushed.

Modified slightly. Also added support to lsinitrd to display the arguments.
