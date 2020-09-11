# Control services with short commands.

sstatus() { sudo service "$1" status; }
sstart() { sudo service "$1" start; }
srestart() { sudo service "$1" restart; }
sstop() { sudo service "$1" stop; }
