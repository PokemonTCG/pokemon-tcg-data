# Pokémon TCG Data

[![Discord](https://img.shields.io/badge/Pokémon%20TCG%20Developers-%237289DA.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/dpsTCvg)
[![Patreon](https://img.shields.io/badge/Patreon-F96854?style=for-the-badge&logo=patreon&logoColor=white)](https://www.patreon.com/bePatron?u=8336557)
[![Ko-Fi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/Z8Z25AVR)


This is the data found within the [Pokémon TCG API](https://pokemontcg.io/). Currently, the raw JSON files for all the card information can be found here.

If you find this data useful, consider donating via one of the links above. All donations are greatly appreciated!

# Downloading the data

The easiest way to stay up to date and interact with the data is via the [Pokémon TCG API](http://pokemontcg.io/) and one of the associated SDKs. Otherwise, feel free to clone this repository or download a zip from the releases.

# Version 1 and 2 Data

Version 1 data is no longer being maintained. The API for V1 will continue to receive new sets until August 1st, 2021. At this time, V1 of the API will be taken offline, and you MUST be using V2. You have a 6 month window to migrate to V2.

If you rely on the V1 data, I have provided a `v2_to_v1.rb` Ruby script that you can run to generate all the json files in v1 format.

To install Ruby: https://www.ruby-lang.org/en/documentation/installation/

You will also need the `json` gem: `gem install json`.

Finally, to run the script:

```
ruby v2_to_v1.rb
```

This will output all of the card data into `/cards/en/v1`.

# Contributing

Please contribute when you see missing and/or incorrect data. I'll try to review all pull requests relatively quickly so that I can push updates at night.

1. Fork it ( https://github.com/[my-github-username]/pokemon-tcg-data/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
