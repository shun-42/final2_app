class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  belongs_to :user
  has_many :view_counts, dependent: :destroy


  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validate :score_cannot_change, on: :update
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
     if search == "perfect_match"
        @book = Book.where("title LIKE?", "#{word}")
      elsif search == "forward_match"
        @book = Book.where("title LIKE?", "#{word}%")
      elsif search == "backward_match"
        @book = Book.where("title LIKE?", "%#{word}")
      elsif search == "partial_match"
        @book = Book.where("title LIKE?", "%#{word}%")
      else
        @book = Book.all
      end
  end

  def score_cannot_change
    if score_changed?
        errors.add(:score, "は変更できません")
    end
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_2days_ago, -> { where(created_at: 2.days.ago.all_day) } # 2日前
  scope :created_3days_ago, -> { where(created_at: 3.days.ago.all_day) } # 3日前
  scope :created_4days_ago, -> { where(created_at: 4.days.ago.all_day) } # 4日前
  scope :created_5days_ago, -> { where(created_at: 5.days.ago.all_day) } # 5日前
  scope :created_6days_ago, -> { where(created_at: 6.days.ago.all_day) } # 6日前
  scope :created_this_week, -> { where(created_at: 6.days.ago.beginning_of_day..Time.zone.now.end_of_day) } # 今週
  scope :created_last_week, -> { where(created_at: 13.days.ago.beginning_of_day..7.days.ago.end_of_day) } # 先週

  # 新しい順のスコープを追加
  scope :latest, -> { order(created_at: :desc) }
  # 評価の高い順のスコープを追加
  scope :star_count, -> { order(score: :desc) }
  
end
