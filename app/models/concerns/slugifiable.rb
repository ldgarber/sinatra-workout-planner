module Slugifiable

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
  
end
