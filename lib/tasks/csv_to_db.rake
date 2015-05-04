require 'csv'

# Use command:
# rake csv_to_db:add_quotes
# CSV file header: content,name
# CSV file format: separated by ','. quote_char is '|'
	# Example CSV file:
		#content,name
		#|Ow,my arm hurts.|,Steven Collison

namespace :csv_to_db do
	task :add_quotes => :environment do
		csv_text = File.read('data/quotes_16000.csv') #
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
		 	quote_row=row_hash

		 	###Quote does not author name
			quote_row.delete('name')


		 	###Get author_id attribute from author entry
			quote_row['author_id']=author['id']

			###Symbolize the row
			quote_row = quote_row.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
			#puts "#{quote_row}"
			
			begin
		 		Quote.create!(quote_row)
		 	rescue Exception => e  
		 		puts "#{e.message}. Did not add quote: #{quote_row}"
		 		next
		 	end
		end
	end
end
