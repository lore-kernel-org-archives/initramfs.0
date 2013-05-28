From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PROBLEM: Errors in instmods_1 are ignored
Date: Tue, 28 May 2013 16:12:52 +0200
Message-ID: <51A4BB64.6090801@redhat.com>
References: <6426657.ZbTK3INMtd@ernie> <51A49C8E.2040201@redhat.com> <7214709.kLtJDThxKr@ernie>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7214709.kLtJDThxKr@ernie>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/28/2013 04:09 PM, Dennis Schridde wrote:
> Hello Harald!
> 
> Am Dienstag, 28. Mai 2013, 14:01:18 schrieb Harald Hoyer:
>> On 05/09/2013 01:18 PM, Dennis Schridde wrote: instmods -c a b c || exit
>> 1
>> 
>> will give you:
>> 
>> F: Failed to install a
>> 
>> and dracut will exit.
> So this could be used to implement variant 2 of my "expected behaviour. It
>  would be nice if you could change dracut in this way. :)

Why change? It already works that way.

> 
>> instmods ignores the errors.
> It seems to me it currently does not. At least no module that comes after
> the failed one in the list is being installed. When looking at the code,
> errors indeed seemed to be ignored.
> 
> Best regards, Dennis
> 

Hmm, when I checked that before writing this email, dracut git HEAD was
working as I described in the mail.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRpLtkAAoJEANOs3ABTfJw3pYQAK/vWk+AHyk4Vg+gi0i0T9OJ
f4vrgS+jRDObwhi3bi+GL/Q1v8HcLgqcfD+ds5RbU3HmC3WwqqsdIfu9o9jTFlzZ
MrrUrHtG+47rSpfWlGfa38rlvYSK8qcd1tvR7WIUTaMDjTO1tVyXf+vGoAfmjYKF
kiy2NlqBKk85cySMj18KICYmy7yT/XOBUs46xO1gXd+MNl4r9XseKYe2J1PEQjvy
2N3UsMb6BRvEPF7rGrce/y5zuKPU/zdvulJ91kHit/rte81N9KtkP94bqPeBqMSj
hVfLn9Fi5uvZ60j+eyObgvv/pR3J/NCuQwlMSR2tSq8fGfuDjpqW145iWWk7ki5t
9KuxEsgcsoYuN/8zaQfR4VzWFfIEK1BbgrG9vahoxMRrfKGQVyd5uxrI5cFFATqv
pGMEFu9tS5eEB84QZ92I/nHxd//FMM4aOXzkvXfyEg0Dkx+x/1WDo8/qmOknGCe7
D082erOcWhr1USM2QTve1X593F7aup5C1OuKcx7s++J5RgeN4qgbZNdeavmZ0yw9
9Ib98MElrY0zX0F6AQvdb7ge0ihoZzVFWWXRmKzNDoeR0+6nxnRYw6txM7Gd5psG
GBYjU/QP/CMMLq/8B8P5EZDocm5CseA3FjjoHI+H6428M0YGqJbhzAZK9L5BMGIr
dP7P7aFBWEqFJlnVT7lA
=T3vs
-----END PGP SIGNATURE-----
