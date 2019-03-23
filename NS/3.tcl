#AIM: Simulate the transmission of ping messages over a network over a network topology consisting of 6 nodes and find the number of packets dropped due to congestion.

set ns [new Simulator]

set nf [open lab4.nam w]
$ns namtrace-all $nf

set tf [open lab4.tr w]
$ns trace-all $tf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n4 1005Mb 1ms DropTail
$ns duplex-link $n1 $n4 50Mb 1ms DropTail
$ns duplex-link $n2 $n4 2000Mb 1ms DropTail
$ns duplex-link $n3 $n4 200Mb 1ms DropTail
$ns duplex-link $n4 $n5 1Mb 1ms DropTail

set p1 [new Agent/Ping]
$ns attach-agent  $n0 $p1
$p1 set packetSize_ 50000
$p1 set interval_ 0.0001

set p2 [new Agent/Ping]
$ns attach-agent  $n1 $p2

set p3 [new Agent/Ping]
$ns attach-agent  $n2 $p3
$p1 set packetSize_ 30000
$p1 set interval_ 0.00001

set p4 [new Agent/Ping]
$ns attach-agent  $n3 $p4

set p5 [new Agent/Ping]
$ns attach-agent  $n5 $p5

$ns queue-limit $n0 $n4 5
$ns queue-limit $n2 $n4 3
$ns queue-limit $n4 $n5 2

Agent/Ping instproc recv {from rtt} {
	$self instvar node_
	puts "node [$node_ id] received answer from $from with round trip time $rtt ms"
}

$ns connect $p1 $p5
$ns connect $p3 $p4

proc finish {} {
	global ns nf tf
	$ns flush-trace
	close $nf
	close $tf
	exec nam lab4.nam &
	exit 0
}

for {set i 0.1} {$i<3.0} {set i [expr $i+0.1]} {
	$ns at $i "$p1 send"
}
for {set i 0.1} {$i<3.0} {set i [expr $i+0.1]} {
	$ns at $i "$p3 send"
}
$ns at 3.0 "finish"
$ns run
