from selenium import webdriver
from selenium.webdriver.chrome.options import Options


chrome_options = Options()
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--disable-dev-shm-usage')
chrome_options.add_argument('--headless')
d = webdriver.Chrome('./chromedriver', chrome_options=chrome_options)
d.get('https://www.slashgear.com/857623/the-us-national-science-foundation-has-groundbreaking-news-about-the-milky-way/')

size = d.get_window_size()
width = d.execute_script('return document.body.parentNode.scrollWidth')
height = d.execute_script('return document.body.parentNode.scrollHeight')

d.set_window_size(width, height)
d.find_element_by_tag_name('body').screenshot("./foo1.png")
d.set_window_size(size['width'], size['height'])

d.close()
d.quit()