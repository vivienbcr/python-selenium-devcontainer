#!/usr/bin/env python
# -*- coding: utf-8 -*-
from selenium.webdriver import Chrome, ChromeOptions
def main():
    """ Main program """
    chrome_options = ChromeOptions()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    driver = Chrome(options=chrome_options)
    return 0

if __name__ == "__main__":
    main()