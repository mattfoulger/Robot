class Battery < Item

  def initialize
    super("Battery", 25)
  end

  def charge(unit)
    unit.charge_shields
  end
end
