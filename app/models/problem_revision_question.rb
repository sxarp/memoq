# == Schema Information
#
# Table name: problem_revision_questions
#
#  id                  :bigint(8)        not null, primary key
#  order               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  problem_revision_id :bigint(8)
#  question_id         :bigint(8)
#

class ProblemRevisionQuestion < ApplicationRecord
end
