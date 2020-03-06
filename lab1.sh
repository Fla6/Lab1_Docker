#!/bin/bash

echo -e
echo "Новиков Владислав гр. 726"
echo "Данный скрипт:"
echo "- Запрашивает путь к каталогу"
echo "- Запрашивает размер файла"
echo "- Находит все файлы больше заданного размера и удаляет их"
echo -e

Find_directory () {
    echo -n "Введите путь: "
    read a
    if test -d "$a"
    then
        cd $a
        echo -n "Текущий каталог: "
        pwd
    else 
        >&2 echo -n "Каталога не найден. ";
        echo "Попробовать снова? (y/n)"
        read yn
        case "$yn" in
            y|Y) continue
            ;;
            n|N) exit
            ;;
        esac
    fi
}

File_size () {
    echo -n "Введите файл, размер которого вы хотите узнать: "
    read FILENAME
    if test -f "$FILENAME"
    then
        FILESIZE=$(stat -c%s "$FILENAME")
        echo "Size of $FILENAME = $FILESIZE bytes."
    else
        >&2 echo -n "Файл не найден. ";
        echo "Попробовать снова? (y/n)"
        read yn
        case "$yn" in
            y|Y) return 55
            ;;
            n|N) exit
            ;;
        esac
    fi
}

Find_size () {
    echo -n "Укажите файлы, размер которго хотите узнать: "
    read a
    find -size +"$a"M
    echo "Хотите продолжить или выбрать другую директорию? (1/2)"
    read yn
    case "$yn" in
        1) Delete_file
        ;;
        2) Find_directory
        ;;
    esac
}

Delete_file () {
    echo "Удалить эти файлы? (y/n)"
    read yn
    case "$yn" in
        y|Y) find -size +1M -delete
            echo "Файлы в директории:" 
            ls
            echo "Завершить программу? (y/n)"
            read yn
            case "$yn" in
                y|Y) exit
                ;;
                n|N) continue
                ;;
            esac
        ;;
        n|N) echo "Завершить программу? (y/n)"
        read yn
        case "$yn" in
            y|Y) exit
            ;;
            n|N) continue
            ;;
        esac
        ;;
    esac
}

while [ "1" -eq "1" ]
do
    Find_directory

    File_size

    while [ "$?" -eq 55 ]
    do
        File_size
    done
    
    Find_size

    Delete_file
done


