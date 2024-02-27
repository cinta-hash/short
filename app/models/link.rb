class Link < ApplicationRecord
    after_create_commit :generate_short_url 



    private 
  
    def generate_short_url
     self.short_url = SecureRandom.hex(3)[0..20]
     self.save
    end
end
