name = input("What is your name?\n")

if name == "Ben":
    evil_status = input("Are you evil?\n")
    if evil_status == "Yes":
        print("You're not welcome here Ben! Get out!\n\n")
        exit()
    else:
        print("Oh, so you'are one of those good Bens. Come on in!!")
else:
    print("Hello " + name + ", thank you so much for coming in today.\n\n")