class BoxOfBolts < Item
  HEALING_POWER = 20
  def initialize
    super("Box of bolts", 25)
  end

  def feed(unit)
    unit.heal(HEALING_POWER)
  end
end
