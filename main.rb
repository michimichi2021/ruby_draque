class Brave
  #attr_readerの記述でゲッターを省略することができる
  attr_reader :name, :offense, :defense
  #セッターゲッターを一括定義
  attr_accessor :hp

  #new演算子から渡された引数を受け取る
  def initialize(**params)
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