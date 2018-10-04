# == Schema Information
#
# Table name: articles
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  status     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Article < ApplicationRecord
end
