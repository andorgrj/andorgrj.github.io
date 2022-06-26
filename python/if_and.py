print("Hello welcome to python")

name = input("What is your name?\n")

if name == "Ben" or name == "Patricia" or name == "Loki":
    evil_status = input("Are you evil?\n")
    good_deeds = int(input("How many good deeds have you done today?\n"))
    if evil_status == "Yes" and good_deeds < 4:
        print("You are not welcome here " + name +"","!!", "Get out!!")
        exit()
    else:
        print("Hello " + name + ", thank you so much for coming in today.\n\n\n")

else:
    print("Hello " + name + ", thank you so much for coming in today.\n\n\n") 

