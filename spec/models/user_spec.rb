require 'rails_helper'
RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    it "nicknameが空だと登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it "emailが空では登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it "passwordが空だと登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが存在してもpassword_confirmationが空では登録できない' do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password = "123456"
      @user.password_confirmation = "1234567"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '重複したemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'emailに@が含まれてなければ登録できない' do
      @user.email = "ppppppp"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Email is invalid")
    end
    it "passwordが5文字以下では登録できない" do
      @user.password = "00000"
      @user.password_confirmation = "00000"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it "半角英語のみは登録できない" do
      @user.password = "wwwwww"
      @user.password_confirmation = "wwwwww"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it "数字のみは登録できない" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it "全角英数混合は登録できない" do
      @user.password = "１１１ＡＡＡ"
      @user.password_confirmation = "１１１ＡＡＡ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it "誕生日が空の場合は登録できない" do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
    it "姓が空の場合は登録できない" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it "姓が全角（漢字・ひらがな・カタカナ）以外は登録できない" do
      @user.last_name = "ﾔﾏﾀﾞ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
    end
    it "名が空の場合は登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it "名が全角（漢字・ひらがな・カタカナ）以外は登録できない" do
      @user.first_name = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end
    it "姓(カナ)が空の場合は登録できない" do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it "姓(カナ)が全角（カタカナ）以外は登録できない" do
      @user.last_name_kana = "ﾔﾏﾀﾞ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid")
    end
    it "名(カナ)が空の場合は登録できない" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it "名(カナ)が全角（カタカナ）以外は登録できない" do
      @user.first_name_kana = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid")
    end

  end
end
