
from urllib.request import urlopen                            # import urllib library
import json                                                   # import json
url = "https://jsonplaceholder.typicode.com/posts/50"         # store the URL in url as 
response = urlopen(url)
data_json = json.loads(response.read())                       # storing the JSON response # from url in data
print(data_json)                                              # print the json response

-------------------------------------------------------------------------

#text = {'userId': 5, 'id': 50, 'title': 'repellendus qui recusandae incidunt voluptates tenetur qui omnis exercitationem', 'body': 'error suscipit maxime adipisci consequuntur recusandae\nvoluptas eligendi et est et voluptates\nquia distinctio ab amet quaerat molestiae et vitae\nadipisci impedit sequi nesciunt quis consectetur'}

#print(text)
#length = len(text)
#print(length)

# Get the total word count
#total = sum(text.values())
#text.writerows([key, d[key], d[key] / total] for key in list(d.keys()))


text = "error suscipit maxime adipisci consequuntur recusandae\nvoluptas eligendi et est et voluptates\nquia distinctio ab amet quaerat molestiae et vitae\nadipisci impedit sequi nesciunt quis consectetur"
file = text
data = file.read()
words = data.split()

print('Number of words in text file :', len(words))



f = open("C:\Desktop\texttocount.txt", "x")
f = open("C:\Desktop\texttocount.txt", "a")
f.write({
  "userId": 5,
  "id": 50,
  "title": "repellendus qui recusandae incidunt voluptates tenetur qui omnis exercitationem",
  "body": "error suscipit maxime adipisci consequuntur recusandae\nvoluptas eligendi et est et voluptates\nquia distinctio ab amet quaerat molestiae et vitae\nadipisci impedit sequi nesciunt quis consectetur"
})
f.close()

file = open("C:\Desktop\texttocount.txt", "rt")
data = file.read()
words = data.split()

print('Number of words in text file :', len(words))

------------------------------------------------------------

file = open("C:\Desktop\texttocount.txt", "r")
for line in file:
  words = data.split()
  count += len(words)
file.close()  
print("Number of words in the file : ", count)



----------------------------------------------------------

import requests, json

filename = './content.json'
url = "https://jsonplaceholder.typicode.com/posts/50"

def get_content ():
    getRequest = requests.get(url)
    text = getRequest.text
    data_json = json.loads(text)
    with open(filename, 'w') as outfile:
        json.dump(data_json, outfile)
    print(data_json)

def count_words():
    with open(filename) as json_file:
        data = json.load(json_file)
    bodyContent = data['body']
    #print(bodyContent)
    #print(bodyContent.split())
    result = len(bodyContent.split())
    print(f"There are {str(result)} words in the JSON's body.")
    return result

def even_numbers(inputNumber): 
    #prints all the even numbers from that number up to that amount times 3.
    #print(f"Original number: {inputNumber}")
    countEven = 0
    inputNumber = inputNumber * 3
    for i in range(inputNumber):
        if (i % 2) == 0:
            countEven = countEven + 1
    print(f"Wow there is {countEven} even number in that range!") 

def main():
    get_content()
    #even_numbers(count_words())

if __name__ == "__main__":
    main()