class Robot
  class RobotAlreadyDeadError < StandardError
  end
  class UnattackableEnemy < StandardError
  end

  MAX_WEIGHT = 250
  MAX_HEALTH = 100
  MIN_HEALTH = 0
  MAX_SHIELDS = 50
  attr_reader :items, :health, :position, :attack_points, :shields
  attr_accessor :equipped_weapon

  @@robots = []

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @attack_points = 5
    @equipped_weapon = nil
    @shields = 50
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

  def items_weight
    @items.inject(0){|sum,i| sum += i.weight }
  end

  def pick_up(item)
    if can_pickup?(item)
      case item.class.superclass.name
      when "Weapon"
        pick_up_weapon(item)
      when "Item"
        pick_up_item(item)
      end
      @items << item
    end
  end

  def pick_up_weapon(weapon)
    if @equipped_weapon == nil
      @equipped_weapon = weapon 
    end
  end

  def pick_up_item(item)
    if should_feed?(item)
      item.feed(self)
    end
    if should_charge?(item)
      item.charge(self)
    end
  end

  def wound(damage)
    bleed = damage - shield_damage(damage)
    @health -= bleed
    if @health < MIN_HEALTH
      @health = MIN_HEALTH
    end
  end

  def shield_damage(damage)
    # return 0 if shields == 0
    shield_bleed = damage
    if shield_bleed > @shields
      shield_bleed = @shields
    end
    @shields -= shield_bleed
    shield_bleed
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

  def charge_shields
    @shields = MAX_SHIELDS
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

    def should_charge?(item)
      item.is_a?(Battery)
    end

    def in_range?(unit, range)
      Math.sqrt(((@position[0] - unit.position[0]) ** 2) + ((@position[1] - unit.position[1]) ** 2)) <= range
    end
  
  class << self

    def create
      @@robots << Robot.new
      @@robots.last
    end

    def robots
      @@robots
    end

    def robots=(value)
      @@robots = value
    end

    def in_position(x,y)
      @@robots.select { |robot| robot.position == [x,y]}
    end

  end


end
