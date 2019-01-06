# == Schema Information
#
# Table name: choices
#
#  id          :bigint(8)        not null, primary key
#  order       :integer
#  check       :boolean
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint(8)
#

class Choice < ApplicationRecord
end
