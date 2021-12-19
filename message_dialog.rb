module MessageDialog
  def attack_message(**params)
    attack_type = params[:attack_type]

    puts "#{@name}の攻撃"
    puts "必殺攻撃" if attack_type == "special_attack"
  end

  #damage_messageの実装
  def damage_message(**params)
    target = params[:target]
    damage = params[:damage]

    puts <<~EOS
    #{target.name}は#{damage}のダメージを受けた
    #{target.name}の残りHPは#{target.hp}だ
    EOS
  end

  #バトルが終了した時のメッセージ
  def end_message
  end
end