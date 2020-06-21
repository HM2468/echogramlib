class User < ApplicationRecord


    before_save   :downcase_email
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

    has_secure_password




    

    # Converts email to all lower-case.
    def downcase_email
        self.email = email.downcase
    end
end
