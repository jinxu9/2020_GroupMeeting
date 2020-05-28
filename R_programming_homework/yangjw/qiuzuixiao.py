from collections import Counter
import os
path = "C:/Users/miao/Desktop/R课程作业/01" #文件夹目录
files= os.listdir(path) #得到文件夹下的所有文件名称

j = []
for file in files: #遍历文件夹
    s = []
    g = open(path+"/"+file); #打开文件
    for line in g: #遍历文件，一行行遍历，读取文本
        x1 = line.lstrip()
        x2 = x1.strip()
        x3 = x2.split('\t')
        for word in x3:
            s.append(word)
    maxV = Counter(s).most_common(1)[0]
    print(maxV[0])
    j.append(maxV[0])
f = open("0003.txt", "a+")
for word in j:
    f.write(word+'\n')
f.close()
        

