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

    attack_message(target:brave)
    #damage_messageを呼び出す
    damage_message(target: brave,damage: damage)
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
  end

  def transform
    transform_name = "ドラゴン"

    #transform_messsageを呼び出し
    transform_message(origin_name: @name,transform_name: transform_name)

    @offense *= SPECIAL_ATTACK_CONSTANT
    @name = transform_name
  end


end