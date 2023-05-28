#!/bin/bash

# read the disk status
get_disk_used() { 
    used=$(df -h | head -n -7 | tail -n -1 | awk '{ print $3 }');
    echo $used;
}

get_disk_avail() { 
    avail=$(df -h | head -n -7 | tail -n -1 | awk '{ print $4 }');
    echo $avail;
}

get_disk_percent() { 
    percent=$(df -h | head -n -7 | tail -n -1 | awk '{ print $5 }');
    echo $percent;
}

print_disk_status() {
    echo "💾 $(get_disk_used):$(get_disk_avail) $(get_disk_percent)";
}

# read the mem status
get_mem_used() {
    used=$(free -m | tail -n -2 | head -n -1 | awk '{ print $3 }');
    echo $used;
}

get_mem_avail() {
    avail=$(free -m | tail -n -2 | head -n -1 | awk '{ print $7 }');
    echo $avail;
}

get_mem_percent() {
    used=$(free -m | tail -n -2 | head -n -1 | awk '{ print $3 }');
    total=$(free -m | tail -n -2 | head -n -1 | awk '{ print $2 }');
    percent=$(bc -l <<< "$used/$total*100");
    percent=${percent%%.*}
    echo $percent;
}

print_mem_status() {
    echo "💿 $(get_mem_used):$(get_mem_avail) $(get_mem_percent)%";
}

# read the battery level and status
get_battery_charging_status() {
	if $(acpi -b | grep --quiet Discharging)
	then
		echo "🔋";
	else # acpi can give Unknown or Charging if charging, https://unix.stackexchange.com/questions/203741/lenovo-t440s-battery-status-unknown-but-charging
		echo "🔌";
	fi
}

get_battery_percent() {
    percent=$(acpi | cut -d, -f2 | cut -d% -f1 | cut -d" " -f2);
    echo $percent;
}

print_battery_status() {
    echo "$(get_battery_charging_status) $(get_battery_percent)%";
}

# date and time
print_date_time() {
    date '+%Y/%m/%d %H:%M';    
}

xsetroot -name "[$(print_mem_status)] [$(print_disk_status)] [$(print_battery_status)] $(print_date_time) "
