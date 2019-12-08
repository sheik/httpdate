package main

import (
	"flag"
	"fmt"
	"net/http"
	"os"
	"os/exec"
	"time"
)

var (
	host   = flag.String("host", "", "server to retreive date from")
	proto  = flag.String("proto", "https", "protocol to use (http or https)")
	quiet  = flag.Bool("q", false, "disable output to STDOUT and STDERR")
	layout = "Mon, 02 Jan 2006 15:04:05 MST"
)

func main() {
	flag.Parse()

	if *host == "" {
		fmt.Fprintf(os.Stderr, "-host must be specified\n")
		os.Exit(1)
	}

	err := SetSystemTime(*host, *proto)
	if err != nil {
		if !*quiet {
			fmt.Fprintf(os.Stderr, "%s\n", err)
		}
		os.Exit(1)
	}
	if !*quiet {
		fmt.Println("date updated successfully")
	}
	os.Exit(0)
}

func SetSystemTime(host, protocol string) error {
	// check protocol
	if protocol != "http" && protocol != "https" {
		return fmt.Errorf("invalid protocol, must be http or https")
	}

	// execute HEAD requeust on server
	client := &http.Client{}
	resp, err := client.Head(fmt.Sprintf("%s://%s", protocol, host))

	if err != nil {
		return fmt.Errorf("could not execute HEAD request")
	}

	// check for time in HTTP header
	date, ok := resp.Header["Date"]

	if !ok || len(date) == 0 {
		return fmt.Errorf("could not find date in HTTP header")
	}

	// parse time
	t, err := time.Parse(layout, date[0])

	if err != nil {
		return fmt.Errorf("could not parse date found in HTTP header: %s", err)
	}

	// set system time
	cmd := exec.Command("date", "-s", fmt.Sprintf("@%d", t.Unix()))
	err = cmd.Run()
	if err != nil {
		return fmt.Errorf("error running date set command (must be run as root)")
	}

	return nil
}
