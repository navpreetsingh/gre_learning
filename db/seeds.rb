# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'yaml'
# Word Roots
word_roots = YAML.load(File.read(Rails.root.join("db", "word_roots.yml")))["word_roots"]

# word_roots = [
# ]

word_roots.each do |wr|   
    file = File.open(Rails.root.join('db', 'error_logs'), 'a')
    begin
        word_root = WordRoot.find_or_create_by(name: wr[0], meaning: wr[1])
        words = wr.last.split(",")
        word_ids = []
        words.each {|word| word_ids << Word.find_or_create_by(name: word.lstrip).id }
        word_root.word_ids = word_ids.uniq
    rescue Exception => e
        file.puts "\n\n"  
        file.puts "Message: \n #{e.message}"  
        file.puts "Backtrace: \n#{e.backtrace.inspect}" 
        file.puts "\n\n"  
        next
    ensure
        file.close
    end
end