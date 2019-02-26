namespace import ::tcl::mathfunc::*

puts "Enter a number:"
gets stdin n

set p 0

set temp $n

while {$temp%10!=0} {
	set temp [expr $temp/10]
	incr p
}

set temp $n
set sum 0
while {$temp%10!=0} {
	set d [expr $temp%10]
	set sum [expr $sum+[pow $d $p]]
	set temp [expr $temp/10]
}

if {$sum==$n} {
	puts "Armstrong Number!"
} else {
	puts "Not a Armstrong Number!"
}
