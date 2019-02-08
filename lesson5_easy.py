# Задача-1:
# Напишите скрипт, создающий директории dir_1 - dir_9 в папке,
# из которой запущен данный скрипт.
# И второй скрипт, удаляющий эти папки.

# Задача-2:
# Напишите скрипт, отображающий папки текущей директории.

# Задача-3:
# Напишите скрипт, создающий копию файла, из которого запущен данный скрипт.


import os, sys, shutil

def GetFolderPaths():
    return [os.path.join(os.getcwd(), 'dir_'+str(i)) for i in range(1,10)]

def CreateFolders():
    dir_path = GetFolderPaths()
    for i in dir_path:
        try:
            os.mkdir(i)
            print('Директории созданы')
        except FileExistsError:
            print('Директория {} уже существует'.format(i))

def RemoveFolders():
    dir_path = GetFolderPaths()
    for i in dir_path:
        try:
            os.rmdir(i)
            print('Директории удалены')
        except FileNotFoundError:
            print('Директории {} не существует'.format(i))

def ShowFolders():
    print([f.name for f in os.scandir(os.getcwd()) if f.is_dir()])

def CreateCopyOfExecFile():
    src = os.path.realpath(__file__)
    dst = os.path.join(os.getcwd(), 'copy_file.py')
    print('Создал копию файла {}'.format(shutil.copy (src, dst)))



#normal

def NormalPartCreateFolder(folder_name):
    try:
        os.mkdir(folder_name)
        print('Директория {} успешно создана'.format(folder_name))
    except FileExistsError:
        print('Невозможно создать. Директория {} уже существует'.format(folder_name))

def NormalPartDeleteFolder(folder_name):
    try:
        os.rmdir(folder_name)
        print('Директория {} успешно удалена'.format(folder_name))
    except FileNotFoundError:
        print('Невозможно удалить. Директории {} не существует'.format(folder_name))

def NormalPartShowContentOfCurrentFolder():
    print(os.listdir(path=os.getcwd()))

def NormalPartChangeDirectory(path_str):
    try:
        os.chdir(path_str)
        print('Успешно перешёл по пути {}'.format(path_str))
    except:
        print('Невозможно перейти. Путь {} не найден'.format(path_str))


if __name__ == "__main__":
    while True:
        key = input('Введите нужную команду\n'
                '1 - Создать папки(задача-1)\n'
                '2 - Удалить папки(задача-1)\n'
                '3 - Показать папки текущей директории(задача-2)\n'
                '4 - Создать копию исполняемого файла(задача-3)\n'
                'q - выйти\n')
        if key == 'q':
            sys.exit()
        elif key == '1':
                CreateFolders()
        elif key == '2':
            RemoveFolders()
        elif key == '3':
            ShowFolders()
        elif key == '4':
            CreateCopyOfExecFile()
        else:
            print('Команда не найдена, попробуйте снова')


