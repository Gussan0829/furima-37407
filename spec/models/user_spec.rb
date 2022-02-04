require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "ユーザー新規登録" do
    context 'ユーザー新規登録ができるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、birth、first_name_kan,
      family_name_kan、first_name_kana、family_name_kanaが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context "ユーザー新規登録ができないとき" do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "birthが空では登録できない" do
        @user.birth = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid? 
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emaiは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it '「名字・名前」が全角日本語ではないとき' do
        @user.first_name_kan = 'ai'
        @user.family_name_kan = 'ai'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kan 全角文字を使用してください", "Family name kan 全角文字を使用してください")
      end
      it '「名字(カナ)・名前(カナ)」が全角カタカナではないとき' do
        @user.first_name_kana = 'ai'
        @user.family_name_kana = 'ai'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角文字を使用してください", "Family name kana 全角文字を使用してください") 
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'パスワード」が英数字混合ではないこと' do
        @user.password = '111111111'
        @user.password_confirmation = '111111111'
        @user.valid?
        binding.pry
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end 
    end
  end
end