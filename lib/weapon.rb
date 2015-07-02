class Weapon < Item

  attr_reader :name, :weight, :damage, :range, :ammunition

  def initialize(name, weight, damage, range = 1)
    super(name, weight)
    @damage = damage
    @range = range
    @ammunition = -1
  end

  def hit(enemy)
    enemy.wound(damage)
    @ammunition -= 1 
  end

  def empty?
    @ammunition == 0
  end

end