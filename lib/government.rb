module SalesTax
  # Determines taxable and imported status.
  # 
  class Government

    # Returns true if description does not include the specified words.
    # Returns false if description includes the specified words.
    # 
    def taxable?(description)
      if description =~ /book|chocolate|chocolates|headache pills/i
        false
      else
        true
      end
    end

    # Returns true if description includes "imported".
    # Returns false if description does not include "imported".
    # 
    def imported?(description)
      if description =~ /imported/i
        true
      else
        false
      end
    end
  end
end