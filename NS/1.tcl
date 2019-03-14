set ns [new Simulator]

set nf [open simu.nam w]
$ns namtrace-all $nf

set nt [open simu.tr w]
$ns trace-all $nt

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 5Mb 2ms DropTail
$ns duplex-link $n1 $n2 10Mb 5ms DropTail
$ns duplex-link $n1 $n4 3Mb 10ms DropTail
$ns duplex-link $n4 $n3 100Mb 2ms DropTail
$ns duplex-link $n4 $n5 4Mb 10ms DropTail

set udp [new Agent/UDP]
set null [new Agent/Null]
$ns attach-agent $n0 $udp
$ns attach-agent $n3 $null
$ns connect $udp $null

set tcp [new Agent/TCP]
$ns attach-agent $n2 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink
$ns connect $tcp $sink

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 0.0 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 10.0 "finish"

proc finish {} {
	global ns nt nf
        $ns flush-trace
        close $nf
	close $nt
	exec nam simu.nam
        exit 0
}

$ns run
