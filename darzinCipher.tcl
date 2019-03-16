set pt "ABCEDF"
set pt [string toupper $pt]
set key 123

set klen [string length $key]
for {set i 0} {$i<[string length $pt]} {incr i 3} {
    for {set j 0} {$j<$klen} {incr j} {
        append l($i) [string index $pt [expr $j+$i]]
    }
    puts "Test 1: $l($i) $i"
}

for {set i 0} {$i<[string length $key]} {incr i} {
    set kl($i) [expr [string index $key $i]]
}

for {set i 0} {$i<=[array size l]+1} {incr i 3} {
    for {set j 0} {$j<[string length $l($i)]} {incr j} {
        set ln [scan [string index $l($i) $j] %c]
        puts -nonewline [format %c [expr [expr [expr [expr $ln+$kl($j)]-65]%26]+65]]
    }
}
