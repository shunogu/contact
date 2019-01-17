require 'rails_helper'

RSpec.describe 'lists#index', type: :system do
  before do
    List.create(
      company: "test_company",
      person: "tester",
      memo: "test_memo"
    )
  end

  it 'lists/index 初回起動時' do
    visit root_path

    expect(page).to have_content 'Contact'
    expect(page).to have_content 'test_company'
    expect(page).to have_content 'tester'
    expect(page).to have_content 'test_memo'
  end

  it '検索/表示' do
    List.create(
      company: "dammy_company",
      person: "dammy_person",
      memo: "dammy_memo"
    )
    visit root_path

    fill_in 'q[company_cont]', with: 'test_company'
    click_button'Search'

    expect(page).to have_content 'test_company'
    expect(page).to_not have_content 'dammy_company'
  end

  it 'CREATEボタン' do
    visit root_path
    click_on 'Create'

    expect(page).to have_content 'New Record'
    find_button('Create List')
  end

  it 'SHOWボタン' do
    visit root_path
    click_link 'Show'

    expect(page).to have_content 'test_company'
  end

  it 'EDITボタン' do
    visit root_path
    click_link 'Edit'
    has_text? 'Editing Record'
    fill_in 'list[company]', with: 'マイナビ'
    fill_in 'list[person]', with: 'マイナビ担当'
    fill_in 'list[memo]', with: 'マイナビメモ'
    click_button 'Update List'

    expect(page).to have_content 'List was successfully updated.'
    expect(page).to have_content 'マイナビ'
    expect(page).to have_content 'マイナビ担当'
    expect(page).to have_content 'マイナビメモ'
  end

  describe 'DESTROYボタン' do
    it 'alert ok' do
      visit root_path
      click_link 'Destroy'

      get_text
      expect(get_text).to eq 'Are you sure?'
      click_ok
      expect(page).to_not have_content 'test_company'
      expect(page).to have_content 'List was successfully destroyed.'
    end

    it 'alert キャンセル' do
      visit root_path
      click_link 'Destroy'

      get_text
      expect(get_text).to eq 'Are you sure?'
      click_cancel
      expect(page).to have_content 'test_company'
    end
  end

  describe 'pagination' do
    it 'ボタン' do
      9.times do
        List.create(
          company: "dammy_company",
          person: "dammy_tester",
          memo: "dammy_memo"
        )
      end
      # 11件目
      List.create(
        company: "マイナビ",
        person: "タナカ",
        memo: "none"
      )

      visit root_path
      click_on 'navigate_next'
      expect(page).to have_content 'マイナビ'
      click_on 'navigate_before'
      expect(page).to have_content 'test_company'
    end
  end
end
