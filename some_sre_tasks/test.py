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
    result = len(bodyContent.split())
    print(f"There are {str(result)} words in the JSON's body.")
    return result

def even_numbers(inputNumber): 
    countEven = 0
    inputNumber = inputNumber * 3
    for i in range(inputNumber):
        if (i % 2) == 0:
            countEven = countEven + 1
    print(f"There is {countEven} even number in that range.") 

def main():
    get_content()
    even_numbers(count_words())

if __name__ == "__main__":
    main()
