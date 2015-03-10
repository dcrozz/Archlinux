#!/usr/bin/python2
# -*- coding: utf-8 -*-  
import urllib2
from bs4 import BeautifulSoup
import gzip
import StringIO
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
def addHeader(request):
    request.add_header("User-Agent","Mozilla/5.0 (X11; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0")
    request.add_header("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    request.add_header("Accept-Language","en-US,en;q=0.5")
    request.add_header("Accept-Encoding","gzip, deflate")
    request.add_header("Referer","http://www.baidu.com/link?url=cZAD4wbDHwU20ldReXrWH-iWndauxt5BED041dvzDbHaCqhDKoKgJ60q7JJV7L5jdYOVhoZGw8lBcrRPDIhPTK&ie=utf-8&f=3&tn=baidu&wd=%E6%97%A0%E5%A4%B4%E9%AA%91%E5%A3%AB%E5%BC%82%E9%97%BB%E5%BD%9513%E5%8D%B7&oq=wutouqishi&rsp=0&inputT=7948")
    request.add_header("Connection","keep-alive")
    request.add_header("Cache-Control","max-age=0")
    return request




if __name__=="__main__":
    url ="http://lknovel.lightnovel.cn/main/book/5558.html" 
    req = urllib2.Request(url)
    req = addHeader(req)
    res = urllib2.urlopen(req)
    compressed = StringIO.StringIO(res.read())
    unzipped = gzip.GzipFile(fileobj=compressed)    
    soup  = BeautifulSoup(unzipped)
    link  = soup.find("ul",class_="lk-chapter-list").find_all("a")
    for item in link:
        url = item["href"]
        req = urllib2.Request(url)
        req = addHeader(req)
        res = urllib2.urlopen(req)
        compressed = StringIO.StringIO(res.read())
        unzipped = gzip.GzipFile(fileobj=compressed)    
        soup  = BeautifulSoup(unzipped)
        print soup.find(id="J_view").get_text()
