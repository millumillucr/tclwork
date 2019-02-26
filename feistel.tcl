proc btod {n} {
	set l [string length $n]
	set dec 0
	for {set i 0} {$i<$n} {incr i} {
		scan [string index $n $i] %d x
		set dec [expr $dec+[expr $x**$i]]
	}
	return $dec
}

proc round {n k} {
	binary scan $n b4 w
	set w [string reverse $w]
	puts $w
	for {set i 0} {$i<2} {incr i} {
		append l [string index $w $i]
		append r [string index $w $i+2]
	}
	
	puts "Left: $l Right: $r"
	
	binary scan $k b2 key
	set key [string reverse $key]

	binary format $l b4 rd
	puts $rd
}

puts [btod "10000"]
