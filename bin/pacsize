#!/usr/bin/env python
import re
import os

class Package:
    def __init__(self,name,size):
        self.name = name
        self.size = int(round(float(size)))
    def __repr__(self):
        return `self.size`+" "+self.name    
    def __cmp__(self,other):
        return cmp(other.size,self.size) #desc

paclist = []        

re_name = re.compile(r'Name\s*:\s*(\S+)')
re_size = re.compile(r'Installed Size\s*:\s*([0-9.]+).*')

p = os.popen("pacman -Qi","r")

for line in p.readlines():
    match_name = re_name.match(line)
    match_size = re_size.match(line)
    if match_name : 
            package_name = match_name.groups(1)[0]
    if match_size :
            package_size = match_size.groups(1)[0]
            paclist.append(Package(package_name,package_size))

p.close()

paclist.sort()
for pac in paclist: print pac
