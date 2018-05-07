class Tweet < ApplicationRecord

	before_validation :link_check, on: :create
	after_validation :apply_link, on: :create

	belongs_to :user

	has_many :tweet_tags
	has_many :tags, through: :tweet_tags

	validates :message, presence: true, length: { maximum: 200, too_long: "more than 200 characters. Ain't Nobody Got Time Fa That!"}

	private

	def apply_link
		array = self.message.split
		index = array.map { |x| x.include?("http")}.index(true)

		if index
			url = array[index]
			array[index] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
		end

		self.message = array.join(" ")

	end

	def link_check
		if self.message.include?("http://")
			check = true
		elsif self.message.include?("https://")
			check = true
		else
			check = false
		end
		if check == true
			array = self.message.split
			index = array.map{ |x| x.include? "http"}.index(true)
			self.link = array[index]
			if array[index].length > 23
				array[index] = "#{array[index][0..20]}..."
			end

			self.message = array.join(" ")

		end
	end

end
