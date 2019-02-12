proc encrypt {p k} {
	for {set i 0} {$i<[string length $p]} {incr i} {
		set char [string index $p $i]
		set value [scan $char %c]
		if {$value>64 && $value<97} {
			set value [expr [expr [expr [expr $value-65]+$k]%26]+65]
		} elseif {$value>96 && $value<123} {
			set value [expr [expr [expr [expr $value-97]+$k]%26]+97]
		}
		puts -nonewline "[format %c $value]"
	}
}

proc decrypt {p k} {
	for {set i 0} {$i<[string length $p]} {incr i} {
		set char [string index $p $i]
		set value [scan $char %c]
		if {$value>64 && $value<97} {
			set value [expr [expr [expr [expr $value-65]-$k]%26]+65]
		} elseif {$value>96 && $value<123} {
			set value [expr [expr [expr [expr $value-97]-$k]%26]+97]
		}
		puts -nonewline "[format %c $value]"
	}
}

puts "Enter the plain text and key:"
gets stdin p
gets stdin k
puts [encrypt $p $k]
puts "Enter the cipher text and key:"
gets stdin p
gets stdin k
puts [decrypt $p $k]
