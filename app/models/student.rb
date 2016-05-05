class Student < ActiveRecord::Base
	has_many :hours, dependent: :destroy
end
