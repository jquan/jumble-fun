#!/usr/bin/ruby
require 'set'

DICTIONARY_FILE = 'words.txt'
@dict = Set.new

def jumble(input)
    do_jumble("", input.each_char.sort);
end

def do_jumble(prefix, input)
    last = ''
    input.each_with_index do |c,idx|
        next if c == last # skip repeat letters
        last = c
        rest = input.dup
        rest.slice!(idx) 
        do_jumble(prefix+c, rest)
    end
    puts prefix if is_word?(prefix)
end

def is_word?(word)
    @dict.include?(word)
end

def load(dict_file)
    File.readlines(dict_file).each do |line|
        @dict.add(line.strip) if line.ascii_only?
    end
end

if ARGV.length == 0 or ARGV.length > 1 then
    puts "usage #{$0} word"
    exit 1
end

load(DICTIONARY_FILE)
jumble(ARGV[0])
