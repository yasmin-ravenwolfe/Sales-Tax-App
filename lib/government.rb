class Government

  def taxable?(description)
    description !~ /book|chocolate|chocolates|headache pills/i
  end

  def imported?(description)
    description =~ /|imported|/i
  end
end