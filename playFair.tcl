puts "Enter the key:"
gets stdin key

puts "Enter the plain text:"
gets stdin pt

set ptIndex 0
set keyInserted "false"

set i1 0
set j1 0

for {set i 0} {$i<5 && $keyInserted=="false"} {incr i} {
	for {set j 0} {$j<5} {incr j} {
		global kMAT($i)($j) [string index $key $ptIndex]
		incr ptIndex
		if {$ptIndex >= [string length $key]} {
			set keyInserted "true"
			set i1 $i
			set j1 $j
			break
		}
	}
}

set ASCII 65

for {set i $i1} {$i<5} {incr i} {
	for {set j $j1} {$j<5} {incr j} {
		while {$ASCII<91} {
			set c [scan $ASCII %c]
				if {[string first $c $key]==-1} {
					set ::kMAT($i)($j) $c			
					break
				}
			incr ASCII
		}
	}
}

for {set i 0} {$i<5} {incr i} {
	for {set j 0} {$j<5} {incr j} {
		puts -nonewline "::kMAT($i)($j) \t"
	}
	puts ""
}
