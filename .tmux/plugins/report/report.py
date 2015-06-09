#!/usr/bin/env python
# encoding: utf-8
from datetime import date
import os.path


def format_time(m):
    h = int(m)/60
    m = m - h*60
    return "%d:%d" % (h, m)

dat = date.today().isoformat()
prefix = "/Users/enting/Scripts/CronScript/time_recorder_history/"
path = os.path.join(prefix, str(dat))

with open(path) as f:
    text = f.read()
text_list = text.split("\n")

app_list = []
for i in text_list:
    if i and len(i.split()) > 1:
        app_list.append(i.split()[1])

print(format_time(len(app_list)))
