require 'yaml'

class Game
    attr_accessor :word
    attr_accessor :slots
    attr_accessor :incorrect_guesses
    attr_accessor :lives

    def dictonary
        File.readlines('5desk.txt').map(&:chomp)
    end

    def secret_word
        word = dictonary.select {|word| word.length.between?(5,12)}.sample
        word
    end

    def save_game
        yaml = YAML.dump(self)
        File.open("saved_game", "w") { |file| file.write yaml}
    end

    def load_game
        file = YAML.load(File.read("saved_game"))
        @word = file.word
        @lives = file.lives
        @slots = file.slots
        @incorrect_guesses = file.incorrect_guesses
    end

    def open_save?
        puts "would you like to open a save?(y/n)"
        input = gets.downcase.chomp
        if input == "y"
            load_game
        end
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

    def display
        puts @lives
        puts @incorrect_guesses.rjust(20)
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
            @lives -= 1
            @incorrect_guesses += guess
            gameover?
            turn
        end
    end

    def gameover?
        if @lives == 0
            puts "gameover"
            exit
        end
    end

    def save?
        puts "type save to save game"
        input = gets.downcase.chomp
        if input == "save"
            save_game
            puts "saved!"
        end
    end

    def setup
        @word = secret_word.downcase
        @lives = 4
        make_slots
        @incorrect_guesses = ""
        open_save?
        display
        check_guess(gets.downcase.chomp)
    end

    def turn
        save?
        display
        check_guess(gets.downcase.chomp)
    end
end

game = Game.new
game.setup