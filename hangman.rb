class Game
    attr_reader :word
    attr_reader :slots
    @@lives = 4

    def dictonary
        File.readlines('5desk.txt').map(&:chomp)
    end

    def secret_word
        word = dictonary.select {|word| word.length.between?(5,12)}.sample
        word
    end

    def make_slots
        word_length = @word.length
        slots = []
        until word_length == 0
            slots[word_length - 1] = "_ "
            word_length -= 1
        end
        @slots = slots
    end

    def update_slots(guess)
        @word.chars.each_with_index do |letter, index|
            if letter == guess
                @slots[index] = guess
            end
        end
    end

    def incorrect_guesses
    end

    def display
        puts @@lives
        puts ""
        puts ""
        puts ""
        puts @slots.join("") #aligns the slots horizontally
        puts ""
    end

    def check_guess(guess)
        if @word.include? guess
            update_slots(guess)
            turn
        else
            @@lives -= 1
            turn
        end
    end

    def setup
        puts @word = secret_word.downcase
        make_slots
        display
        check_guess(gets.downcase.chomp)
    end

    def turn
        display
        check_guess(gets.downcase.chomp)
    end
end

game = Game.new
game.setup