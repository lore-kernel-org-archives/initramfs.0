From: Enrico Tagliavini <enrico.tagliavini-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC] add support for plymouth text labels
Date: Fri, 25 Oct 2013 10:27:52 +0100
Message-ID: <CAMQd7maOTqdpt23WX5WB2q2WKuiyX+fR_g6u87g8mo2sw8Qxrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bd76bb25fe5f104e98d5dd7
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LpSo8ZKhwK/vDtlixVsmJLdE99objCD289uS523T6Io=;
        b=P2wRyRvPASCNvecd4pXCoPtTuZDdsXUYwPHOkMW0jiM4YM6QTUDAx/ncQHwC40HhGx
         F8V8Ps7kxFK+Oj3/D4Cq7bZ0MOSnjXQ2yL4Sjq0kclz6kqbEcF707y81sCZ0HqXDxL09
         XJ7E3zBTPQaDXR0BBmtHmXLsAXA2j6YHrA37fa4Atz1NAVZVRq/B9b5rtVXNoUEiNwza
         c3MxmLzSaLUrLiDqCmBW8O5nTDLEwdwU6f33Uxek2q2klSkbFon9zZIKjfdWw1CAYjtZ
         hftVFe7cw5XlUQYNHfJNkGy14XE7D0JPZwKSwcgVNC/Rt3uYysxBO/wlcXXyAUBFzBhm
         ZgBQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--047d7bd76bb25fe5f104e98d5dd7
Content-Type: text/plain; charset=UTF-8

Hi Everybody,

I've recently enabled the crypt module in my dracut config and I found
no text label was displayed when asking for the passphrase. This is
because the plymouth initrd population script doesn't include the
label.so plugin alongside with its deps (pango, fontconfig, etc.), and
a font file. Likely this is because this is going to increase the size
of the rd quite a bit for something not used in most common setups.

That said it would be nice to be able to opt-in for this feature, so
I've tried to put a dracut plugin together, with some help by the
folks in #dracut IRC channel and some fix from Harald. The result is
attached.

The font can be configured with a setting in dracut.conf, or at least
this is the idea, I have to test if works. I'm just guessing that
variables defined in dracut.conf are available in this "scope". Is
this correct?

I cannot think a way of doing it more automagically. Distribution
seems to have fun packaging fonts in different and fancy way.

I think it would be nice to include this in dracut, keeping it
disabled by default. Any though or change request?

Kind regards,
Enrico Tagliavini

--047d7bd76bb25fe5f104e98d5dd7
Content-Type: plain/text; name="51plymouth-label.diff"
Content-Disposition: attachment; filename="51plymouth-label.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hn77v1t30

ZGlmZiAtLWdpdCBhL21vZHVsZXMuZC81MXBseW1vdXRoLWxhYmVsL21vZHVsZS1zZXR1cC5zaCBi
L21vZHVsZXMuZC81MXBseW1vdXRoLWxhYmVsL21vZHVsZS1zZXR1cC5zaApuZXcgZmlsZSBtb2Rl
IDEwMDc1NQppbmRleCAwMDAwMDAwLi40YmFkM2M3Ci0tLSAvZGV2L251bGwKKysrIGIvbW9kdWxl
cy5kLzUxcGx5bW91dGgtbGFiZWwvbW9kdWxlLXNldHVwLnNoCkBAIC0wLDAgKzEsMzggQEAKKyMh
L2Jpbi9iYXNoCisjIC0qLSBtb2RlOiBzaGVsbC1zY3JpcHQ7IGluZGVudC10YWJzLW1vZGU6IG5p
bDsgc2gtYmFzaWMtb2Zmc2V0OiA0OyAtKi0KKyMgZXg6IHRzPTggc3c9NCBzdHM9NCBldCBmaWxl
dHlwZT1zaAorCitjaGVjaygpIHsKKwlyZXR1cm4gMjU1Cit9CisKK2RlcGVuZHMoKSB7CisJZWNo
byBwbHltb3V0aAorfQorCitpbnN0YWxsKCkgeworCSMgaGFyZGNvZGVkIGRlZmF1bHQgaWYgbm90
aGluZyBpcyBmb3VuZCBpbiBkcmFjdXQuY29uZgorCWxvY2FsIGRlZmZvbnQ9L3Vzci9zaGFyZS9m
b250cy9saWJlcmF0aW9uKi97ZW5jb2RpbmdzLmRpcixmb250cy4qLExpYmVyYXRpb25TYW5zLVJl
Z3VsYXIudHRmfQorCWxvY2FsIGRlZmZvbnRjb25mPS9ldGMvZm9udHMvY29uZi5kLyotbGliZXJh
dGlvbiouY29uZgorCisJbG9jYWwgZm9udD0kZGVmZm9udAorCWxvY2FsIGZvbnRjb25mPSRkZWZm
b250Y29uZgorCisJIyBjb25maWdzIGZyb20gZHJhY3V0LmNvbmYuIEJvdGggbXVzdCBleGlzdC4K
KwkjIGEgZm9udCB3aXRob3V0IGl0cyBjb25maWcgaXMgbm90IHZlcnkgdXNlZnVsCisJaWYgW1sg
LW4gJFBMWU1PVVRIX0ZPTlQgJiYgLW4gJFBMWU1PVVRIX0ZPTlRDT05GIF1dIDsgdGhlbgorCQlm
b250PSRQTFlNT1VUSF9GT05UCisJCWZvbnRjb25mPSRQTFlNT1VUSF9GT05UQ09ORgorCWZpCisK
KwlpbnN0X2xpYmRpcl9maWxlIHBseW1vdXRoL2xhYmVsLnNvCisKKwlpbnN0X211bHRpcGxlIFwK
KwkJL2V0Yy9mb250cy9mb250cy5jb25mIFwKKwkJJGZvbnQgXAorCQkkZm9udGNvbmYKKworCWlu
c3RfbGliZGlyX2ZpbGUgcGFuZ28vKiBwYW5nby8qLyogcGFuZ28vKi8qLyoKKworCWluc3RfbXVs
dGlwbGUgLW8gL2V0Yy9wYW5nby8qIC9ldGMvcGFuZ28vKi8qCit9Cg==
--047d7bd76bb25fe5f104e98d5dd7--
