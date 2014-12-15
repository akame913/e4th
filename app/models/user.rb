# encoding: utf-8
#require 'csv'
class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
  before_create :create_remember_token
    
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # to_csvメソッドを追加する
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        # SJISで出す必要がなければmapはいらない。コラム全出力
        csv << user.attributes.values_at(*column_names).map{|v| v.to_s.encode('Shift_JIS', undef: :replace, replace: '')}
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      user = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      user.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      user.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "family", "given", "maiden", "pobox", "region", "city", "street", "tel", "mobile", "notes", "email", "admin", "password", "password_confirmation"]
  end
    
  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
