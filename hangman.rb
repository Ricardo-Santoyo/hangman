class Game
    attr_reader :word
    @@lives = 4

    def dictonary
        File.readlines('5desk.txt').map(&:chomp)
    end

    def secret_word
        word = dictonary.select {|word| word.length.between?(5,12)}.sample
        word
    end

    def make_slots
        @word.length.times {print"_ "}
    end

    def display
        puts @@lives
        puts ""
        puts ""
        puts ""
        puts make_slots
        puts ""
    end

    def check_guess(guess)
        if @word.include? guess
            start
        else
            @@lives -= 1
            start
        end
    end

    def setup
        puts @word = secret_word
        display
        check_guess(gets.chomp)
    end

    def start
        display
        check_guess(gets.chomp)
    end
end

game = Game.new
game.setup
