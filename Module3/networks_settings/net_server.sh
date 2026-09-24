#!/bin/bash


X=$1

if test -z $X
then
        echo -n "enter X: "
        read X
fi

if ! test "$X" -eq "$X" 2> /dev/null
then
  echo Pozovite prepodavatelia
  exit 1
fi

pkill dhcpcd

cat > /etc/hosts <<EOF
127.0.0.1               localhost

192.168.$X.10 server.corp$X.un server

# 172.16.1.254           proxy
# 172.16.1.254           rep
EOF

cat > /etc/resolv.conf <<EOF
search corp$X.un
nameserver 172.16.1.254
#nameserver 192.168.$X.10
EOF

echo gate.corp$X.un > /etc/hostname
# для ubuntu, для systemd
hostnamectl set-hostname server.corp$X.un

# Переменные для настройки
INTERFACE_LAN="enp0s3"
# INTERFACE_WAN="enp0s8"
IP_ADDR="192.168.$X.10"
PREFIX="24"
GATEWAY="192.168.$X.1"
DNS1="192.168.$X.10"
DNS2="8.8.8.8"
CONFIG_FILE="/etc/netplan/99-custom-static-config.yaml"

# Генерация YAML конфига
cat <<EOF > $CONFIG_FILE
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE_LAN:
      dhcp4: false
      addresses:
        - $IP_ADDR/$PREFIX
      routes:
        - to: default
          via: $GATEWAY
      nameservers:
        addresses:
          - 8.8.8.8
EOF

# У сервера всё тоже самое, только без второго интерфейса


# Установка правильных прав доступа к файлу
chmod 600 $CONFIG_FILE

echo "Конфигурация создана в $CONFIG_FILE"

# Проверка синтаксиса
echo "Проверка конфигурации Netplan..."
netplan generate

if [ $? -eq 0 ]; then
	echo "Синтаксис корректен. Применяю настройки..."
	# Apply settings
	netplan apply
	echo "Настройки успешно применены"
else
	echo "Ошибка в синтаксисе конфигурации. Проверьте YAML файл."
	exit 1
fi

timedatectl set-timezone Europe/Moscow

echo Success
exit 0

