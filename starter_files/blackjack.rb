

class Card
    attr_accessor :rank, :suit, :value

    def initialize(rank, suit)
        @rank = rank
        @suit = suit
        @value = value
    end

    def value 
        @value = case @rank
                when :A
                    11
                when 2..10
                    @rank.to_i
                when :J
                    10
                when :Q
                    10
                when :K
                    10
                else
                    nil
                end
    end

    def ==(other_card)
        self.class == other_card.class &&
        rank == other_card.rank &&
        suit == other_card.suit &&
        value == other_card.value
    end

    def greater_than?(other_card)
        self.value > other_card.value
    end
end

class Deck

    SUITS = [ :clubs, :diamonds, :hearts, :spades ]
    RANKS = [ :A, 2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K]
    
    attr_accessor :deck
    def initialize
        @deck = []
        new_deck
    end

    def new_deck
        SUITS.each do |suit|
            RANKS.map do |rank|
                @deck.push (Card.new(rank, suit))
            end
        end 
    end

    def shuffle
        @deck.shuffle!
    end

    def draw
        @deck.shift
    end
    #deletes chosen item from top of deck
    #returns it

    def cards_left
        @deck.length
    end
end

# deck = Deck.new
# deck.shuffle
# 7.times { puts deck.draw.rank }

class Game
    attr_accessor :wallet

    def initialize(wallet)
        @wallet = wallet
    end






wallet = 100

end
