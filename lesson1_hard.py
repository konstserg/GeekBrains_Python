name = input(' Введите свое имя: ')
surname = input(' Введите свою фамилию: ')
age = int(input(' Введите свой возраст: '))
weight = int(input(' Введите свой вес: '))

if age <= 30 and (weight >= 50 or weight <= 120):
    print(name, surname, ' у вас хорошее состояние')
elif (age > 30 or age <= 40) and (weight <= 50 or weight >= 120):
    print(name, surname, ' вам требуется начать вести правильный образ жизни')
elif age >= 41 and (weight <= 50 or weight >= 120):
    print(name, surname, ' вам требуется врачебный осмотр')
else:
    print(' Наверняка вам все нравится в себе , не парьтесь')


