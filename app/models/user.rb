class User < ActiveRecord::Base
  has_many :spots, dependent: :destroy
  has_many :comments
  has_one  :profile, dependent: :destroy
  has_many :likes
  has_many :like_spots, through: :likes, source: :spot
  has_many :following_relationships, class_name: "Relationship",
                                     foreign_key: "follower_id",
                                     dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  has_many :follower_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  accepts_nested_attributes_for :profile
  validates :name, length: {maximum: 50}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]

         
  def self.from_omniauth(auth)
    #providerとuidでuserレコードを取得する
    #存在しない場合は、ブロック内のコードを実行して作成する
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      #auth.providerには"twitter"、
      #auth.uidにはtwitterアカウントに基づいた個別のIDが入っている
      #first_or_createメソッドが自動でproviderとuidを設定してくれるので個別設定は必要なし
      user.name = auth.info.nickname #twitterで使用している名前が入る
      user.email = auth.info.email #twitterの場合は入らない
    end
  end
  
  
  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], withOut_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  # Devise の RegistrationsController はリソースを生成する前に self.new_sith_session を呼ぶ
  # つまり、self.new_with_sessionを実装することで、サインアップ前のuserオブジェクトを初期化する
  # ときに session からデータをコピーすることができます。
  # OmniauthCallbacksControllerでsessionに値を設定したので、それをuserオブジェクトにコピーします。
  
  #providerがある場合(Twitter経由で認証した場合)パスワードは要求しないようにする
  def password_required?
    super && provider.blank?
  end
  
  #プロフィールを変更する時に呼ばれる
  def update_with_password(params, *options)
    #パスワードが空の場合
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
  #他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  
  #フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
  
  #あるユーザーをフォローしているかどうか
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  def favorite(user)
    favorite_spots.find_or_create_by(user_id: user.id)
  end

end



# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  provider               :string
#  uid                    :string
#
