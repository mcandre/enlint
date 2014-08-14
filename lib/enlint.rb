require 'rubygems'
require 'ptools'

require 'version'

DEFAULT_IGNORES = %w(
  .hg/
  .svn/
  .git/
  .git
  .gitignore
  node_modules/
  .vagrant/
  Gemfile.lock
  .exe
  .bin
  .png
  .jpg
  .jpeg
  .svg
  .min.js
  -min.js
)

#
# Note that order is significant;
# Only the earliest file pattern match's rule applies.
#
DEFAULT_RULES = [
  [/\.reg$/, /utf-16/],
  [/.*/, /(utf-8|ascii)/]
]

#
# Parse, model, and print an encoding.
# Distinct from Ruby's built-in Encoding class.
#
class AnEncoding
  attr_accessor :filename, :empty, :encoding

  def self.parse(filename, file_line)
    match = file_line.match(/^.+\:\s+(.+);\s+charset=(.+)$/)

    empty = match[1] == 'inode/x-empty'
    encoding = match[2]

    AnEncoding.new(filename, empty, encoding)
  end

  def initialize(filename, empty, encoding)
    @filename = filename
    @empty = empty
    @encoding = encoding
  end

  def violate?(rules)
    # Ignore empty files, which are considered binary.
    if @empty then
      false
    else
      preferred = rules.select { |rule| filename =~ rule.first }.first[1]

      if ! (encoding =~ preferred) then
        [encoding, preferred]
      else
        false
      end
    end
  end

  def to_s(encoding_difference = false)
    if encoding_difference then
      "#{@filename}: observed #{encoding_difference[0]} preferred: #{encoding_difference[1].inspect}"
    else
      "#{@filename}: #{@encoding}"
    end
  end
end

def self.recursive_list(directory, ignores = DEFAULT_IGNORES)
  Find.find(directory).reject do |f|
    File.directory?(f) ||
    ignores.any? { |ignore| f =~ /#{ignore}/ } ||
    File.binary?(f)
  end
end

def self.check(filename, rules = DEFAULT_RULES)
  line = `file -i #{filename} 2>&1`

  encoding = AnEncoding.parse(filename, line)

  encoding_difference = encoding.violate?(rules)

  if encoding_difference then
    puts encoding.to_s(encoding_difference)
  end
end
