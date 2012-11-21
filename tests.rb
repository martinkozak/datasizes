#!/usr/bin/env ruby
# encoding: utf-8
# (c) 2012 Martin Kozák (martinkozak@martinkozak.net)

$:.push("./lib")
$:.unshift("./lib")

require "rspec"
require "simplecov"
SimpleCov.start

require "datasizes"
require "datasizes/exceptions"

describe "#to_bytes" do
    specify("bytes") do
        Datasizes::to_bytes("3072").should eq(3072)
    end

    specify("kilobytes") do
        Datasizes::to_bytes("3K").should eq(3 * 1024)
    end
    
    specify("megabytes") do
        Datasizes::to_bytes("3M").should eq(3 * (1024 ** 2))
    end
    
    specify("gigabytes") do
        Datasizes::to_bytes("3G").should eq(3 * (1024 ** 3))
    end
    
    specify("terabytes") do
        Datasizes::to_bytes("3T").should eq(3 * (1024 ** 4))    
    end

    specify("invalid") do
        expect { Datasizes::to_bytes("abcd") }.to raise_error(Datasizes::InvalidSpecification)
    end
end

describe "#to_magnitude" do
    specify("bytes") do
        Datasizes::to_magnitude(3072).should eq('3072')
    end

    specify("kilobytes") do
        Datasizes::to_magnitude(3072, :K).should eq('3K')
    end
    
    specify("megabytes") do
        Datasizes::to_magnitude(3 * (1024 ** 2), :M).should eq('3M')
    end
    
    specify("gigabytes") do
        Datasizes::to_magnitude(3 * (1024 ** 3), :G).should eq('3G')
    end
    
    specify("terabytes") do
        Datasizes::to_magnitude(3 * (1024 ** 4), :T).should eq('3T')
    end
    
    specify("invalid") do
        expect { Datasizes::to_magnitude(3 * (1024 ** 4), :a) }.to raise_error(Datasizes::InvalidMagnitude)
    end
end

describe "#from_bytes" do
    specify("pass to magnitude") do
        Datasizes::from_bytes(30 * (1024 ** 3)).should eq('30G')
    end
    
    specify("pass to bytes") do
        Datasizes::from_bytes(30 * (1024 ** 3) + 1).should eq('32212254721')
    end
end
