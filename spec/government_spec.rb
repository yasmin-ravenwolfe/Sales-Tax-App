require 'rubygems'
require 'bundler/setup'
require 'rspec'

require_relative '../lib/government'


module SalesTax
  describe Government do 
    let(:government) {Government.new}
    
    describe "#taxable?" do  
       context "the description does not contain a tax keyword" do 
        it "returns true" do 
         
          expect(government.taxable?("foo")).to eq(true)
        end
      end

      context "the description contains a tax-exempt keyword" do
        it "returns false" do 
          
          expect(government.taxable?("box of chocolates")).to eq(false)
        end
      end
    end
  
    describe "#imported?" do 
      context "the description contains the word imported" do 
        it "returns true" do 

          expect(government.imported?("imported box of chocolates")).to eq(true)
        end
      end

      context "the description does not contain the word imported" do 
        it "returns false" do 

          expect(government.imported?(" box of chocolates")).to eq(false)
        end
      end
    end
  end
end
