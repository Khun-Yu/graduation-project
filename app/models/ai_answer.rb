class AiAnswer < ApplicationRecord
  belongs_to :question

  validates :question_id, uniqueness: true
  validates :content, presence: true
end
