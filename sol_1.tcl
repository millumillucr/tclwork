puts "Enter the number of students:"
gets stdin n

for {set i 1} {$i<=$n} {incr i} {
	puts "Enter student $i course 1 marks:"
	gets stdin c(1,$i)
	puts "Enter student $i course 2 marks:"
	gets stdin c(2,$i)
	puts "Enter student $i course 3 marks:"
	gets stdin c(3,$i)
	puts "Enter student $i course 4 marks:"
	gets stdin c(4,$i)
	puts "Enter student $i course 5 marks:"
	gets stdin c(5,$i)
}

puts "Enter the course number to get the average:"
gets stdin cn

set csum 0

for {set i 1} {$i<=$n} {incr i} {
	set csum [expr $csum+$c($cn,$i)]
}

puts "Course $cn average is: [expr $csum/$n]"

puts "Average marks for every course:"
for {set cn 1} {$cn<6} {incr cn} {
	set csum 0
	for {set i 1} {$i<=$n} {incr i} {
		set csum [expr $csum+$c($cn,$i)]
	}
	puts "Course $cn average is: [expr $csum/$n]"
}
