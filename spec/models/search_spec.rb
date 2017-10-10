require 'rails_helper'

RSpec.describe Search do
  attr_reader :res

  before(:each) do
    @res = {"results"=>
              [{"lexicalEntries"=>
                 [{"entries"=>
                    [{"senses"=>
                       [{"definitions"=> ["a tool with a heavy metal head mounted at right angles at the end of a handle, used for jobs such as breaking things and driving in nails."],
                         "subsenses"=>
                          [{"definitions"=>["a machine with a metal block for giving a heavy blow to something."]},
                           {"definitions"=>["an auctioneer's gavel, tapped to indicate a sale."], "id"=>"m_en_gbus0447670.011"},
                           {"definitions"=> ["a part of a mechanism that hits another part to make it work, such as one exploding the charge in a gun or one striking the strings of a piano."]}]},
                        {"definitions"=>["a metal ball of about 7 kg attached to a wire for throwing in an athletic contest."],
                         "subsenses"=>
                          [{"definitions"=>["the sport of throwing a hammer."]}]}
                        ]}
                      ]},
                  {"entries"=>
                    [{"senses"=>
                       [{"definitions"=>["hit or beat (something) repeatedly with a hammer or similar object"],
                         "subsenses"=>
                          [{"definitions"=>["strike or knock at or on something violently with one's hand or with a hammer or other object"]},
                           {"definitions"=>["work hard and persistently"]},
                           {"definitions"=>["inculcate something forcefully or repeatedly"]}]},
                        {"definitions"=>["attack or criticize forcefully and relentlessly"],
                         "subsenses"=>
                          [{"definitions"=>["utterly defeat in a game or contest"]}]},
                        {"definitions"=>["beat down the price of (a stock)"]},
                        {"definitions"=>["declare (a person or company) a defaulter"]}]}],
                   },
                  {"entries"=>
                    [{"senses"=>
                       [{"definitions"=>["a British film company founded in 1948, known especially for its horror films."],
                         "subsenses"=>
                          [{"definitions"=>["a film produced by Hammer Film Productions"]}]}],
                    }]
                  }]
                }]
              }
  end

  context '.find_word' do
    it 'returns a list of definitions' do
      VCR.use_cassette('Search_find_word') do
        defs = Search.find_word('hammer')
        expect(defs).to be_a Array
        expect(defs.first).to be_a String
      end
    end
  end

  context '.build_defs' do
    it 'returns a list of the primary definitions' do
      defs = Search.build_defs(res)
      expect(defs).to be_a Array
      expect(defs.first).to be_a String
      expect(defs.count).to eq 7
    end
  end

  context '.parse_results' do
    it 'returns a list of all primary definitions' do
      defs = Search.parse_results(res)
      expect(defs).to be_a Array
      expect(defs.first).to be_a Array
      expect(defs.flatten.first).to be_a String
      expect(defs.flatten.count).to eq 7
    end
  end

  context '.parse_entries' do
    it 'finds and returns a list of lists of definitions' do
      lex_entry = res["results"][0]["lexicalEntries"][0]
      defs = Search.parse_entries(lex_entry)
      expect(defs).to be_a Array
      expect(defs.first).to be_a Array
      expect(defs.flatten.first).to be_a String
      expect(defs.flatten.count).to eq 2
    end
  end

  context '.find_defs' do
    it 'finds and returns the primary definitions' do
      entry = res["results"][0]["lexicalEntries"][0]["entries"][0]
      defs = Search.find_defs(entry)
      expect(defs).to be_a Array
      expect(defs.first).to be_a Array
      expect(defs.first.first).to be_a String
      expect(defs.count).to eq 2
    end
  end
end
