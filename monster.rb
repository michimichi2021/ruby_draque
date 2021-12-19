require'./character'

class Monster < Character
  SPECIAL_ATTACK_CONSTANT = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )

    @transform_flag = false
    @half_hp = params[:hp] * CALC_HALF_HP
  end

  def attack(brave)
    if @hp <= @half_hp && @transform_flag == false
      @transform_flag = true
      transform
    end

    damage = calculate_damage(brave)
    cause_damage(target:brave, damage: damage)

    attack_message
    # puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end

  private

  def calculate_damage(target)
    @offense - target.defense
  end

  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage
    target.hp = 0 if target.hp < 0

    # puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def transform
    transform_name = "ドラゴン"

    # puts <<~EOS
    # #{@name}は怒っている
    # #{@name}は#{transform_name}に変身した
    # EOS

    @offense *= SPECIAL_ATTACK_CONSTANT
    @name = transform_name
  end


end