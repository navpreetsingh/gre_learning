# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Word Roots
word_roots = [
    [
        'andros', 'man', 'philander, polyandry, andromania, misandrist, gynandrous, androgynous'
    ],
    [
        'anim', 'mind, soul', 'animadvert, unanimous, magnanimity, equanimity, animosity, pussilanimaous'
    ],
    [
        'ann, enn', 'year', 'annuity, biennial, perennial, annual'
    ],
    [
        'ante', 'before, in front of', 'antediluvian, antecedent, antedate, antenuptial, antetype'
    ],
    [
        'anthrop', 'human being', 'anthropology, misanthrope, philanthropy, anthropocentric'
    ],
    [
        'anti', 'opposed, against', 'antidote, antimony, antipathy, antithesis'
    ],
    [
        'apo', 'away, from', 'apocrypha, apoplexy, apostasy, apostle'
    ],
    [
        'apt, ept', 'fit', 'aptitude, adapt, apt, ineptitude'
    ],
    [
        'aqua', 'water', 'aqueduct, aquatic, aquamarine'
    ],
    [
        'arbit', 'judge', 'arbiter, arbitrary, arbitrator'
    ],
    [
        'arch', 'first', 'archetype, archeology'
    ],
    [
        'archy', 'govern, rule', 'oligarchy, monarchy, anarchy, matriarchy'
    ],
    [
        'arm', 'arm, weapon', 'army, armature, disarm'
    ],
    [
        'art', 'skill, a fitting together', 'artisan, artifact, articylate'
    ]
]


word_roots.each do |wr|
    begin
        word_root = WordRoot.find_or_create_by(name: wr[0], meaning: wr[1])
        words = wr.last.split(",")
        puts "Words: #{words}"
        words.each do |word|
            word_root.words.create(name: word.lstrip)
        end
    rescue Exception => e
        puts "\n\n"  
        puts "Message: \n #{e.message}"  
        puts "Backtrace: \n#{e.backtrace.inspect}" 
        next
    end
end