#!/usr/bin/env python
import requests
import re
import csv
from sets import Set
from bs4 import BeautifulSoup

#Will store quote that is in HTML format(has b and i tags within. Can change this if needed) and author in csv file
#Note: May have errors. Wikiquote pages do not have standard format.

#TO-DO: Escape special characters for HTML
#		Write every parsed quote and author as row to csv file
#		Scrape links
# 		Parse for title of film/novels/other literary works
#		Deal with pages for people
#		Deal with special case pages for novels 
#			/wiki/Les_Miserables
#			/wiki/Fight_Club_(novel) (organized my character)
#		Deal with pages for other literary works


init_page="\"/wiki/List_of_literary_works\""
links_set=Set([init_page]) #Only go to links not seen before

#with open('quotes.csv', 'w') as csvfile:
#	writer.writesection()

def addCSVRow(quote, author):
	with open('quotes.csv', 'w') as csvfile:
		writer=csv.writer(csvfile, delimiter=' ',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)
		writer.writerow([quote, author])

def extractQuote(li_element):
	#strips away <a> link tags within quotes (sometimes..)
	#TO-Do: remove <a> link tags from children of li
	if li_element.find("a") is not None:
		li_element.a.unwrap()

	#remove any child list that contains extra information
	#if remove_sublist is True:
	if li_element.find("ul") is not None:
		li_element.ul.extract()


	return''.join(map(str,li_element.contents))

def getQuotesWithSublist(sib, author):
	
	#loop through all the ul to get the quotes for this section (speaker)
	while sib is not None:
		tag_name = sib.name
		if tag_name=="dl" or tag_name=="h3":
			sib=sib.next_sibling
			continue
		elif tag_name=="ul":
			li_element=sib.find("li")
			
			if li_element.find("ul") is not None:
				extra=extractQuote(li_element.ul.extract().next)+" in "
			else:
				extra=""
				#TO-DO: add to csv file instead of printing
			print extractQuote(li_element)
			print extra+"<title> by "+author
		else:
			break
		sib=sib.next_sibling


def getNovelQuotes(soup):
	desc=soup.find("p")

	if desc is not None:
		#Example: by <a href="/wiki/Jane_Austen" title="Jane Austen">Jane Austen</a>
		#Author usually in a tag after a "by"
		author=re.search("by <a href=\S* title=\"[a-zA-Z\s\.]*\">([a-zA-Z\s\.]*)</a>", str(desc))
		if author is None:
			author=re.search("by ([a-zA-Z\s]*)[,.]+ ", desc.get_text())

		if author is None:
			author=""
		else: 
			author=author.group(1)
	print author

	sections=soup.find_all("span", class_="mw-headline")

	if sections is not None:
		if sections[0].string=="Quotes":

			sib=sections[0].parent.next_sibling
			getQuotesWithSublist(sib, author)
				
		elif "Chapter" in sections[0].string:
			if sections is not None:
				for section in sections:
					if "Chapter" not in section.string:
						break
					sib=section.parent.next_sibling
					getQuotesWithSublist(sib, author)	
				


def getFilmQuotes(soup):
	#TO-DO: get filmname
	#filmname=soup.find("h1", class_="firstHeading")

	sections=soup.find_all("span", class_="mw-headline")
	if sections is not None:
		for section in sections:

			speaker= section.string

			#Some sections are characters. Other sections do not have quotes
			if speaker=="Dialogue" or speaker=="Taglines" or speaker=="Cast" or speaker=="External links":
				break
			print speaker

			#HTML organization:
			#h2 --> span (contains film speaker's name)
			#ul (sibling of h2) --> li (contains single quote)
			sib=section.parent.next_sibling

			#loop through all the ul to get the quotes for this section (speaker)
			while sib is not None:
				tag_name = sib.name
				if tag_name=="ul":
					quote= extractQuote(sib.find("li"))

					#TO-DO: Add quote to csv file instead of printing
					print quote

				#reached end of ul tags
				else:
					break
				sib=sib.next_sibling


def parsePage(relative_link):

	try:
		page=re.search("\"/wiki/(\S*)\"", relative_link).group(1)
	except AttributeError:
		print("Error: Extracting page parameter from link. Continuing to next link")
		return

	
	params = { "format":"json", "action":"parse", "prop":"text", "page":page }
	r=requests.get('http://en.wikiquote.org/w/api.php', params=params)
	#print (r.url)
	#print (r.content)
	content=r.content
	soup=BeautifulSoup(r.content.replace("\\\"", "\"").replace("\\n",""))


	if "film" in soup.find("p").get_text():
		getFilmQuotes(soup)
	elif "novel" in soup.find("p").get_text():
		getNovelQuotes(soup)
	
	"""
	for link in soup.find_all("a"):
		href=str(link.get("href"))
		if "/wiki" in href and "wikipedia" not in href and href not in set:

			links_set.add(href)
			parsePage(href)
	"""

#TESTING
#link="\"/wiki/Fight_Club_(film)\""
#link="\"/wiki/Forrest_Gump\""
#link="\"/wiki/To_Kill_a_Mockingbird_(film)\""
#link="\"/wiki/The_Shawshank_Redemption\""
#link="\"/wiki/Pride_and_Prejudice\"" #Novel with Quotes section & chapter headers
#link="\"/wiki/The_Grapes_of_Wrath\"" #Novel with Quotes section
link="\"/wiki/The_Great_Gatsby\"" #Novel with Chapters sections


parsePage(link)




