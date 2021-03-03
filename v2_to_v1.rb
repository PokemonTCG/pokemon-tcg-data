require 'json'

class Hash
  def compact
    delete_if{|k, v| v.nil? || (v.kind_of?(String) && v.empty?) || (v.kind_of?(Array) && !v.any?) || (v.instance_of?(Hash) && v.compact.empty?)}
  end
end

def sorted_hash(input_hash, key_sort_order)
  new_hash = {}
  key_sort_order.each do |key|
    if input_hash.has_key?(key)
      new_hash[key] = input_hash[key]
    end
  end
  new_hash
end

sort_order = [:id, :name, :imageUrl, :subtype, :supertype, :level, :evolvesFrom, :ability, :ancientTrait, :hp, :retreatCost,
  :convertedRetreatCost, :number, :artist, :rarity, :series, :set, :setCode, :text, :types, :attacks, :weaknesses,
  :resistances, :imageUrlHiRes, :nationalPokedexNumber, :evolvesTo
]

sets = JSON.parse(File.open('sets/en.json').read, :symbolize_names => true)

Dir.glob('cards/en/*.json') do |json_file|
  puts "Converting #{File.basename json_file}..."
  cards_file = File.open(json_file, "r:UTF-8")
  data = cards_file.read
  cards = JSON.parse(data, :symbolize_names => true)
  set = sets.select{|x| x[:id] == File.basename(json_file, '.json')}.first

  v1_cards = []
  cards.each do |card|
    card[:imageUrl] = card[:images][:small]
    card[:subtype] = card[:subtypes].last unless card[:subtypes].nil?
    card[:ability] = card[:abilities].first unless card[:abilities].nil?
    card[:series] = set[:series]
    card[:setCode] = set[:id]
    card[:text] = card[:rules]
    card[:imageUrlHiRes] = card[:images][:large]
    card[:nationalPokedexNumber] = card[:nationalPokedexNumbers].first unless card[:nationalPokedexNumbers].nil?

    v1_cards.push(sorted_hash(card.compact, sort_order))
  end

  output_dir = "cards/en/v1"
  Dir.mkdir(output_dir) unless File.exists?(output_dir)
  File.open("#{output_dir}/#{File.basename json_file}", 'w+') { |file| file.write(JSON.pretty_generate(v1_cards)) }
end

