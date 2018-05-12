require 'pry'

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
                    @rank
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
    attr_accessor :wallet, :hand, :shoe

    def initialize(wallet)
        @wallet = wallet
        @shoe = Deck.new
            @shoe.shuffle
        @hand = []
    end

    def bet
        @wallet > 9 ? (puts "You have $#{@wallet} and bet $10.") : (puts "You are out of money.")
    end

    def new_hand
        2.times { @hand.push(@shoe.draw) }
        total = @hand[0].value + @hand[1].value
        puts "You have a #{hand[0].rank} and a #{hand[1].rank} in your hand. Your total is #{total}."
    end
    
    def analyze_total
        if total > 21 && @hand.include?
            puts "You bust!"
        elsif total > 


    def play_again

    end

    def run

    end


end

play = Game.new(100)
# play.run
# shoe = Deck.new
# shoe.shuffle
puts "Hello and welcome to the game of blackjack! Let's begin.\n\n"
play.bet
play.new_hand
