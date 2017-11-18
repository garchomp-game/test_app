# 主人公クラス
class Player
  attr_accessor :name, :health_point, :attack

  def initialize
    @name = "主人公"
    @health_point = 100
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
    @health_point = 100
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
=begin

ダメージが３に固定されていたためランダム数にした。
プレイヤーが攻撃したものが何故かプレイヤーにダメージ帰ってきたのでちゃんと相手にダメージを与えるように変更した。
条件分岐を用いて、もしダメージが０以下になったら中断し、モンスター倒れたのにモンスターの攻撃が発動するという謎挙動を解消した。


=end
  def attack_player
    damage = rand(40)
    puts @player.name + "の攻撃！！ %iのダメージ" % damage
    @monster.health_point = @monster.health_point - damage
    if @monster.dead? # どちらかのキャラクターの hp が無くなったかの判定
      puts ""
      puts "----------"
      return true
    else
      return false
    end
  end

  def attack_monster
    damage2 = rand(20)
    puts @monster.name + "の攻撃！！ %iのダメージ" % damage2
    @player.health_point = @player.health_point - damage2
    if @player.dead?
      puts ""
      puts "----------"
      return true
    else
      puts ""
      puts "----------"
    end
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
      puts "主人公 HP:%i, <-> モンスター HP:%i" % [player.health_point, monster.health_point]
      print "ENTERキーを押下すると実行, 3を入力すると終了 > "
      input = gets.chomp.to_i
      if (input == 3)
        exit
      end
      # メソッド変更につきこちらの方も条件分岐をして、ちゃんと０にモンスタの攻撃が出ないようにした
      if battle.attack_player
        break
      elsif battle.attack_monster
        break
      end
    end
    battle.judges
  end

end

game = Game.new
game.start
