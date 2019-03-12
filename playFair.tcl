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
set key [string toupper $key]
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
puts "Enter the plain text:"
gets stdin pt
set pt [string toupper $pt]
set cipher ""
set noDup 0
while {$noDup!=1} {
	for {set i 0} {$i<[expr [string length $pt]-1]} {incr i 2} {

		set f [string index $pt $i]
		set s [string index $pt [expr $i+1]]
		if {$f==$s} {
			set fh [string range $pt 0 $i]
			append fh "X"
			set sh [string range $pt [expr $i+1] [string length $pt]]
			append fh $sh
			set pt $fh
			break;
		}
		if {[expr $i+2]==[expr [string length $pt]-1]} {
			set noDup 1
		}
		if {[expr $i+2]==[string length $pt]} {
			set noDup 1
		}
	}
}

if {[expr [string length $pt]%2]!=0} {
	append pt "Z"
}
puts "Plain Text(Parsed): $pt"

for {set i 0} {$i<[string length $pt]} {incr i} {
	
}

for {set i 0} {$i<[string length $pt]} {incr i 2} {
	set f [string index $pt $i]
	set s [string index $pt $i+1]
	set T(x) -1
	set T(y) -2
	set O(x) -3
	set O(y) -4

	if {[string compare $f "J"]==0} {
		set f "I"
	}
	if {[string compare $s "J"]==0} {
		set s "I"
	}	
	
	for {set x 0} {$x<5} {incr x} {
		for {set y 0} {$y<5} {incr y} {
			if {[string compare $kMAT($x,$y) $f]==0} {
				set O(x) $x
				set O(y) $y
				break
			}
		}
	}
	for {set x 0} {$x<5} {incr x} {
		for {set y 0} {$y<5} {incr y} {
			if {[string compare $kMAT($x,$y) $s]==0} {
				set T(x) $x
				set T(y) $y
				break
			}
		}
	}
	if {$T(x)==$O(x)} {
		append cipher $kMAT($O(x),[expr [expr $O(y)+1]%5])
		append cipher $kMAT($T(x),[expr [expr $T(y)+1]%5])
	} elseif {$T(y)==$O(y)} {
		append cipher $kMAT([expr [expr $O(x)+1]%5],$O(y))
		append cipher $kMAT([expr [expr $T(x)+1]%5],$T(y))
	} else {
		append cipher $kMAT($O(x),$T(y))
		append cipher $kMAT($T(x),$O(y))
	}
}
puts $cipher
