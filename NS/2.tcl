#AIM: Simulate a four node point to point network with the links connected as follows: n0-n2. n1-n2 and n2-n3. Apply TCP agent between n0-n3 and UDP agent between n1-n3. Apply relevant applications over TCP and UDP agents changing the parameter and determine the number of packets sent by TCP/UDP.

set ns [new Simulator]
set nf [open lab2.nam w]
$ns namtrace-all $nf
set tf [open lab2.tr w]
$ns trace-all $tf

proc finish {} {
	global ns nf tf
	$ns flush-trace
	close $nf
	close $tf
	exec nam lab2.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 10Mb 1ms DropTail
$ns duplex-link $n1 $n2 10Mb 1ms DropTail
$ns duplex-link $n2 $n3 10Mb 1ms DropTail

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
set null [new Agent/Null]
$ns attach-agent $n3 $null

set ftp [new Application/FTP]
$ftp attach-agent $tcp
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

$ns connect $tcp $sink
$ns connect $udp $null

$ns at 0.1 "$cbr start"
$ns at 0.2 "$ftp start"
$ns at 0.5 "finish"

$ns run
