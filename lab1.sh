#!/bin/bash

echo -e
echo "Новиков Владислав гр. 726"
echo "Данный скрипт:"
echo "- Запрашивает путь к каталогу"
echo "- Запрашивает размер файла"
echo "- Находит все файлы больше заданного размера и удаляет их"
echo -e

echo -n "Введите путь: "
read a
while [ ! -d "$a" ]
do
echo "Каталог не найден. Хотите попробовать ещё раз? (y/n)"
read yn
case "$yn" in
    y|Y) echo -n "Введите путь ещё раз: "
    read a
    ;;
    n|N) exit 1
    ;;
esac
done
cd $a
echo -n "Текущий каталог: "
pwd

echo -e

echo -n "Введите файл, размер которого вы хотите узнать: "
read FILENAME
while [ ! -f "$FILENAME" ]
do
echo "Файл не найден. Хотите попробовать ещё раз? (y/n)"
read yn
case "$yn" in
    y|Y) echo -n "ведите файл, размер которого вы хотите узнать ещё раз: "
    read FILENAME
    ;;
    n|N) exit 1
    ;;
esac
done
FILESIZE=$(stat -c%s "$FILENAME")
echo "Size of $FILENAME = $FILESIZE bytes."

echo -e

echo "Показать файлы размером больше 1M? (y/n)"
read yn
case "$yn" in
    y|Y) find -size +1M
    ;;
    n|N) echo "Завершение программы? (y/n)"
        read yn
        case "$yn" in
            y|Y) exit 1
            ;;
            n|N) exit 1
        esac
    ;;
esac
echo "Удалить эти файлы? (y/n)"
read yn
case "$yn" in
    y|Y) find -size +1M -delete
    echo "Файлы в директории:" 
    ls
    ;;
    n|N) echo "Завершить программу? (y/n)"
    read yn
    case "$yn" in
        y|Y) exit 1
        ;;
        n|N) exit 1
        ;;
    esac
    ;;
esac


