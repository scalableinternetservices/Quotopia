#!/usr/bin/env python
#
# Parses the "SocialTag" data from previously generated Open Calais json responses
# The parsed social tags are added to the end of the csv file passed as argument
# To match the Open Calais response with a row in the CSV, the file name of the response
# should correspond to the row number in the csv. e.g. 1.json corresponds to the first quote
#

import csv
import json
import sys
import os
import re

# Arguments are output csv filename and directory containing previously generated responses
csv_filename = sys.argv[1]
open_calais_dir = sys.argv[2]

# open input and output quotes csv
quotes = open(csv_filename, 'r');
quotes_and_cats = open("categories_"+ csv_filename, 'w');

reader = csv.reader(quotes, delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)
writer = csv.writer(quotes_and_cats, delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)

# Write header to new file
writer.writerow(next(reader) + ["categories"])

count = 1
for row in reader:
    cur_file = open(open_calais_dir + "/" + str(count) + ".json", 'rb')
    oc_response_data = json.load(cur_file)

    # Add categories to last field in the corresponding csv row
    # parse social tag keys
    social_tag_re = re.compile(".*SocialTag.*")
    keys = filter(social_tag_re.match, oc_response_data.keys())
    data = ""
    for key in keys:
        category =  oc_response_data[key]["name"].encode('utf-8')
        if oc_response_data[key]["importance"] == "1" and len(category.split()) < 3:
                data = oc_response_data[key]["name"].encode('utf-8')
    writer.writerow(row+[data] )
    count = count + 1
