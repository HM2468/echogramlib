class User < ApplicationRecord

    before_save   :downcase_email

    validate :name_valid?
    validate :email_valid?   
    validates :email, uniqueness: true
    validate :passwd_valid?
    validates_presence_of :password_confirmation, message: 'Password confirmation input is empty.'
    has_secure_password(option = {})
 private
    # Converts email to all lower-case.
    def downcase_email
        self.email = email.downcase
    end

    def email_valid?
        regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        if !email.present?
            errors.add(:user,"Email input is empty.")
        elsif email.length > 255
            errors.add(:user,"Email is too long.")
        elsif !email.match(regex)
            errors.add(:user,"Email format is incorrect.")
        else
        end
    end

    def name_valid?
        if !name.present? 
            errors.add(:user,"Name input is empty.")
        elsif name.length > 50
            errors.add(:user,"Name is too long.")
        else
        end
    end

    def passwd_valid?
        if !password.present?
            errors.add(:user,"Password input is empty.")
        elsif password.length < 8
            errors.add(:user,"Password is too short, minimum password length is 8.")
        else
        end

    end


end
