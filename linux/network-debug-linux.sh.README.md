# network-debug-linux.sh

Gathers information about your network settings and connectivity.

## Requirements

* mtr
  * On Debian and Debian-like distributions (like Ubuntu) install the **mtr-tiny** package.
    * Debian/Ubuntu/...: `sudo apt install mtr-tiny`.
  * On probably all other distributions (Arch, CentOS, ...) the package is simply called **mtr**:
    * Arch: `sudo pacman -S mtr`
    * CentOS: `sudo yum install mtr`

## Execution

```bash
chmod u+x ./network-debug-linux.sh
./network-debug-linux.sh > output.txt
```
