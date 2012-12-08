From: Robert Buchholz <robert.buchholz-oPu9J1iYZYchFhg+JK9F0w@public.gmane.org>
Subject: dracut allow-discards, remaining issue
Date: Sat, 08 Dec 2012 17:35:05 +0100
Message-ID: <1354984505.3578.26.camel@saul>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Harald / list,

thanks for merging my patch to the allow-discards code recently (this is
in the 90crypt module) and addressing the problem of the missing
getargbool default. However, there's still some issues remaining:

The getargbool logic should really go before the "if discarduuids=..." 
case (instead of being an elif to it). Currently, the elif guard will
always return false, because if the configured option were '1' or 'on'
or any other string, the first case ('getargs...') would already be
triggered.

This shows that there is a conflict in 'allow-dicards' being an option
with UUID substring matching as well as a boolean interpretation. If the
user sets the option to '1' (which is True), it is not clear whether
only LUKS devices with a UUID starting with 1 should allow discards
(prefix-matching, this is the case now) or whether this should be
enabled for all devices. On the other hand, the getargbool logic is not
strict enough for handling the first 'if' case: If a user configured a
specific UUID (say, luks-2345), it must be ensured discards is not
enabled for all other devices. Thus, the getargbool function cannot be
used: It considers all non-empty strings (except "0" and "no") to be
True.

This whole thing either needs two options (allow-discards-for-device and
allow-discards-for-all-devices) or a special boolean parser that only
considers "1" and "yes" to be True, and everything else to be false.
Documentation should be changed to mention that "1" is not considered a
partial luks UUID.


Cheers,

Robert Buchholz

PS: Please CC me on replies.
