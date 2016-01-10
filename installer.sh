 #!/bin/bash
#
#   $$SHNAME$$ Version 2.00.0
#   $$DATE$$
#
#   Bod Installation Script: Bodhi 2.0 i686
#
#   Bodhi Linux (c) 2012
#   Authors : rbt y-lee, Jeff Hoogland
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

BOD_NAME="b43xxinstaller"
APP_NAME="bcmwl-kernel-soource"
APP_DESC="Offline installation of wifi module for b43xx wifi chipsets"


echo -e "\nBodhi Application Installer\n      ${BOD_NAME^}: $APP_DESC\n"

ARCH=`cat /proc/cpuinfo | grep ARM`

if [ -n "$ARCH" ]; then
  echo "FATAL ERROR: ARM Processor detected."

  zenity --window-icon=/usr/share/icons/bodhi.png --error --title "FATAL ERROR" --text "This bod file does not support\nthe cpu architecure detected.\n\nPlease Download the appropriate\nbod file for your machine." 2>/dev/null
  echo "aborting installation ..."
  exit 1
fi

CPU_B=`/bin/uname -m | grep i686`
if [ -z "$CPU_B" ]; then
  echo "FATAL ERROR: Cpu not supported"
  zenity --window-icon=/usr/share/icons/bodhi.png --error --title "FATAL ERROR" --text "This bod file only supports 32 bit Bodhi." 2>/dev/null
  echo "aborting installation ..."
  exit 1
fi

zenity --window-icon=/usr/share/icons/bodhi.png --question --title="Bodhi Application Installer" --text="Would you like to install ${BOD_NAME^}: $APP_DESC?" 2>/dev/null

if [ $? == 1 ]; then
    zenity --window-icon=/usr/share/icons/bodhi.png --info --title="Bodhi Application Installer" --text="${BOD_NAME^}: $APP_DESC was <i>not</i> installed. Thanks for using Bodhi!" 2>/dev/null
    echo -e "${BOD_NAME^} installation aborted.\n"
    exit 1
fi

zenity --window-icon=/usr/share/icons/bodhi.png --info --title="Bodhi Application Installer" --text="Click <b>OK</b> and enter your password to install $BOD_NAME" 2>/dev/null

DO="./bodapt.sh $@"
zenity --entry --title="Sudo Password" --text="Enter your password to perform administrative tasks:" --hide-text | sudo -S sudo $DO
exit $?

# All Wrongs Reserved.
