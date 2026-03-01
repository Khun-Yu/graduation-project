class Question < ApplicationRecord
  belongs_to :user
  has_one :ai_answer, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }
  validates :content, presence: true, length: { maximum: 5000 }

  scope :recent, -> { order(created_at: :desc) }
  scope :search_by_keyword, ->(keyword) {
    where("title LIKE :q OR content LIKE :q", q: "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }
end
