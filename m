From: tammo-v8BkjJTOJzf1qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org
Subject: [dracut] rd.shell won't work if "root=" is missing
Date: Tue, 5 Jan 2016 10:11:38 +0100
Message-ID: <trinity-fb369bfb-8623-46c4-8628-71f8a6be4d9a-1451985097774@3capp-webde-bs44>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,
=C2=A0
i just stumbled upon a detail in dracut that i found surprising and app=
ears as a small bug to me.=20

If you boot a dracut image without giving a "root=3D" parameter (or e.g=
=2E a misspelled argument to that parameter) the system will _not_ drop=
 you into a shell, even if rd.shell is set. IMHO this is not the expect=
ed behavior, as the manual says that rd.shell will drop you into a shel=
l if rd.shell is set and no root is found. So i would suggest to change=
 the "die()" function in the dracut-lib.sh and add a test for rd.shell =
in line 460 (getargbool 0 "rd.debug=3D" && emergency_shell) too. The sy=
stem will already drop you in a shell if you have a "rd.debug" paramete=
r set, but i think that rd.shell (and probably "rdshell" too) alone sho=
uld be sufficient, as this is more convinient and less surprising.

I could prepare a patch, if you prefer that.

If this is not some kind of bug, you may call it a "wishlist item" and/=
or change the documentation accordingly.

kr
Tammo


