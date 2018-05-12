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
    attr_accessor :wallet, :hand, :shoe, :total, :d_hand, :d_total

    def initialize(wallet)
        @wallet = wallet
        @shoe = Deck.new
            @shoe.shuffle
        @hand = []
        @total = 0
        @d_hand = []
        @d_total = 0
    end

    def bet
        @wallet > 9 ? (puts "You have $#{@wallet} and bet $10.") : (puts "You are out of money.")
    end

    def total_result
        ranks = @hand.map { |y| y.rank }
        puts "You have #{ranks.join(", ")} in your hand. Your total is #{@total}."
    end
    
    def ace_value
        if @total > 21 && @hand.detect { |x| x.value == 11 }
            ace = @hand.detect { |x| x.value == 11 }
            ace.value = 1
            @total = 0
            @total = @hand.inject(0){ |sum,x| sum + x.value }
        end
    end

    def analyze_total
        ace_value
        if @total > 21
            total_result
            puts "You bust!\n\n----\n\n"
            pay_ten
            # any key for next round
        else 
            total_result
            get_input
        end
    end

    def new_hand
        2.times { @hand.push(@shoe.draw) }
        @total = @hand.inject(0){ |sum,x| sum + x.value }
        analyze_total
    end

    def hit
        @hand.push(@shoe.draw)
        @total = 0
        @total = @hand.inject(0){ |sum,x| sum + x.value }
        analyze_total
    end
    
    def get_input
        # loop until you get a good answer and return
        while true
            puts "Do you want to (h)it or (s)tand? "
            answer = gets.chomp.downcase
            if answer[0] == "h"
                print "You hit."
                hit
                return
            elsif answer[0] == "s"
                print "You stand. Your total is #{@total}.\n"
                dealer
                return
            else
                puts "That is not a valid answer!"
            end
        end
    end

    def dealer_hit
        puts "The dealer hits."
        @d_hand.push(@shoe.draw)
            @d_total = 0
            @d_total = @d_hand.inject(0){ |sum,x| sum + x.value }
        dealer_analyze
    end

    def round_result
        if @total > @d_total
            puts "You win!\n\n----\n\n"
            earn_ten
            return
        elsif @total < @d_total
            puts "You lose!\n\n----\n\n"
            pay_ten
            return
        else
            puts "It's a tie!\n\n----\n\n"
            new_round
            return
        end
    end

    def dealer_analyze
        if @d_total > 21 && @d_hand.include?(:A)
            @d_total = @d_total - 10
        elsif @d_total > 21
            puts "The dealer's total is #{@d_total}. You win!\n\n----\n\n"
            earn_ten
            return
        elsif @d_total > 17
            puts "The dealer stands. The dealer has a total of #{@d_total}."
            round_result
        else
            dealer_hit
        end
    end

    def dealer
        2.times { @d_hand.push(@shoe.draw) }
        @d_total = @d_hand.inject(0){ |sum,x| sum + x.value }
        dealer_analyze 
    end

    def pay_ten
        @wallet = @wallet - 10
        new_round
    end

    def earn_ten
        @wallet = @wallet + 10
        new_round
    end

    def new_round
        @hand = []
        @total = 0
        @d_hand = []
        @d_total = 0
        @shoe = Deck.new
            @shoe.shuffle
    end

    # def play_again

    # end

    # def run

    # end

    def run_game
        puts "Hello and welcome to the game of blackjack! Let's begin.\n\n"
        while @wallet > 9
            bet
            new_hand
        end
    end

end

play = Game.new(100)
play.run_game