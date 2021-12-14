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

   #decision_attack_typeメソッドの呼び出し
   attack_type = decision_attack_type

   #calculate_damageメソッドの呼び出し
   damage = calculate_damage(target: monster,attack_type: attack_type)

   #ダメージをHPに反映させる
   cause_damage(target: monster,damage: damage)


   puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  private

  def decision_attack_type
   #0~3の間でランダムに数字が変わる
   attack_num = rand(4)

   #4分の1の確率でcalculate_special_attackを実行
   if attack_num == 0
    puts "必殺攻撃"
    "special_attack"
   else
    puts "通常攻撃"
    "normal_attack"
   end
  end

  #ダメージの計算メソッド
  def calculate_damage(**params)
    target = params[:target]
    attack_type = params[:attack_type]

    if attack_type == "special_attack"
      calculate_special_attack - target.defense
    else
      @offense - target.defense
    end

  end

  #HPにダメージを反映させる
  def cause_damage(**params)
   damage = params[:damage]
   target = params[:target]

   target.hp -= damage
   puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def calculate_special_attack
  #攻撃力が1.5倍
    @offense*SPECIAL_ATTACK_CONSTANT
  end

end

class Monster
  attr_reader :offense, :defense
  attr_accessor :hp, :name

  #必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5
  CALC_HALF_HP = 0.5

  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
    #モンスターが変身したかどうかを判定するフラグ
    @transform_flag = false

    @half_hp = params[:hp]*CALC_HALF_HP
  end

  def attack(brave)
    puts "#{@name}の攻撃"
    if @hp <= @half_hp && @transform_flag == false
      @transform_flag = true
      transform
    end

    damage = @offense - brave.defense
    brave.hp -= damage


   puts "#{brave.name}は#{damage}のダメージを受けた"
   puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end

  #クラス外から呼び出せないようにする
  private

  def transform
    transform_name = "ドラゴン"

    puts <<~EOS
    #{@name}は怒っている
    #{@name}は#{transform_name}に変身した
    EOS

    @offense*=SPECIAL_ATTACK_CONSTANT
    @name = transform_name
  end


end

brave = Brave.new(name:"テリー", hp:500, offense:150, defense:100)
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)



brave.attack(monster)
monster.attack(brave)