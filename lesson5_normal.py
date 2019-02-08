import lesson5_easy, sys

while True:
    key = input('Введите нужную команду\n'
                '1 - Перейти в папку\n'
                '2 - Просмотреть содержимое текущей папки\n'
                '3 - Удалить папку\n'
                '4 - Создать папку\n'
                'q - выйти\n')
    if key == 'q':
        sys.exit()
    elif key == '1':
        path_str = input('Введите путь: ')
        lesson5_easy.NormalPartChangeDirectory(path_str)
    elif key == '2':
        lesson5_easy.NormalPartShowContentOfCurrentFolder()
    elif key == '3':
        folder_name = input('Введите имя папки для удаления: ')
        lesson5_easy.NormalPartDeleteFolder(folder_name)
    elif key == '4':
        folder_name = input('Введите имя папки для создания: ')
        lesson5_easy.NormalPartCreateFolder(folder_name)
    else:
        print('Команда не найдена, попробуйте снова')

