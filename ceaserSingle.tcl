proc encrypt {p} {
	set value [scan $p %c]
	if {$value>64 && $value<91} {
			set value [expr [expr [expr [expr $value-65]+3]%26]+65]
	} elseif {$value>96 && $value<123} {
			set value [expr [expr [expr [expr $value-97]+3]%26]+97]
	}
	return [format %c $value]
}
proc decrypt {c} {
	set value [scan $c %c]
	if {$value>64 && $value<91} {
			set value [expr [expr [expr [expr $value-65]-3]%26]+65]
	} elseif {$value>96 && $value<123} {
			set value [expr [expr [expr [expr $value-97]-3]%26]+97]
	}
	return [format %c $value]
}

puts "Enter a character:"
gets stdin p
puts "Cipher: [encrypt $p]"
puts "Decrypted Cipher: [decrypt [encrypt $p]]"
