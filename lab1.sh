#!/bin/bash

echo -e
echo "Новиков Владислав гр. 726"
echo "Данный скрипт:"
echo "- Запрашивает путь к каталогу"
echo "- Запрашивает размер файла"
echo "- Находит все файлы больше заданного размера и удаляет их"
echo -e

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
    echo "Показать файлы размером больше 1M? (y/n)"
    read yn
    case "$yn" in
        y|Y) find -size +1M
        ;;
        n|N) echo "Завершить программу? (y/n)"
            read yn
            case "$yn" in
                y|Y) exit
                ;;
                n|N) return 44
                ;;
            esac
        ;;
    esac
}


while [ "1" -eq "1" ]
do
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

    File_size

    while [ "$?" = 55 ]
    do
        File_size
    done
    
    Find_size

    while [ "$?" = 44 ]
    do
        Find_size
    done

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
            y|Y) exit
            ;;
            n|N) continue
            ;;
        esac
        ;;
    esac
done