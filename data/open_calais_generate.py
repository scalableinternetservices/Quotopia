#!/usr/bin/env python
#
# Generates Open Calais data for all data in the first field of an input csv
# Sends json output for each into separate files in an 'open-calais' directory
# The filenames correspond to the row of the source data in the csv

import requests
import re
import csv
import json
import sys
import os

# Input args should be:
# 1. Open Calais API token
# 2. Filename of the quote csv file
token = sys.argv[1];
csvfilename = sys.argv[2];

# Open quotes csv file
csvfile = open(csvfilename, 'rb')
reader = csv.reader(csvfile, delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)

# move past the first row(it's just a csv schema def)
reader.next()

count = 1
for row in reader:
    if os.path.isfile("open-calais/" + str(count) + ".json"):
        count = count + 1
        continue

    #Send Open Calais request for every quote
    params = {'access-token': token}
    headers = {'outputformat': 'application/json'}
    quote = row[0]
    r = requests.post("https://api.thomsonreuters.com/permid/calais", params=params,
            data=quote, headers=headers)
    parsed_json = r.json()

    # dump response to file
    with open("open-calais/" + str(count) + ".json", 'w') as outfile:
        json.dump(parsed_json, outfile)
        count = count + 1
