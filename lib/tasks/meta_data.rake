
namespace :meta_data do
    desc "Add new words"
    task :add => :environment do 
        exec "rake db:seed && rake meta_data:fetch && rake meta_data:extract && rake meta_data:update_unextract"
    end

    desc "This task fetch meta data from oxford API!"
    task :fetch => :environment do
        # FetchMetaDataJob.perform_later 'get_all'
        
        require 'meta_data'
        words = Word.where(meta_fetched: false, meaning: nil)
        words.each do |word|
            result = MetaData.get(word.name)
            if(result[:status] == '200')
                puts "Updating word #{word.name}"
                word.update_attributes(meta_data: result[:json], meta_fetched: true)
            end
        end
    end

    desc "This task extract information from the fetched meta data"
    task :extract => :environment do
        require 'meta_data'
        MetaData.extract
    end

    desc "This task update words not found from Oxford Dictionary"
    task :update_unextract => :environment do
        require 'meta_data'
        MetaData.unextracted_words
    end
end  