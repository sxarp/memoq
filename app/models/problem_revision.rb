# == Schema Information
#
# Table name: problem_revisions
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  problem_id :bigint(8)
#

class ProblemRevision < ApplicationRecord
end
