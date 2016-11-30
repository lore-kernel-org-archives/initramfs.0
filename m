From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] 98integrity: Use /etc/ima as dir for IMA policy and
 config file
Date: Wed, 30 Nov 2016 16:16:22 +0100
Message-ID: <5526de6b-c774-f94b-30ce-065e03d28ce3@redhat.com>
References: <1480518634-31897-1-git-send-email-stefanb@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480518634-31897-1-git-send-email-stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

On 30.11.2016 16:10, Stefan Berger wrote:
> From: Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
> 
> To sync with systemd, use the filepath /etc/ima/ima-policy as
> the file location for the IMA policy. At the same time we
> move the ima config file location to /etc/ima/ima. Adapt the
> documentation to the new path.
> 
> Signed-off-by: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>


One more thing: Do you want to be backwards compatible and also read the old files, if they exist?
