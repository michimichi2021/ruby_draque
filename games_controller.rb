class GamesController

  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  #バトルの処理
  def battle(**params)
    #build_charactersを呼び出し
    build_characters(params)

    loop do
      @brave.attack( @monster )
      break if battle_end?
      @monster.attack( @brave )
      break if battle_end?
    end

    battle_judgment
  end

  private

  def build_characters(**params)
    # 勇者クラス、モンスタークラスそれぞれのインスタンスをインスタンス変数に代入
    @brave = params[:brave]
    @monster = params[:monster]
  end

  def battle_end?
    # 勇者かモンスター、どちらかのHPが0になったらバトルが終了する
    @brave.hp <= 0 || @monster.hp <= 0
  end

  def battle_win?
    # インスタンス変数に変更
    @brave.hp > 0
  end

  def battle_judgment
    if battle_win?
      result = calculate_of_exp_and_gold
      puts "#{ @brave.name }はたたかいに勝った"
      puts "#{ result[:exp] }の経験値と#{ result[:gold] }ゴールドを獲得した"
    else
      puts "#{ @brave.name }はたたかいに負けた"
      puts "目の前が真っ暗になった"
    end
  end

  def calculate_of_exp_and_gold
    exp = ( @monster.offense + @monster.defense ) * EXP_CONSTANT
    gold = ( @monster.offense + @monster.defense ) * GOLD_CONSTANT
    result = {exp: exp,gold: gold }
    result
  end

end