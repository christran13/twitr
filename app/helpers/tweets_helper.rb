module TweetsHelper

	def get_tagged(tweet)
	message_array = tweet.message.split

    message_array.each_with_index do |word, index|
      if word[0] == "#"
        if Tag.pluck(:phrase).include?(word)
          tag = Tag.find_by(phrase: word)
        else
          tag = Tag.create(phrase: word)
        end
        TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
        message_array[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
      end
    end

    tweet.update(message: message_array.join(" "))
	end

end
