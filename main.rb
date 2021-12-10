class Brave
  #attr_readerの記述でゲッターを省略することができる
  attr_reader :name, :offense, :defense
  #セッターゲッターを一括定義
  attr_accessor :hp

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

   damage = @offense - monster.defense

   #自己代入:monster.hpからdamageを引いた値をmonster.hpに代入
   monster.hp -= damage

   puts "#{monster.name}は#{damage}のダメージを受けた"
   puts "#{monster.name}の残りHPは#{monster.hp}だ"
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

puts <<~TEXT
NAME:#{brave.name}
HP:#{brave.hp}
OFFENSE:#{brave.offense}
DEFENSE:#{brave.defense}
TEXT

brave.hp -= 30
puts "#{brave.name}はダメージを受けた!残りHPは#{brave.hp}だ"

monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)
brave.attack(monster)
