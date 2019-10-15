#!/usr/bin/env bash

set -euo pipefail

# Copyright (c) 2019 Selfnet e.V. https://www.selfnet.de
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.


IS_MTR_THERE=$(which mtr);
IS_MTR_THERE_RC=$?

if [ "$IS_MTR_THERE_RC" != 0 ]
then
    echo "ERROR!"
    echo "";
    echo "Please install mtr.";
    echo "On Debian and Debian-like distributions the package is called 'mtr-tiny'";
    echo " --> sudo apt install mtr-tiny";
    echo "On Arch Linux the package is called 'mtr'";
    echo " --> sudo pacman -S mtr";
    echo "";
    echo "";
    echo "Please note: If you install the 'mtr' package on Debian/Ubuntu this will give you a GUI interface which will probably not work with this script!";
    echo "";
    exit 1;
fi


function print_and_execute
(
    local COMMAND_STRING=$1;

    echo "--------------------------------";
    echo " --> $COMMAND_STRING";
    eval "$COMMAND_STRING";
    echo "";
)

# vars
## heise.de
heise_v4_literal=$(getent ahostsv4 www.heise.de | head -n 1 | awk -F ' ' '{print $1}');
heise_v6_literal=$(getent ahostsv6 www.heise.de | head -n 1 | awk -F ' ' '{print $1}');
## selfnet.de
selfnet_v4_literal=$(getent ahostsv4 www.selfnet.de | head -n 1 | awk -F ' ' '{print $1}');
selfnet_v6_literal=$(getent ahostsv6 www.selfnet.de | head -n 1 | awk -F ' ' '{print $1}');

# ip addr
echo "===== IP ADDR =====";
print_and_execute "ip -4 addr show";
print_and_execute "ip -6 addr show";

# ip route
echo "===== IP ROUTE =====";
print_and_execute "ip -4 route list";
print_and_execute "ip -6 route list";

print_and_execute "ip -4 route show to match ${heise_v4_literal}";
print_and_execute "ip -6 route show to match ${heise_v6_literal}";

print_and_execute "ip -4 route show to match ${selfnet_v4_literal}";
print_and_execute "ip -6 route show to match ${selfnet_v6_literal}";

# ping
echo "===== PING =====";
print_and_execute "ping -4 -c 1 www.heise.de";
print_and_execute "ping -6 -c 1 www.heise.de";

print_and_execute "ping -4 -c 1 www.selfnet.de";
print_and_execute "ping -6 -c 1 www.selfnet.de";

echo "===== MTR ======";
# traceroute
print_and_execute "mtr -4 -w www.heise.de";
print_and_execute "mtr -6 -w www.heise.de";

print_and_execute "mtr -4 -w www.selfnet.de";
print_and_execute "mtr -6 -w www.selfnet.de";


