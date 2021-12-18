class GamesController

  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  #バトルの処理
  def battle(**params)
    brave = params[:brave]
    monster = params[:monster]
    loop do
      brave.attack( monster )
      break if battle_end?( monster )
      monster.attack( brave )
      break if battle_end?( brave )
    end

    #勇者の勝敗によってメッセージを変える
    if battle_result( brave )
      result = calculate_of_exp_and_gold( monster )
      puts "#{ brave.name }はたたかいに勝った"
      puts "#{ result[:exp] }の経験値と#{ result[:gold] }ゴールドを獲得した"
    else
      puts "#{ brave.name }はたたかいに負けた"
      puts "目の前が真っ暗になった"
    end
  end

  private

  #バトル終了の判定
  def battle_end?( character )
    character.hp <= 0
  end

  #勇者の勝利判定
  def battle_result( brave )
    brave.hp > 0
  end

  #経験値とゴールドの計算
  def calculate_of_exp_and_gold( monster )
    exp = ( monster.offense + monster.defense ) * EXP_CONSTANT
    gold = ( monster.offense + monster.defense ) * GOLD_CONSTANT
    result = {exp: exp,gold: gold }
    result
  end

end