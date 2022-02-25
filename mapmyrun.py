import requests
from bs4 import BeautifulSoup

URL = "http://www.mapmyfitness.com/workout/5896064653"
page = requests.get(URL)

soup = BeautifulSoup(page.content, "html.parser")

workoutend = soup.find("</h4>")
print(soup)
print(workoutend)
