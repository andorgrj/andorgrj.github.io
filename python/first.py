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

#String variables

course = 'Python for beginners'
print(len(course))               #len is for to count the number of items in a list
print(course.upper())            #. methods lehetőségek
print(course.find('P'))          # find indexet keresi
print(course.replace('beginners', 'Absolute beginners')) #replace things
print('Python' in course)        # szöveget keres, hogy tartalmazza-e

#Arithmetic operations

x = 10
x = x + 3
x += 3
x -= 3
print(x)

#Operator precedence

x = 10 + 3 * 2          # ennek 16 az eredménye mert a szorzással kezdi a program a műveletet
print(x)                # parenthesis, exponentiation, multiplication, addition a műveleti sorrend
x = (10 + 3 * 2 ** 2)   # a zárójeles hamarabb elvégződik

x = (2 + 3) * 10 - 3 
print(x)

#Math functions

import math
import queue
import threading
x = 2.9
round(x)

#IF

is_hot = True
is_cold = True

if is_hot:
        print("It is a hot day")
        print("Drink plenty of water")
elif is_cold:
        print("It is a cold day")
        print("Wear warm clothes")
else:
        print("Enjoy your day")


price = 1000
has_good_credit = True
if has_good_credit:
        down_payment = 0.1 * price
else:
        down_payment = 0.2 * price
print(f"Down payment: {down_payment}")

#Logical Operators
#AND
#OR
#NOT

has_high_income = True
has_good_credit = True

if has_high_income and has_good_credit:
        print("Eligible for loan")


#Comparison Operators

temperature = 30

if temperature > 30:
        print("It is a hot day")
else:
        print("It is a hot day")


name = "J"

if len(name) < 3:
        print("Name must be at least 3 characters")
elif len(name) > 50:
        print("Name must be maximum of 50 characters")
else:
        print("Name looks good")

#Weight Converter Program

weight = int(input('Weight: '))
unit = input('(L)bs or (K)g:  ')
if unit.upper() == "L":
        converted = weight * 0.45
        print(f"You are {converted} kilos")
else:
        converted = weight / 0.45
        print(f"You are {converted} pounds")

#While loops

#while condition:

i = 1
while i <= 5:
        print(i)
        i = i + 1
print("Done")

i = 1
while i <= 5:
        print('*' * i)
        i = i + 1
print("Done")

# While loop game

secret_number = 9
guess_count = 0
guess_limit = 3 
while guess_count < guess_limit:
        guess = int(input('Guess: '))
        guess_count += 1
        if guess == secret_number:
                print('You won!')
                break
else:
        print('Sorry try')

# while loop game

command = ""
started = False
while True:
        command = input("> ").lower()
        if command == "start" :
                if started:
                        print("Car is already started!")
                else:
                        started = True
                        print("Car started...")
        elif command == "stop" :
                if not started:
                        print("Car is already stopped!")
                else:
                        started = False
                        print("Car stopped.")
        elif command == "help" :
                print("""
                start - to start the car
                stop - to stop the car
                quit - to quit
                """)
        elif command == "quit" :
                break
        else:
                print("Sorry, i don't understand!")


# For loop string iterációhoz

for item in 'Python':
        print(item)

for item in ['körte', 'répa', 'saláta']:
        print(item)

for item in range(10):
        print(item)

for item in range(5, 10, 2):
        print(item)

prices = [10, 20, 30]
total = 0
for price in prices:
        total = total + price 
print(f"Total: {total}")


#Nested loops

for x in range(4):
       print(x)

#for x in range(4):
        #for y in range(3):
        #print(f'({x}, {y})')


#LISTS

numbers = [5,2, 5, 2, 2]
for x_count in numbers:
        print('x' * x_count)


numbers = [5,2, 5, 2, 2]
for x_count in numbers:
        output = ''
        for count in range(x_count)
        output += 'x'
        print(output)


names = ['John' , 'Bob', 'Mosh', 'Sarah']
names[0] = 'Jon'
print(names)

numbers = [3, 6, 2, 8, 4, 10]
max = numbers[0]
for number in numbers:
        if number > max:
                max = number
print(max)

matrix = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
]
print(matrix)[0] [1])


matrix = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
]
for row in matrix:
        for item in row:
                print(item)

#LIST METHODS

numbers = [5, 2, 1, 7, 4]
numbers.append(20)
print(numbers)

numbers = [5, 2, 1, 7, 4]
numbers.insert(0, 10) #megadott helyre illeszti be az adatot
numbers.clear
numbers.pop()
numbers.index(5))
numbers.sort()
numbers.reverse()
numbers2 = numbers.copy()
numbers.append(10)
print(numbers)
print(numbers.count(5))

#removing duplicates

numbers = [2,2,4,6,3,4,4]
uniques = []
for number in numbers:
        if number not in uniques:
                uniques.append(number)
print(uniques)

#Tuples (inmutable objects) immutable = cannot be changed

numbers = (1, 2, 3)
numbers[0] = 10
print(numbers[0])

#unpacking /with tuples

coordinates = (1,2,3)
x = coordinates[0]
y = coordinates[1]
z = coordinates[2]

x, y, z = coordinates

#dictionaries

customer = {
        "name":"John Doe"
        "age": 30,
        "is verified": True
}
customer["birthdate"] = "Jan 1 1980"
print(customer["birthdate"])

phone = input("Phone: ")
digits_mapping = {
        "1":"One",
        "2":"Two",
        "3":"Three",
        "4":"Four"
}
output = ""
for ch in phone:
       output += digits_mapping.get(ch, "!") + " "
print(output)



def func(a, b):
        a += 1
        b.append(1)

a, b = 0, []
func(a, b)
print(a, b)

q = queue.Queue()
for i in [3,2,1]:
        def f():
                time.sleep(i)
                q.put(i)
        threading.Thread(target=f).start()
print(q.get())

f= lambda n: 1 if n <= 1 else n * f(n -1)

g = f(4)
print(g)

words = ["Hello", "World"]
for i, word in enumerate(words):
        word.lower()
        words[i] = word[::-1]
print(words)



def _(func, items):
        i = 0
        for item in items:
                if func(item):
                        items[i] = item
                        i + 1
                        del items[i:]

try:
        file = open(filepath)
        data = file.read()
finally:
        file.close()

