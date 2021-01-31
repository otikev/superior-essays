class Utils
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  def self.random_string(len)
    # generate a random alphanumeric string of the specified length
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    newpass = ''
    1.upto(len) { |_i| newpass << chars[rand(chars.size - 1)] }
    newpass
  end

  def self.random_upcase_string(len)
    # generate a random alphanumeric string of the specified length
    chars = ('A'..'Z').to_a + ('0'..'9').to_a
    newpass = ''
    1.upto(len) { |_i| newpass << chars[rand(chars.size - 1)] }
    newpass
  end

  def self.get_error_string(model,title)
    error_string = '<br/><ul>'
    model.errors.full_messages.each do |msg|
      error_string << '<li>'+msg+'</li>'
    end
    error_string << '</ul>'
    error_string = title + error_string
    error_string
  end  
end
