# 主人公クラス
class Player
  attr_accessor :name, :health_point, :attack

  def initialize
    @name = "主人公"
    @health_point = 10
    @attack = 5
  end

  def dead?
    @health_point <= 0
  end
end

# モンスタークラス
class Monster
  attr_accessor :name, :health_point, :attack

  def initialize
    @name = "モンスター"
    @health_point = 10
    @attack = 5
  end

  def dead?
    @health_point <= 0
  end
end

# 戦闘クラス
class Battle

  def initialize(player, monster)
    @player = player
    @monster = monster
  end

  def attack
    damage = 3
    puts @player.name + "の攻撃！！ %iのダメージ" % damage
    @player.health_point = @player.health_point - damage

    puts @monster.name + "の攻撃！！ %iのダメージ" % damage
    @monster.health_point = @monster.health_point - damage
    puts ""

    @player.dead? or @monster.dead? # どちらかのキャラクターの hp が無くなったかの判定
  end

  def judges
    if @player.dead? and @monster.dead? # どちらも戦闘不能になった場合
      puts "相打ちになりました…"
    elsif @monster.dead?  # モンスターが戦闘不能になった場合
      puts "主人公が勝ちました！"
    elsif @player.dead? #主人公が戦闘不能になった場合
      puts "モンスターが勝ちました！"
    end
  end
end

# ゲームクラス
class Game

  # ゲーム開始
  def start
    player = Player.new
    monster = Monster.new
    battle = Battle.new(player, monster)
    decision = false
    until decision do
      puts "----------"
      puts "主人公 HP:%i, <-> モンスター HP:%i" % [player.health_point, monster.health_point]
      print "ENTERキーを押下すると実行, 3を入力すると終了 > "
      input = gets.chomp.to_i
      if (input == 3)
        exit
      end
      decision = battle.attack
    end
    battle.judges
  end

end

game = Game.new
game.start
