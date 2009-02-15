From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH 1/4] Split out the various things into their own modules.
Date: Sun, 15 Feb 2009 15:38:20 +0100
Message-ID: <ac3eb2510902150638t26a70d7bg68ad7dfc0227b0ea@mail.gmail.com>
References: <62cc4ebce1de329352ba0a5434e20f38edcdad6f.1234528086.git.victor.lowther@gmail.com>
	 <ac3eb2510902130508o3ea41614y12d9887ec605a912@mail.gmail.com>
	 <1234640916.2658.2.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1234640916.2658.2.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, Feb 14, 2009 at 20:48, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, 2009-02-13 at 14:08 +0100, Kay Sievers wrote:
>> On Fri, Feb 13, 2009 at 13:37, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > This rips most of the dracut script out into seperate modules that the
>> > main dracut script then sources.
>>
>> >  modules/00dash           |    6 +++++
>> >  modules/90crypt          |    2 +
>> >  modules/90kernel-modules |    8 ++++++
>> >  modules/90lvm            |    2 +
>> >  modules/95debug          |    2 +
>> >  modules/95terminfo       |    3 ++
>> >  modules/95udev-rules     |    8 ++++++
>> >  modules/99base           |   13 +++++++++++
>>
>> Please add and require a file extension to all modules and all similar
>> to-be-looked-up files. Packages are expected to drop fiules here, and
>> it's a useless pain to filter-out editor files and package manager
>> left-over files.
>
> what, like a .sh extension?

Anything would work, I don't really mind: .dracut, .module, .mod, .inc. .sh, ...

>> The 80's are over, and this is a new project, so please let us not
>> repeat the crap many other projects are doing here. :)
>
> sorry, ms-dos and Windows gave me an irrational dislike of file
> extensions.

It's not about "identifying" content, like on MSDOS. It's about the
useless exercise to filter out unknown file patterns of
left-over/temporary files from editors and package managers. These
filters can never be complete, and stuff goes terribly wrong
sometimes, if these files are read as "normal" files. A simple file
extension will solve this problem without any guesswork, that's all.

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
