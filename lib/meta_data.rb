require 'uri'
require 'net/http'
require 'yaml'

class MetaData
    @@URL = "https://od-api.oxforddictionaries.com/api/v1/entries/en/"
    # @@HEADERS = {
    #     Accept: 'application/json',
    #     app_id: 'f4537681',
    #     app_key: 'c509d69847c220a2d9bd39e8db1a5fe4'
    # }
    class << self
        def get(word)
            begin
                # response = RestClient.get @@URL + word, @@HEADERS
                url = URI("https://od-api.oxforddictionaries.com/api/v1/entries/en/" + word)
                http = Net::HTTP.new(url.host, url.port)
                http.use_ssl = true
                http.verify_mode = OpenSSL::SSL::VERIFY_NONE

                request = Net::HTTP::Get.new(url)
                request["Accept"] = "application/json"
                request["app_id"] = "f4537681"
                request["app_key"] = 'c509d69847c220a2d9bd39e8db1a5fe4'

                response = http.request(request)
                output = {
                    status: response.code,
                    json: response.code == '200' ? JSON.parse(response.body) : nil
                }
            rescue Exception => e
                puts "\n\n"  
                puts "Message: \n #{e.message}"  
                puts "Backtrace: \n#{e.backtrace.inspect}" 
                output = {
                    status: 500
                }
            end
        end

        def extract
            Word.where(meta_fetched: true, meaning: nil).map do |word|
            # Word.where(name: "abandon").map do |word|
                speech = nil
                meaning = nil
                sentence = nil
                additional_info = []
                meta = word.meta_data["results"].first["lexicalEntries"]
                begin
                    meta.each do |chunk|
                        pronunciations = chunk["pronunciations"].nil? ? nil : chunk["pronunciations"].first
                        data = {
                            speech: chunk["lexicalCategory"],
                            entries: []
                        }
                        if pronunciations
                            data[:phonetic_spelling] = pronunciations["phoneticSpelling"]
                            data[:audio_file] = pronunciations["audioFile"]
                        end
                        speech = chunk["lexicalCategory"] if speech.nil?
                        chunk["entries"].each do |entry| 
                            senses = entry["senses"] || []
                            senses.each do |sense|
                                definitions = sense["definitions"].nil? ? nil : sense["definitions"].join(", ").sub(";",",")
                                entry = {
                                    meaning: definitions,
                                    sentence: []
                                }
                                meaning = definitions if meaning.nil?
                                # byebug
                                (sense["examples"]||[]).each do |example|
                                    # byebug
                                    entry[:sentence] << example["text"]
                                    sentence = example["text"] if sentence.nil?
                                end
                                data[:entries] << entry
                            end
                        end 
                        additional_info << data
                    end
                    # byebug
                    word.update_attributes(meaning: meaning, sentence: sentence, speech: speech, additional_info: additional_info)
                rescue StandardError => e 
                    puts "\n\n"  
                    puts "Message: \n #{e.message}"  
                    puts "Backtrace: \n#{e.backtrace.inspect}" 
                    output = {
                        status: 500
                    }
                end     
            end
        end

        def unextracted_words
            unextracted_words = YAML.load(File.read(Rails.root.join("lib", "unextracted_words.yml")))["unextracted_words"]
            unextracted_words.each do |unextracted_word|
                begin
                    word = Word.find_by(name: unextracted_word["name"])
                    raise "#{unextracted_word['name']} not found" unless word
                    word.update_attributes(unextracted_word)
                rescue StandardError => e 
                    puts "\n\n"  
                    puts "Message: \n #{e.message}"  
                    puts "Backtrace: \n#{e.backtrace.inspect}"
                end 
            end
        end
    end
end


# "somnambulist", "amphibolous", "act deed", "cardialgia", "alter ego", "ambiparous", "amphibolic", "amphorous", "analyze", "anacephalize", "andromania", "pussilanimaous", "archeology", "artifact", "articylate", "aurist", "bedaud", "beratebereave", "bona fide", "bonify", "anticulate", "exceptioable", "circumfluous", "declamatio", "acclamtion", "incrase", "dicate", "malendiction", "envolop", "equestrain", "ergatocracy", "facient", "bonafide", "malafide", "filaceous", "filate", "filiferous", "conflagrate", "flourescent", "altruist", "bibliomaniac", "inductee", "egoist", "antenuptial"

# curl -X GET --header 'Accept: application/json' --header 'app_id: f4537681' --header 'app_key: c509d69847c220a2d9bd39e8db1a5fe4' 'https://od-api.oxforddictionaries.com/api/v1/entries/en/abandon'


# response = RestClient::Request.execute(
#     method: :get,
#     url: "https://od-api.oxforddictionaries.com/api/v1/entries/en/abandon",
#     headers: {
#         Accept: "application/json",
#         app_id: "f4537681",
#         app_key: "c509d69847c220a2d9bd39e8db1a5fe4"
#     },
#     :verify_ssl       =>  OpenSSL::SSL::VERIFY_NONE
# )



# require 'uri'
# require 'net/http'

# url = URI("https://od-api.oxforddictionaries.com/api/v1/entries/en/abandon")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# request = Net::HTTP::Get.new(url)
# request["app_id"] = "f4537681"
# request["app_key"] = 'c509d69847c220a2d9bd39e8db1a5fe4'

# response = http.request(request)