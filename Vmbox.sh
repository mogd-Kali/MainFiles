#!/bin/bash

# Проверяем, что скрипт запущен с правами root (необязательно)
if [[ $EUID -ne 0 ]]; then
  echo "Этот скрипт должен быть запущен с правами root."
  exit 1
fi

# Функция для загрузки и выполнения скрипта
run_script() {
  local script_url="$1"
  local script_name=$(basename "$script_url")

  echo "Загрузка скрипта $script_name из $script_url..."
  curl -s "$script_url" -o "$script_name"

  if [ $? -eq 0 ]; then
    echo "Скрипт $script_name успешно загружен."

    # Делаем скрипт исполняемым
    chmod +x "$script_name"

    echo "Запуск скрипта $script_name..."
    ./"$script_name"

    script_result=$? # Запоминаем код возврата

    #Удаляем скаченный скрипт
    rm -f "$script_name"

    if [ $script_result -eq 0 ]; then
      echo "Скрипт $script_name успешно выполнен."
    else
      echo "Ошибка при выполнении скрипта $script_name."
    fi
  else
    echo "Ошибка при загрузке скрипта $script_name."
  fi
}

# Проверяем, является ли первый аргумент "vmboxmbs"
if [ "$1" == "vmboxmbs" ]; then
  # URL скрипта Slim.sh
  slim_script_url="https://raw.githubusercontent.com/mogd-Kali/MainFiles/refs/heads/main/Silm.sh"

  # Запускаем скрипт
  run_script "$slim_script_url"
fi

# Удаляем сам скрипт vmbox.sh
rm -f "$0"

exit 0
