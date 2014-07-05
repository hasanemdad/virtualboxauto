virtualboxauto 1.0
===================

This is a Bash program written to auto installaiton of Virtualbox 4.3.x with PHPVirtualbox

The script works on a fresh installation of Debian 7.x 64 Bit Operating System.

Feature:
  1. Installs on a fresh Debian Wheezy machine
  2. Run as a root user
  3. Installs Virtualbox 4.3 with DKMS kernel
  4. Installs PhpVirtualbox web interface to control web based Virtualbox Administration

How to Install:
  1. login to terminal.
  2. su or login as root, because you need to run the script as root user
  2. copy the installation file to /root directory
  3. use "chmod+x" to virtualboxinstaller.sh
  3. issue command "./virtualboxinstaller.sh"
  4. Auto installaiton beging
  5. Follow on screen messages and enter different parameters as appears to complete the installtion

Known Issue:
  1. vbox user password is symbol sensitive which means, special characters such as \/@#$% are not supported.
