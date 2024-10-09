#!/bin/bash
export DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/${UID}/bus}"

batteryStats=( $( upower -i $(upower -e | grep 'BAT') | grep -E "percentage|state" | sed -E 's/ *\w*: *//g' ) )
batteryCharge=${batteryStats[1]%"%"}

# Проверяем существование файла-переменной
if [ ! -f "/tmp/prev_discharge_state" ]; then
    echo 0 > /tmp/prev_discharge_state
fi

# Загрузка переменной из файла
dischargeState=`cat /tmp/prev_discharge_state`

if [[ ${batteryStats[0]} =~ 'discharging' ]]; then
    # Батарея разряжается
    if   (( $batteryCharge <= 5  && $dischargeState < 3 )); then
        dischargeState=3
        notify-send "Критически низкий уровень заряда: $batteryCharge%"
    elif (( $batteryCharge <= 10 && $dischargeState < 2 )); then
        dischargeState=2
        notify-send "Низкий уровень заряда: $batteryCharge%"
    elif (( $batteryCharge <= 15 && $dischargeState < 1 )); then
        dischargeState=1
        notify-send "Малый уровень заряда: $batteryCharge%"
    fi
else
    # если заряжается - обнуляем счетчик
    dischargeState=0
fi 

echo $dischargeState > /tmp/prev_discharge_state

# notify-send "Параметры: $batteryCharge%, $dischargeState, ${batteryStats[0]}"
