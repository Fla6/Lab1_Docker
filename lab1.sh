#!/bin/bash

echo -e
echo "Новиков Владислав гр. 726"
echo "Данный скрипт:"
echo "- Запрашивает путь к каталогу"
echo "- Запрашивает размер файла"
echo "- Находит все файлы больше заданного размера и удаляет их"

Find_directory () {
    echo -e
    echo -n "Введите путь: "
    read path
    if test -d "$path"
    then
        cd $path
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
    echo -e
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
    echo -e
    echo -n "Укажите размер файлов, котрые вы хотите посмотреть (в М): "
    read ssize
    echo "Файлы размером больше "$ssize"M"
    find -size +"$ssize"M
    echo "Хотите продолжить или указать другой размер? (1/2)"
    read yn
    case "$yn" in
        1) Delete_file
        ;;
        2) return 44
        ;;
    esac
}

Delete_file () {
    echo -e
    echo "Удалить эти файлы? (y/n)"
    read yn
    case "$yn" in
        y|Y) find -size +"$ssize"M -delete
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

    while [ "$?" -eq 44 ]
    do
        Find_size
    done

    Delete_file
done


