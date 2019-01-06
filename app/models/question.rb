# == Schema Information
#
# Table name: questions
#
#  id          :bigint(8)        not null, primary key
#  description :text(65535)
#  explanation :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Question < ApplicationRecord
end
