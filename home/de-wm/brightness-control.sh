    
#!/usr/bin/env bash

# --- CONFIGURATION ---
# Используем серийный номер монитора
MONITOR_SN="6730510018156"
STEP=5
STATE_FILE="/tmp/waybar_brightness_${MONITOR_SN}.tmp"
# ---------------------

# Функция для установки яркости в фоне
# Мы убиваем старые процессы ddcutil для этого монитора, чтобы не спамить шину
set_brightness_in_background() {
    # Убиваем только процессы, касающиеся нашего монитора
    pkill -f "ddcutil.*setvcp 10.*${MONITOR_SN}"
    
    # Запускаем установку значения
    (ddcutil setvcp 10 "$1" --sn "$MONITOR_SN") &
}

# Функция получения текущей яркости с монитора (если файл пуст)
get_monitor_brightness() {
    ddcutil getvcp 10 --sn "$MONITOR_SN" | grep -oP 'current value = \s*\K\d+'
}

# Инициализация файла состояния
if [ ! -f "$STATE_FILE" ]; then
    initial_brightness=$(get_monitor_brightness)
    # Если не удалось получить (ddcutil занят), берем 50 по умолчанию
    echo "${initial_brightness:-50}" > "$STATE_FILE"
fi

current=$(cat "$STATE_FILE")

# Проверка, чтобы current было числом (защита от ошибок)
if ! [[ "$current" =~ ^[0-9]+$ ]]; then
    current=50
fi

case "$1" in
    "get")
        echo "$current"
        ;;
    "up")
        new_brightness=$((current + STEP > 100 ? 100 : current + STEP))
        if [ "$current" -ne "$new_brightness" ]; then
            echo "$new_brightness" > "$STATE_FILE"
            set_brightness_in_background "$new_brightness"
        fi
        # Обновляем модуль waybar (убедись, что signal совпадает в конфиге waybar)
        pkill -RTMIN+8 waybar
        ;;
    "down")
        new_brightness=$((current - STEP < 0 ? 0 : current - STEP))
        if [ "$current" -ne "$new_brightness" ]; then
            echo "$new_brightness" > "$STATE_FILE"
            set_brightness_in_background "$new_brightness"
        fi
        pkill -RTMIN+8 waybar
        ;;
    "right_click")
        new_brightness=0
        if [ "$current" -ne "$new_brightness" ]; then
            echo "$new_brightness" > "$STATE_FILE"
            set_brightness_in_background "$new_brightness"
        fi
        pkill -RTMIN+8 waybar
        ;;
    "left_click")
        new_brightness=100
        if [ "$current" -ne "$new_brightness" ]; then
            echo "$new_brightness" > "$STATE_FILE"
            set_brightness_in_background "$new_brightness"
        fi
        pkill -RTMIN+8 waybar
        ;;
esac