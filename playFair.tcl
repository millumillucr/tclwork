proc getKeyList {key} {
	set l ""
	for {set i 65} {$i<91} {incr i} {
		set c [format %c $i]
		if {[string first $c $key]!=-1} {
			append l $c
		}
	}
	set kl ""
	for {set i 0} {$i<[string length $key]} {incr i} {
		if {[string first [string index $key $i] $l]!=-1} {
			set l [string replace $l [string first [string index $key $i] $l] [string first [string index $key $i] $l] "."]
			append kl [string index $key $i]
		}
	}
	for {set i 65} {$i<91} {incr i} {
		set c [format %c $i]
		if {[string first $c $kl]==-1} {
			append kl $c
		}
	}
	return $kl
}

puts "Enter the key:"
gets stdin key

set matList [getKeyList $key]

set ind 0

set jChar "J"

for {set i 0} {$i<5} {incr i} {
	for {set j 0} {$j<5} {} {
		if {[string compare [string index $matList $ind] $jChar]!=0} {
			set kMAT($i,$j) [string index $matList $ind]
			incr j
		}
		incr ind
	}
}

for {set i 0} {$i<5} {incr i} {
	for {set j 0} {$j<5} {incr j} {
		puts -nonewline "$kMAT($i,$j)\t"
	}
	puts ""
}

#puts "Enter the plain text:"
#gets stdin pt

set pt "CK"

set cipher ""

for {set i 0} {$i<[string length $pt]} {incr i 2} {
	set f [string index $pt $i]
	set s [string index $pt $i+1]
	set T(x) -1
	set T(y) -2
	set O(x) -3
	set O(y) -4
	for {set x 0} {$x<5} {incr x} {
		for {set y 0} {$y<5} {incr y} {
			if {[string compare $kMAT($x,$y) $f]==0} {
				puts "Text: $f"
				set O(x) $x
				set O(y) $y
				puts "Text1: $O(x) $O(y)"
			}
			if {[string compare $kMAT($x,$y) $s]==0} {
				puts "Text: $s"
				set T(x) $x
				set T(y) $y
				puts "Text2: $T(x) $T(y)"
			}
		}
		if {$T(x)==$O(x)} {
			append cipher $kMAT($O(x),[expr [expr $O(y)+1]%5])
			append cipher $kMAT($T(x),[expr [expr $T(y)+1]%5])
		}
		if {$T(y)==$O(y)} {
			append cipher $kMAT([expr [expr $O(x)+1]%5],$O(y))
			append cipher $kMAT([expr [expr $T(x)+1]%5],$T(y))
		}
	}
}
puts $cipher
