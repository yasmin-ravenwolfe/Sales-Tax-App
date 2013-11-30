class Government

  def taxable?(description)
    description !~ /book|chocolate|headache pills/i
  end

  def imported?(description)
    description =~ /imported/i
  end
end