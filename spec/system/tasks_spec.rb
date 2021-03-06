require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a) { create(:task, name: '最初のタスク', user: user_a) }

  before do
    visit login_path
    fill_in 'Email', with: login_user.email
    fill_in 'Password', with: login_user.password
    click_button '保存する'
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }
      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).not_to have_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      before do
        visit task_path(task_a)
      end
      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end
    end
  end
end
