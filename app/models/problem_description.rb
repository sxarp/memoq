# == Schema Information
#
# Table name: problem_descriptions
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProblemDescription < ApplicationRecord
  has_many :problem_revisions
end
