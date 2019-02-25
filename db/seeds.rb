# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'yaml'
# Word Roots
# word_roots = YAML.load(File.read(Rails.root.join("db", "word_roots.yml")))["word_roots"]

word_roots = [
    [
        'chron', 'time', 'chronometer, chronological, anachronism, chronicle, chronic, synchronize'
    ],
]

word_roots.each do |wr|
    begin
        word_root = WordRoot.find_or_create_by(name: wr[0], meaning: wr[1])
        words = wr.last.split(",")
        puts "Words: #{words}"
        words.each do |word|
            wordd = word_root.words.new(name: word.lstrip)
            unless wordd.save
                byebug
                puts "#{word} not saved, Message: #{wordd.errors.messages}" 
            end
        end
    rescue Exception => e
        puts "\n\n"  
        puts "Message: \n #{e.message}"  
        puts "Backtrace: \n#{e.backtrace.inspect}" 
        next
    end
end