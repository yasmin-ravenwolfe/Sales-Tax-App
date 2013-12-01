module SalesTax
  class Government

    def taxable?(description)
      if description !~ /book|chocolate|chocolates|headache pills/i
        true
      else
        false
      end
    end

    def imported?(description)
      if description =~ /imported/i
        true
      else
        false
      end
    end
  end
end