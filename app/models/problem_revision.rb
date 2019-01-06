# == Schema Information
#
# Table name: problem_revisions
#
#  id                     :bigint(8)        not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  problem_id             :bigint(8)        not null
#  problem_description_id :bigint(8)        not null
#

class ProblemRevision < ApplicationRecord
  belongs_to :problem
  has_many :questions, through: :problem_revision_questions
  belongs_to :problem_description
  has_many :problem_revision_questions
end
