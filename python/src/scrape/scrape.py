#some issues with this, i'll need to specify stuff later

import requests
from bs4 import BeautifulSoup #terminal: pip install beautifulsoup4
def urlprint():
    url = "https://catalog.uic.edu/ucat/colleges-depts/"
    r = requests.get(url)
    print(r)

    soup = BeautifulSoup(r.text, "html.parser")
    nav_bar = soup.find('div', id='nav-col')
    nav_li_bar = soup.find_all("li", class_="isparent")
    link_collection = []
    for link in nav_li_bar:
        a_tag = link.find('a')
        if a_tag and a_tag.has_attr('href'):
            link_collection.append(a_tag['href'])
    for link in link_collection:
        full_link = "https://catalog.uic.edu" + link
        print(full_link)

def main():
    urlprint()

if __name__ == "__main__":
    main()