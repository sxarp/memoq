# == Schema Information
#
# Table name: problem_revision_questions
#
#  id                  :bigint(8)        not null, primary key
#  order               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  problem_revision_id :bigint(8)        not null
#  question_id         :bigint(8)        not null
#

class ProblemRevisionQuestion < ApplicationRecord
end
