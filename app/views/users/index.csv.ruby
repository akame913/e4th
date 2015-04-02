require 'csv' # initializersとかに書いたほうがいいかも

CSV.generate do |csv|
  cols = {
    'ID'             => ->(u){ u.id },
    '登録名'         => ->(u){ u.name },
    '姓'             => ->(u){ u.family },
    '名'             => ->(u){ u.given},
    '新姓'           => ->(u){ u.maiden },
    '郵便番号'       => ->(u){ u.pobox },
    '都道府県'       => ->(u){ u.region },
    '市区'           => ->(u){ u.city },
    '町村番地・ビル' => ->(u){ u.street },
    '電話番号'       => ->(u){ u.tel },
    '携帯番号'       => ->(u){ u.mobile },
    '備考'           => ->(u){ u.notes },
    'メールアドレス' => ->(u){ u.email },
    '管理権限'       => ->(u){ u.admin },
    'グループ'       => ->(u){ u.group_id }
  }

  # header
  csv << cols.keys

  # body
  @users.each do |user|
    csv << cols.map{|k, col| col.call(user)}
  end
end
