require'./character'

class Monster < Character
  # attr_reader :offense, :defense
  # attr_accessor :hp, :name

  SPECIAL_ATTACK_CONSTANT = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    # キャラクタークラスのinitializeメソッドに処理を渡す
    # 通常のメソッドと同様に引数を渡すことができる
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )

    # 親クラスで定義していない処理はそのまま残す
    @transform_flag = false
    @half_hp = params[:hp] * CALC_HALF_HP
  end

  def attack(brave)
    if @hp <= @half_hp && @transform_flag == false
      @transform_flag = true
      transform
    end

    puts "#{@name}の攻撃"

    damage = calculate_damage(brave)
    cause_damage(target:brave, damage: damage)

    puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end

  private

  def calculate_damage(target)
    @offense - target.defense
  end

  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage

    #もしターゲットのHPがマイナスになるなら0を代入
    target.hp = 0 if target.hp < 0

    puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def transform
    transform_name = "ドラゴン"

    puts <<~EOS
    #{@name}は怒っている
    #{@name}は#{transform_name}に変身した
    EOS

    @offense *= SPECIAL_ATTACK_CONSTANT
    @name = transform_name
  end


end