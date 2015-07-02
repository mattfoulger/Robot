class Robot
  class RobotAlreadyDeadError < StandardError
  end
  class UnattackableEnemy < StandardError
  end

  MAX_WEIGHT = 250
  MAX_HEALTH = 100
  MIN_HEALTH = 0
  attr_reader :items, :health, :position, :attack_points
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @attack_points = 5
    @equipped_weapon = nil
  end

  def move_left
    @position[0] -= 1 
  end

  def move_right
    @position[0] += 1 
  end

  def move_up
    @position[1] += 1 
  end

  def move_down
    @position[1] -= 1 
  end

  def pick_up(item)
    if can_pickup?(item)
      if item.is_a?(Weapon)
        @equipped_weapon = item 
      elsif should_feed?(item)
        item.feed(self)
      end
      @items << item
    end
  end

  def items_weight
    @items.inject(0){|sum,i| sum += i.weight }
  end

  def wound(damage)
    @health -= damage
    if @health < MIN_HEALTH
      @health = MIN_HEALTH
    end
  end

  def heal(healing)
    @health += healing
    if @health > MAX_HEALTH
      @health = MAX_HEALTH 
    end
  end

  def heal!(healing)
    begin
      raise RobotAlreadyDeadError, "A dead robot cannot be healed" if @health <= MIN_HEALTH
      @health += healing
    rescue
      puts "A dead robot cannot be healed"
    end
    if @health > MAX_HEALTH
      @health = MAX_HEALTH
    end
  end

  def attack(enemy)
    unless equipped_weapon
      return unless in_range?(enemy, 1)
      enemy.wound(@attack_points)
    else
      return unless in_range?(enemy, equipped_weapon.range)
      equipped_weapon.hit(enemy)
      if equipped_weapon.empty?
        @equipped_weapon = nil
      end
    end
  end

  def attack!(enemy)
    begin
      raise UnattackableEnemy, "Robots can only attack robots" unless enemy.is_a?(Robot)
      unless @equipped_weapon
        enemy.wound(@attack_points)
      else
        equipped_weapon.hit(enemy)
      end
    rescue
      puts "Robots can only attack robots"
    end
    
  end

  private
    def can_pickup?(item)
      items_weight + item.weight <= MAX_WEIGHT
    end

    def should_feed?(item)
      if item.class.method_defined? :feed
        self.health + item.class::HEALING_POWER <= MAX_HEALTH
      end
    end

    def in_range?(unit, range)
      range_horizontal?(unit, range) && range_vertical?(unit, range)
    end

    def range_horizontal?(unit, range)
      (@position[0] - unit.position[0]).abs <= range
    end

    def range_vertical?(unit, range)
      (@position[1] - unit.position[1]).abs <= range
    end

end
