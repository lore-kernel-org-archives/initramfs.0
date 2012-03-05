From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading IMA
 custom policies
Date: Mon, 05 Mar 2012 13:11:51 -0500
Message-ID: <1330971113.2177.9.camel@falcor.watson.ibm.com>
References: <1329922381-13451-1-git-send-email-roberto.sassu@polito.it>
	 <1329922381-13451-2-git-send-email-roberto.sassu@polito.it>
	 <20120305143950.GV10929@tango.0pointer.de> <4F54E688.2020306@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F54E688.2020306-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Mon, 2012-03-05 at 17:15 +0100, Roberto Sassu wrote:
> On 03/05/2012 03:39 PM, Lennart Poettering wrote:
> > On Wed, 22.02.12 15:52, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:
> >
> > Heya,
> >
> >> +       policy = mmap(NULL, policy_size, PROT_READ, MAP_PRIVATE, policyfd, 0);
> >> +       if (policy == MAP_FAILED) {
> >> +               log_error("mmap() failed (%m), freezing");
> >> +               result = -errno;
> >> +               goto out;
> >> +       }
> >> +
> >> +       while(written<  policy_size) {
> >> +               ssize_t len = write(imafd, policy + written,
> >> +                                   policy_size - written);
> >> +               if (len<= 0) {
> >> +                         if (errno == EINVAL)
> >> +                                   log_error("Invalid line #%d in the IMA custom policy file %s",
> >> +                                             policy_line_number, IMA_POLICY_PATH);
> >> +
> >> +                         log_error("Failed to load the IMA custom policy "
> >> +                                   "file %s (%m), ignoring.", IMA_POLICY_PATH);
> >> +                         goto out_mmap;
> >> +               }
> >> +               written += len;
> >> +               policy_line_number++;
> >
> > I don't understand the counting here of policy_line_number? You attempt
> > to write the whole policy at once, no? How does this counting of line
> > numbers work here then? Or does the write() call on the kernel file
> > actually only accept one line at a time? If that's the case is it really
> > a good idea to rely on that behaviour? Knowing how these things go
> > eventually things might get optimized to read more than one line at once
> > and then the counting here will be off. Maybe it makes sense to drop the
> > counting entirely here?
> >
> 
> Hi Lennart
> 
> yes, the kernel interface accepts only one line at time. I implemented
> this code because it is not possible to known from the kernel logs what
> is the invalid line if the policy contains several lines. Indeed, IMA
> sends an audit message for each parsed rule, so that some are dropped
> due to the rate limit of audit.
> 
> I agree that is not a good idea writing a code that depends on the
> specific implementation of how the policy loading is handled. So, a
> solution may be to drop the counting code here and to solve the issue
> by allowing IMA to send an audit message only when an invalid rule is
> encountered.
> 
> Mimi, do you agree with that?

With the audit log rate limiting, the current method is not very
informative.  How about implementing the securityfs 'read' ops to
display the rules?   Then, displaying only the invalid rule makes sense.

thanks,

Mimi
