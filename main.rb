class Brave
  attr_reader :name, :offense, :defense
  attr_accessor :hp

  #必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5

  #new演算子から渡された引数を受け取る
  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

  # 攻撃処理を実装するメソッド
  def attack(monster)
   puts "#{@name}の攻撃"

   #0~3の間でランダムに数字が変わる
   attack_num = rand(4)

   #4分の1の確率でcalculate_special_attackを実行
   if attack_num == 0
    puts "必殺攻撃"
    damage = calculate_special_attack - monster.defense
   else
    puts "通常攻撃"
    damage = @offense - monster.defense
   end

   #自己代入:monster.hpからdamageを引いた値をmonster.hpに代入
   monster.hp -= damage

   puts "#{monster.name}は#{damage}のダメージを受けた"
   puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  def calculate_special_attack
  #攻撃力が1.5倍
    @offense*SPECIAL_ATTACK_CONSTANT
  end

end

class Monster
  attr_reader :name, :offense, :defense
  attr_accessor :hp

  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

end

brave = Brave.new(name:"テリー", hp:500, offense:150, defense:100)
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

# puts <<~TEXT
# NAME:#{brave.name}
# HP:#{brave.hp}
# OFFENSE:#{brave.offense}
# DEFENSE:#{brave.defense}
# TEXT

# brave.hp -= 30
puts "#{brave.name}はダメージを受けた!残りHPは#{brave.hp}だ"


brave.attack(monster)
