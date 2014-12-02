require 'rails_helper'

feature "PostIdea" do
  before { @user = FactoryGirl.create(:user) }

  scenario 'post a new idea' do
    sign_in_with_username @user
    @idea = FactoryGirl.build(:idea)

    first(:link, 'New idea').click
    expect(page).to have_title 'New idea'
    fill_in 'idea_title', with: @idea.title
    fill_in 'idea_content', with: @idea.content

    click_button 'Post'
    expect(page).to have_content @idea.content
  end
end
