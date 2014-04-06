From: Sebastian =?utf-8?q?K=C3=B6ln?= <skoeln-4JCb7EXykGJ5qnkD1ooD3mPhZIeI7moD@public.gmane.org>
Subject: Bug in dracut-functions.sh@225(print_vars)
Date: Sun, 6 Apr 2014 13:38:52 +0200
Message-ID: <201404061338.54350.skoeln@physnet.uni-hamburg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I stubled upon the following bug (dracut --verbose output):

> ...
> //usr/lib/dracut/modules.d/10i18n/module-setup.sh@132(install_local_i18n): 
EXT_KEYMAPS='backspace keypad euro2'
> ...
> /usr/lib/dracut/dracut-functions.sh@224(print_vars): eval printf -v _value 
%s '$EXT_KEYMAPS'
> //usr/lib/dracut/dracut-functions.sh@224(print_vars): printf -v _value %s 
backspace keypad euro2
> /usr/lib/dracut/dracut-functions.sh@225(print_vars): [[ -n 
backspacekeypadeuro2 ]]
> /usr/lib/dracut/dracut-functions.sh@225(print_vars): printf '%s=\"%s\"\n' 
EXT_KEYMAPS backspacekeypadeuro2

the "eval" line of print_vars
needs to re replaced by
> eval printf -v _value "%s" \""\$$_var"\"

the modified function is then:

> # Function prints global variables in format name=value line by line.
> # $@ = list of global variables' name
> print_vars() {
>     local _var _value
> 
>     for _var in "$@"
>     do
>         eval printf -v _value "%s" \""\$$_var"\"
>         [[ ${_value} ]] && printf '%s="%s"\n' "$_var" "$_value"
>     done
> }

this produces the correct result.
