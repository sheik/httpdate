# httpdate
## Get httpdate
Get a .rpm, .deb, or .tar from the releases page.

## Usage
Set system time via HTTP headers. This allows you to keep the linux system date up-to-date using a standard port commonly not blocked by a firewall in data centers (port 80 or port 443). 

    Usage of httpdate:
      -host string
        	server to retreive date from
      -proto string
        	protocol to use (http or https) (default "https")
      -q	disable output to STDOUT and STDERR
      
## Examples
Usage is simple, just run like so:

    [jaigner@tea ~]$ sudo httpdate -host google.com
    date updated successfully
    
If you need to use HTTP instead of HTTPS, you use the -proto option:

    [jaigner@tea ~]$ sudo httpdate -host google.com -proto http
    date updated successfully

It can be added as a cronjob to keep system in-sync.

    0 0,12 * * * root /usr/bin/httpdate -host google.com -q

The command *must be run as root* in order to properly update the system time.

## Build Requirements
To build and package you need to have Golang and fpm installed. 
