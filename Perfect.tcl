puts "Enter a number:"
gets stdin n

set sum 0

for {set i 1} {$i<$n} {incr i} {
	if {$n%$i==0} {
		set sum [expr $sum+$i]
	}
}

if {$sum==$n} {
	puts "Perfect Number!"
} else {
	puts "Not a Perfect Number!"
}
