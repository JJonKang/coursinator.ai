import requests
from bs4 import BeautifulSoup #terminal: pip install beautifulsoup4
def urlprint():
    url = "https://catalog.uic.edu/ucat/colleges-depts/"
    r = requests.get(url)
    print(r)

def main():
    urlprint()

if __name__ == "__main__":
    main()