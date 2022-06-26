#coffee menu

name = input("What is your name?\n")
menu = "Latte, Espresso, Cappucino\n"

#Ask the customer what they want from the menu and store it in the variable ORDER.
order = input(name + ", what would you like from our menu today?\n\n Here is what we are serving:\n\n" + menu + "\n\n")

#Ask how many they want and store it in the variable QUANTITY
quantity = input("How many coffees would you like?\n")

#Set the price for coffee
if order == "Espresso":
    price = 13
elif order == "Latte":
    price = 8
    cream_status = input("Do you want cream?\n")
    if cream_status == "Yes":
        price = 10
        #print()
        #exit()
elif order == "Cappucino":
    price = 6
else:
    print("Sorry, we don't have that here.")
    price = 0
print(price)