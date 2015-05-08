#!/usr/bin/env python
import requests
import re
import csv
import json
from sets import Set
from bs4 import BeautifulSoup

#Will store quote and author in csv file
#Note: May have errors. Wikiquote pages do not have standard format.
#		Does not deal with special case pages (ignores them unless they have specific "Quotes" section)
#			/wiki/Les_Miserables 
#			/wiki/Fight_Club_(novel) (Novel organized my character)



init_page="/wiki/List_of_literary_works"
links_set=Set([init_page]) #Only go to links not seen before


def addCSVRow(quote, author):
	print "ADDING ROW"
	with open('quotes.csv', 'ab') as csvfile:
		writer=csv.writer(csvfile, delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)
		try:
			writer.writerow([quote.encode('utf-8'), author.encode('utf-8')])
		except UnicodeEncodeError as e:
			print quote
			print e
			print "UnicodeEncodeError: continuing to next quote"

def extractQuote(li_element):

	#strips away <a> link tags within quotes (sometimes..)
	#remove <a> link tags from children of li
	if li_element.find("a") is not None:
		li_element.a.unwrap()

	#remove any child list that contains extra information
	#if remove_sublist is True:
	if li_element.find("ul") is not None:
		li_element.ul.extract()


	return li_element.get_text()
	#return''.join(map(str,li_element.contents))


#Novel helper
def getQuotesWithSublist(sib, title, author):
	#print "in getQuotesWithSublisr"
	#loop through all the ul to get the quotes for this section (speaker)
	while sib is not None:
		tag_name = sib.name
		if tag_name=="dl" or tag_name=="h3":
		
			sib=sib.next_sibling
			continue
		elif tag_name=="ul":
			
			li_element=sib.find("li")

			if li_element.find("ul") is not None:
				extra=li_element.ul.extract().get_text().rstrip('\n')
			else:
				extra=None
				
			
			quote=extractQuote(li_element)
			#print quote
			
			if extra is not None:
				addCSVRow(quote, extra+" in <i>"+title+"</i> by "+author)
			else:
				addCSVRow(quote, "<i>"+title+"</i> by "+author)
			

		else:
			break
		sib=sib.next_sibling



def getNovelQuotes(soup, title):
	#print "in getNovel"
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
	#print author

	sections=soup.find_all("span", class_="mw-headline")

	if sections is not None:
		if sections[0].string=="Quotes":

			sib=sections[0].parent.next_sibling
			getQuotesWithSublist(sib, title, author)
				
		elif "Chapter" in sections[0].string:
			
			for section in sections:
				
				if "Chapter" not in section.string:
					break

				sib=section.parent.next_sibling
				getQuotesWithSublist(sib, title, author)	
				

#currently prints speaker then all the quotes for that speaker underneath
def getFilmQuotes(soup,title):

	sections=soup.find_all("span", class_="mw-headline")
	if sections is not None:
		for section in sections:

			speaker= section.string
			if speaker is None:
				return
			#Some sections are characters. Other sections do not have quotes
			elif speaker=="Dialogue" or speaker=="Taglines" or speaker=="Cast" or speaker=="External links":
				break
			#print speaker+" in <i>"+title+"</i>"

			#HTML organization:
			#h2 --> span (contains film speaker's name)
			#ul (sibling of h2) --> li (contains single quote)
			sib=section.parent.next_sibling

			#loop through all the ul to get the quotes for this section (speaker)
			while sib is not None:
				tag_name = sib.name
				if tag_name=="ul":
					quote= extractQuote(sib.find("li"))

	
					#print quote
					addCSVRow(quote, speaker+" in <i>"+title+"</i>")

				#reached end of ul tags
				else:
					break
				sib=sib.next_sibling

def getQuotes(soup, name):
	print "in func"
	sections=soup.find_all("span", class_="mw-headline")

	#print sections
	currname=name
	try:
		if sections is not None:
			if sections[0].string=="Quotes":
				print "is quotes"

				sib=sections[0].parent.next_sibling
				while sib is not None:
					tag_name = sib.name
					if tag_name=="ul":
						li_element=sib.find("li")
						
						if li_element.find("ul") is not None:
							extra=li_element.ul.extract().get_text().rstrip('\n')
						else:
							extra=None
			
						quote= extractQuote(li_element)
						#print quote
						if extra is not None:
							info=currname+" ("+extra+")"
						else:
							info=currname
						#print info
						addCSVRow(quote, info)
					#reached end of ul tags
					elif tag_name=="h3":
						head=sib.find("span", class_="mw-headline")
						if head is not None:
							currname=name+" in "+ head.get_text()
						else:
							currname=name
					elif tag_name=="h2":
						break
					sib=sib.next_sibling
	except IndexError:
		print "IndexError: returning"
		return


def parsePage(relative_link):

	try:
		print relative_link

		page=re.search("/wiki/(\S*)", relative_link).group(1)
		print page

	except AttributeError:
		print("Error: Extracting page parameter from link. Continuing to next link")
		return

	
	params = { "format":"json", "action":"parse", "prop":"text", "page":page }
	r=requests.get('http://en.wikiquote.org/w/api.php', params=params)
	#print (r.url)
	#print (r.content)
	content= json.loads(r.content)
	#print content
	try:
		txt=content['parse']['text']['*']
	except KeyError:
		print content
		print("Error: Extracting key. Continuing to next link")
		return 

	soup=BeautifulSoup(txt.replace("\\\"", "\"").replace("\\n","").replace('\n',''))

	title= content['parse']['title']

	p=soup.find("p")
	if p is not None:
		p_text=p.get_text()

		if "(born" in p_text or re.compile("[a-vA-S]*\s?[0-9]*,?\s?[0-9]\) was").search(p_text) is not None: 
			#Is person
			getQuotes(soup, title)
		elif "film" in p_text:
			#Is film
			print "film"
			getFilmQuotes(soup, title)
		elif "novel " in p_text:
			#Is novel
			print "novel"
			getNovelQuotes(soup, title)
		else:
			#Try if they have h2 with value "Quotes"
			getQuotes(soup, title)
	
	
	for link in soup.find_all("a"):
		href=str(link.get("href"))
		if "/wiki" in href and "wikipedia" not in href and "File" not in href and href not in links_set:

			links_set.add(href)
			parsePage(href)
	

#TESTING
#link="/wiki/Fight_Club_(film)
#link="/wiki/Forrest_Gump
#link="/wiki/To_Kill_a_Mockingbird_(film)
#link="/wiki/The_Shawshank_Redemption
#link="/wiki/Pride_and_Prejudice\"" #Novel with Quotes section & chapter headers
#link="/wiki/The_Grapes_of_Wrath" #Novel with Quotes section
#link="/wiki/The_Great_Gatsby #Novel with Chapters sections
#link="/wiki/Barack_Obama
#link="/wiki/John_Steinbeck
#link="/wiki/Jane_Austen
#link="/wiki/Jesus #Does not return any quotes (has different sections i.e. New Testament)
#link="/wiki/King_Arthur
#link="/wiki/Confucius
#link="/wiki/Fight_Club_(novel)"" #Does not return any quotes (It is a Novel without a quotes section)
#link="/wiki/Les_Miserables"
#link="/wiki/William_Shakespeare"
#link="/wiki/The_Incredible_Shrinking_Man"
#parsePage(link)
parsePage(init_page)



