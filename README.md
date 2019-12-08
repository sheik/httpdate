# httpdate
Set system time via HTTP headers. This allows you to keep the linux system date up-to-date using a standard port commonly not blocked by a firewall to data centers (port 80 or port 443). 

    Usage of httpdate:
      -host string
        	server to retreive date from (default "app.aci.avaya.com")
      -proto string
    	    protocol to use (http or https) (default "https")
      -q	disable output to STDOUT and STDERR 
