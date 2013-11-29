require_relative '../taxquestion.rb'

describe Item do
  
  
  describe '.initialize' do
    it 'sets @name, @price, @taxable, and @imported' do

      item = Item.new('foo', 10.0)
      expect(item.name).to eq('foo')
      expect(item.price).to eq(10.0)
      expect(item.taxable).to eq(false)
      expect(item.imported).to eq(false)
    end
  end

  describe '#exempt_domestic?' do
    context 'when item is tax-exempt and non-imported' do
      it 'should return true' do 
        
        item = Item.new('foo', 10.0)
        expect(item.exempt_domestic?).to eq(true)
      end
    end
  end

  describe '#exempt_imported?' do
    context 'when item is tax-exempt and imported' do
      it 'should return true' do 
        
        item = Item.new('foo', 10.0, false, true)
        expect(item.exempt_imported?).to eq(true)
      end
    end
  end


  describe '#taxable_domestic?' do
    context 'when item is taxed and non-imported' do
      it 'should return true' do 
        
        item = Item.new('foo', 10.0, true, false)
        expect(item.taxable_domestic?).to eq(true)
      end
    end
  end

  describe '#taxable_imported?' do
    context 'when item is taxed and imported' do
      it 'should return true' do 
        
        item = Item.new('foo', 10.0, true, true)
        expect(item.taxable_imported?).to eq(true)
      end
    end
  end


end