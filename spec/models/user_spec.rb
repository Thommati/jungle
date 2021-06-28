require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new(first_name: 'Darcy', last_name: 'Dog', email: 'dog@example.com', password: 'woof', password_confirmation: 'woof')
    end

    it 'successfully save a new user with fields correctly filled out' do
      @user.save!
    end

    it 'does not save new user if password and confirm password do not match' do
      @user.password = 'woofy'
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'does not save new user if password and confirm password are blank' do
      @user.password = nil
      @user.password = nil
      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should require unique emails that are not case sensitive' do
      @user.save

      @user2 = User.new(first_name: 'Darcy', last_name: 'Dog', email: 'dog@example.com', password: 'woof', password_confirmation: 'woof')

      expect { @user2.save }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it 'should not save a new user if email is nil' do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not save a new user if first_name is nil' do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not save a new user if last_name is nil' do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'fails to save user if password length is less than 4' do
      @user.password = 'bow'
      @user.password_confirmation = 'bow'
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end
end
