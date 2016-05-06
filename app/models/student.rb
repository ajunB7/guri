class Student < ActiveRecord::Base
  	has_many :extrafees
	has_many :hours, dependent: :destroy
	has_many :paidfees, dependent: :destroy

	validates :name, presence: true
	validates :fee, presence: true
end
