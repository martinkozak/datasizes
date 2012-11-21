# encoding: utf-8
# (c) 2012 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils"
require "datasizes/exceptions"

module Datasizes

    ##
    # Magnitudes list.
    # @var [Hash]
    #
    
    MAGNITUDES = {
        nil => 0,
        :K => 1,
        :M => 2,
        :G => 3,
        :T => 4,
    }
    
    ##
    # Contains analyser query.
    # @var [Regexp]
    #
    
    ANALYSER = /^(\d+)([KMGT])?$/u

    ##
    # Converts specification to bytes.
    #
    # @param [String] spec
    # @return [Integer] size in bytes
    #

    def self.to_bytes(spec)
        amount, magnitude = self::analyze_specification(spec)
        return self.count_bytes(amount, magnitude)
    end
    
    ##
    # Counts bytes for given amount and magnitude.
    # 
    # @param [Integer] size  size in bytes
    # @param [Symbol, String] magnitude  magnitude name
    # @return [Integer] size in bytes
    #
    
    def self.count_bytes(amount, magnitude = nil)
        magnitude = magnitude.to_sym if magnitude.string?
        magnitude = self::MAGNITUDES[magnitude]
        return amount * (1024 ** magnitude)
    end
        
    ##
    # Converts given size in bytes to given magnitude.
    #
    # @param [Integer] size  size in bytes
    # @param [Symbol, String] magnitude  magnitude name
    # @return [String] specification
    #
    
    def self.to_magnitude(size, magnitude = nil)
        magnitude = magnitude.to_sym if magnitude.string?
        factor = self::MAGNITUDES[magnitude]
        
        if factor.nil?
            raise Datasizes::InvalidMagnitude::new("Invalid magnitude '#{magnitude}'.")
        end
        
        (size / (1024 ** factor)).to_s + magnitude.to_s
    end
    
    ##
    # Converts given size to nearest reasonable magnitude 
    # specification.
    #
    # @param [Integer] size  size in bytes
    # @return [String] specification
    #
    
    def self.from_bytes(size)
        self::MAGNITUDES.reverse.each_key do |magnitude|
            amount = self.count_bytes(1, magnitude)
            remain = size % amount
            
            if remain == 0
                return (size / amount).to_s + magnitude.to_s
            end
        end
    end
    
    ##
    # Analyzes the given specification.
    #
    # @param [String] spec  specification
    # @return [Array] amount (Integer) and magnitude 
    #   identifier (Symbol)
    #
    
    def self.analyze_specification(spec)
        matches = spec.match(self::ANALYSER)
        
        if matches.nil?
            raise Datasizes::InvalidSpecification
        else
            size = matches[1].to_i 
            if not matches[2].nil?
                magnitude = matches[2].to_sym
            end
            
            return [size, magnitude]
        end
    end
    
end
