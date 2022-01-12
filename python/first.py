print("Andor")
print('o----')
print(' |||')
print('*' * 10)


price = 10
rating = 4.9
name = 'Andor'
is_published = True
print(price)


full_name = 'John'
age = 20
is_new = True

#Input from the user:

name = input('What is your name? ')
print('Hi ' + name)

name = input('What is your name? ')
favourite_color = input('What is your favourite color? ')
print(name + 'likes ' + favourite_color)

#Conversion

birth_year = input('Birth year: ')
age = 2019 - int(birth_year)
print(age)

#string convert into int, float, bool - azért, hogy szám legyen belőle és azzal tudjon számolni

weight_lbs = input('How many pounds you weigh? ')
weight_kg = int(weight_lbs) * 0.453
print(weight_kg)

#Strings

course = "Python's for beginners"
course2 = 'Python for "beginners"'
print(course)

course = '''
Hi negerkocka
hello
több sorba írható szöveg így
'''

course = 'Python for beginners'
        #'012345'
print(course[0])
print(course[1:-1])
print(course[0:-1])

#Formatted strings

first = 'John'
last = 'Smith'
message = first + ' [' + last + '] is a coder'
msg = f'{first} [{last}] is a coder' #it is the formatted string
print(message)