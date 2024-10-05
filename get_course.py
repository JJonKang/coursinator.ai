# Experimenting with web scraping to fetch courses starting from CS first
# 


import requests
from bs4 import BeautifulSoup #terminal: pip install beautifulsoup4
def urlprint():
    url = "https://catalog.uic.edu/ucat/course-descriptions/"
    r = requests.get(url)
    print(r)

    soup = BeautifulSoup(r.text, "html.parser")
    nav_bar = soup.find('div', id='nav-col')
    nav_li_bar = soup.find_all("li")
    link_collection = []
    for link in nav_li_bar:
        a_tag = link.find('a')
        if a_tag and a_tag.has_attr('href'):
            href_value = a_tag['href']
            # Check if 'href' starts with "/ucat/course-descriptions/"
            if href_value.startswith("/ucat/course-descriptions/"):
                # Ensure that there is more content after "/ucat/course-descriptions/"
                # For example, the href must have at least one more part like '/rels/'
                parts = href_value.split('/')

                if parts[3]:  # Check if there's something after 'course-descriptions/'
                    full_link = "https://catalog.uic.edu" + href_value
                    link_collection.append(full_link)

    return link_collection

def main():
    course_urls = urlprint()
    print(course_urls[27])
    r = requests.get(course_urls[27])
    print(r)
    soup = BeautifulSoup(r.text, "html.parser")
    content = soup.find('div', id='textcontainer')
    course_title = soup.find_all('p', class_='courseblocktitle')
    course_desc = soup.find_all('p', class_='courseblockdesc')

    courses = []
    titles = []
    course_descriptions = []
    for title, desc in zip(course_title, course_desc):
        title_name = (title.get_text(strip=True)).split(". ")
        descs = (desc.get_text())
        titles.append(title_name)
        course_descriptions.append(descs)
        prereq = descs[descs.find("Prerequisite(s): "): -1]
        print(prereq)
        cleaned_prereq = prereq[prereq.find(':') : (prereq.find('.'))]
        
        course_info = {
            'course_num': title_name[0],
            'course_title': title_name[1],
            'cred_hours': title_name[2],
            'prerequisites': cleaned_prereq
        }
        courses.append(course_info)
        # course_info = {
        #     'title': title.get_text(strip=True),
        #     'description': desc.get_text(strip=True)
        # }
        # courses.append(course_info)

    # Output the list of courses
        print(course_info)


    

if __name__ == "__main__":
    main()