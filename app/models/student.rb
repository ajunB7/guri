class Student < ActiveRecord::Base
	has_many :hours, dependent: :destroy
	has_many :paidfees, dependent: :destroy
end
