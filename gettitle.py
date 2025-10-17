from urllib.request import urlopen
from bs4 import BeautifulSoup
import os
import sys
soup = BeautifulSoup(urlopen("file://" + os.path.dirname(os.path.realpath(__file__))+ "/tmp/htmlout_" + sys.argv[1] + ".html"), features="lxml")
print(soup.title.string)
