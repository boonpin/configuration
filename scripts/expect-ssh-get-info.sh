#!/usr/bin/expect -f

## Script for ssh and get the `ps` and `free` info from device
## below the sample of device from IP 192.168.1.199, username/password as admin/admin

set now [clock seconds]
set date [clock format $now -format {%Y%m%d}]

set dir "./device-192-168-1-199/${date}"

spawn mkdir -p ${dir}

spawn ssh admin@192.168.1.99

set timeout 30
expect "password:"
send "admin\n"

expect ":~#"
send "ps w > /tmp/top.out\n"

expect ":~#"
send "free > /tmp/free.out\n"

send "ls /tmp/\n"
expect ":~#"

send "exit\n"

spawn bash -c "scp admin@192.168.1.99:'/tmp/free.out /tmp/ps.out' ${dir}/"

expect "password:"
send "admin\n"

expect "~]$"
