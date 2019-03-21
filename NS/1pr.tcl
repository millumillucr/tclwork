#Aim: Simluate a three node point to point network with duplex links between them. Set queue size and vary the bandwidth and find number of packets dropped.
set ns [new Simulator]
set nf [open P1.nam w]
$ns namtrace-all $nf
set tf [open P1.tr w]
$ns trace-all $tf

proc finish { } {
	global ns nf tf
	$ns flush-trace
	close $nf
	close $tf
	exec nam P1.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 200Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 1000ms DropTail
$ns queue-limit $n0 $n1 10

set udp [new Agent/UDP]
$ns attach-agent $n0 $udp
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 500
$cbr set interval_ 0.005
$cbr attach-agent $udp

set null [new Agent/Null]
$ns attach-agent $n2 $null
$ns connect $udp $null

$ns at 0.1 "$cbr start"
$ns at 1.0 "finish"
$ns run

