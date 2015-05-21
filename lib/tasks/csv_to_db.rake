require 'csv'
require 'digest/md5'

# Use command:
# rake csv_to_db:add_quotes
# CSV file header: content,name
# CSV file format: separated by ','. quote_char is '|'
	# Example CSV file:
		#content,name,extra
		#|Ow,my arm hurts.|,Steven Collison,

namespace :csv_to_db do
	task :add_quotes => :environment do
		csv_text = File.read('data/categories_4000_quotes.csv') #
		csv = CSV.parse(csv_text, col_sep: ",", quote_char: "|", :headers => true)
		csv.each do |row|

		 	row_hash=row.to_hash

		 	###Slice row to just get author name. Then symbolize the row
			author_row = row_hash.slice('name').inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

			begin
			  author=Author.find_or_create_by!(name: row_hash['name'])
			rescue Exception => e
				puts "#{e.message}. Did not add author: #{row_hash['name']}"
		 		next
			end

			#puts "#{author['id']}"
		 	quote_row=row_hash.dup

		 	###Quote does not author name
			quote_row.delete('name')
			quote_row.delete('categories')
		 	###Get author_id attribute from author entry
			quote = nil
			quote_row['author_id']=author['id']
			if(quote_row['content'] != nil)
				quote_row['content_hash']=Digest::MD5.hexdigest(quote_row['content'].downcase)

				###Symbolize the row
				quote_row = quote_row.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

				begin
			 	  quote = Quote.create!(quote_row)
			 	rescue Exception => e
			 	  puts "#{e.message}. Did not add quote: #{quote_row}"
			 		next
			 	end
			end

			# We expect a single category in the categories field
			category_field = row_hash['categories']
			if (category_field != nil) then
				if (quote != nil && !(category_field =~ /^\s*$/)) then
					cat = Category.find_by(content: category_field)
					if (cat == nil) then
						cat = Category.create!(content: category_field)
					end
					cat.categorizations.create!(quote_id: quote['id'], category_id: cat['id'])
			  end
			end
		end
	end # task
end
