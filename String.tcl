set s1 "Network Programming"
set s2 "Grammatical Inference"

puts "String 1: $s1"
puts "String 2: $s2"

puts "Length of String 1 is: [string length $s1]"
puts "Length of String 2 is: [string length $s2]"

puts "Characters at even indices of the String 1:"
for {set i 0} {$i<[string length $s1]} {incr i 2} {
	puts "[string index $s1 $i]"
}

puts "Characters at even indices of the String 2:"
for {set i 0} {$i<[string length $s2]} {incr i 2} {
	puts "[string index $s2 $i]"
}

set s1 [string tolower $s1]
set s2 [string toupper $s2]
append s1 $s2

puts $s1
