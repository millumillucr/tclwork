puts "Enter your plain text(string):"
gets stdin pt
set pt [string toupper $pt]
puts "Enter your key(int):"
gets stdin key
set klen [string length $key]
for {set i 0} {$i<[string length $pt]} {incr i $klen} {
    for {set j 0} {$j<$klen} {incr j} {
        append l($i) [string index $pt [expr $j+$i]]
    }
}
for {set i 0} {$i<[string length $key]} {incr i} {
    set kl($i) [expr [string index $key $i]]
}
for {set i 0} {$i<[string length $pt]} {incr i $klen} {
    for {set j 0} {$j<[string length $l($i)]} {incr j} {
        set ln [scan [string index $l($i) $j] %c]
        puts -nonewline [format %c [expr [expr [expr [expr $ln+$kl($j)]+65]%26]+65]]
    }
}
