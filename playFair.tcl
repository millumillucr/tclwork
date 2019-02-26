proc getKeyList {key} {
	set l ""
	for {set i 65} {$i<91} {incr i} {
		set c [format %c $i]
		if {[string first $c $key]!=-1} {
			append l $c
		}
	}
	for {set i 0} {$i} {} {#Search and only add unique letters in order of their occurence in the key
	}
}

proc getAlphaList {key} {
}

puts "Enter the key:"
gets stdin key

puts "Enter the plain text:"
gets stdin pt
