From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [PATCH 2/2] main: added support for loading IMA
 custom policies
Date: Mon, 05 Mar 2012 17:15:04 +0100
Message-ID: <4F54E688.2020306@polito.it>
References: <1329922381-13451-1-git-send-email-roberto.sassu@polito.it>
	<1329922381-13451-2-git-send-email-roberto.sassu@polito.it>
	<20120305143950.GV10929@tango.0pointer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20120305143950.GV10929@tango.0pointer.de>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Errors-To: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lennart Poettering <lennart@poettering.net>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it

On 03/05/2012 03:39 PM, Lennart Poettering wrote:
> On Wed, 22.02.12 15:52, Roberto Sassu (roberto.sassu@polito.it) wrote:
>
> Heya,
>
>> +       policy = mmap(NULL, policy_size, PROT_READ, MAP_PRIVATE, policyfd, 0);
>> +       if (policy == MAP_FAILED) {
>> +               log_error("mmap() failed (%m), freezing");
>> +               result = -errno;
>> +               goto out;
>> +       }
>> +
>> +       while(written<  policy_size) {
>> +               ssize_t len = write(imafd, policy + written,
>> +                                   policy_size - written);
>> +               if (len<= 0) {
>> +                         if (errno == EINVAL)
>> +                                   log_error("Invalid line #%d in the IMA custom policy file %s",
>> +                                             policy_line_number, IMA_POLICY_PATH);
>> +
>> +                         log_error("Failed to load the IMA custom policy "
>> +                                   "file %s (%m), ignoring.", IMA_POLICY_PATH);
>> +                         goto out_mmap;
>> +               }
>> +               written += len;
>> +               policy_line_number++;
>
> I don't understand the counting here of policy_line_number? You attempt
> to write the whole policy at once, no? How does this counting of line
> numbers work here then? Or does the write() call on the kernel file
> actually only accept one line at a time? If that's the case is it really
> a good idea to rely on that behaviour? Knowing how these things go
> eventually things might get optimized to read more than one line at once
> and then the counting here will be off. Maybe it makes sense to drop the
> counting entirely here?
>

Hi Lennart

yes, the kernel interface accepts only one line at time. I implemented
this code because it is not possible to known from the kernel logs what
is the invalid line if the policy contains several lines. Indeed, IMA
sends an audit message for each parsed rule, so that some are dropped
due to the rate limit of audit.

I agree that is not a good idea writing a code that depends on the
specific implementation of how the policy loading is handled. So, a
solution may be to drop the counting code here and to solve the issue
by allowing IMA to send an audit message only when an invalid rule is
encountered.

Mimi, do you agree with that?

Thanks

Roberto Sassu


> (Something else thing that gets me thinking: by mmap()ing the source
> file you imply that the policy can never grow beyond 2G or so. I presume
> that's not a problem, right?)
>
> Otherwise looks good.
>
> Lennart
>
