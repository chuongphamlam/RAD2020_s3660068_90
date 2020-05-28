class User < ApplicationRecord
    before_save { self.email=email.downcase }
    validates:name, presence: true , length:{ maximum:50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true , length: { maximum: 50 } ,
                                    format: { with:VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false}
    before_save { self.email = self.email.downcase }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6, maximum:20 }, allow_nil: true
    VALID_MOBILE_REGEX = /\d/
    validates :mobile, presence: true,
               length: { minimum:6, maximum:13},
               format: { with: VALID_MOBILE_REGEX }     
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :cards, dependent: :destroy

    mount_uploader :photo, ImageUploader

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token  
        SecureRandom.urlsafe_base64   
    end


    def send_password_reset
        generate_token(:password_reset_token)
        self.password_reset_sent_at = Time.zone.now
        save!
        UserMailer.welcome_email(self).deliver!
      end

      def generate_token(column)
        begin
          self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
      end


    
    attr_accessor :remember_token
    
    def remember     
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end
end
