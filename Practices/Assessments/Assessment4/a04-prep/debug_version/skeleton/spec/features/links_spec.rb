require 'rails_helper'

feature 'Creating a link' do
  before :each do
    sign_up_as_ginger_baker
    visit new_link_path
  end

  it 'has a new link page' do
    expect(page).to have_content 'New Link'
  end

  it 'takes a title and a url' do
    expect(page).to have_content 'Title'
    expect(page).to have_content 'URL'
  end

  it 'redirects to the link show page on success' do
    fill_in 'URL', with: 'http://google.com'
    fill_in 'Title', with: 'google'
    click_button 'Create New Link'

    expect(current_path).to eq(link_path(Link.last))
  end

  context 'on failed save' do
    before :each do
      fill_in 'Title', with: 'google'
      click_button 'Create New Link'
    end

    it 'renders errors when invalid links are submitted' do
      expect(page).to have_content 'Url can\'t be blank'
    end

    it 'displays the new link form again' do
      expect(page).to have_content 'New Link'
    end

    it 'has a pre-filled form (with the data previously input)' do
      expect(find_field('Title').value).to eq('google')
    end

    it 'still allows for a successful save' do
      fill_in 'URL', with: 'http://google.com'
      click_button 'Create New Link'
      expect(current_path).to eq(link_path(Link.last))
    end
  end
end

feature 'Seeing all links' do
  context 'when logged in' do
    before :each do
      foo = User.create!(username: 'foo', password: 'password')
      foo.links.create!(title: 'yahoo', url: 'http://yahoo.com')
      sign_up_as_ginger_baker
      make_link('google', 'http://google.com')
      make_link('amazon', 'http://amazon.com')
      visit links_path
    end

    it 'link index has a \'New Link\' link to new link page' do
      expect(page).to have_content 'New Link'
    end

    it 'shows all the links for all users' do
      expect(page).to have_content 'google'
      expect(page).to have_content 'yahoo'
      expect(page).to have_content 'amazon'
    end

    it 'shows the current user\'s username' do
      expect(page).to have_content 'ginger_baker'
    end

    it 'links to each of the link\'s show page via link titles' do
      click_link 'google'
      expect(current_path).to eq(link_path(Link.find_by_title('google')))
    end
  end

  context 'when logged out' do
    it 'redirects to the login page' do
      visit links_path
      expect(page).to have_content 'Sign In'
    end
  end

  context 'when signed in as another user' do
    before :each do
      User.create!(username: 'ginger_baker', password: 'abcdef')
      hw = User.create!(username: 'hello_world', password: 'abcdef')
      hw.links.create!(title: 'facebook', url: 'http://facebook.com')

      sign_in('ginger_baker')
    end

    it 'shows others links' do
      visit links_path
      expect(page).to have_content 'facebook'
    end
  end
end

feature 'Showing a link' do
  before :each do
    sign_up('ginger_baker')
    make_link('google', 'http://google.com')
    visit links_path
    click_link 'google'
  end

  it 'shows the link\'s author' do
    expect(page).to have_content('ginger_baker', count: 2)
  end

  it 'displays the link title' do
    expect(page).to have_content 'google'
  end

  it 'displays the link url' do
    expect(page).to have_content 'http://google.com'
  end

  it 'displays a link back to the link index' do
    expect(page).to have_content 'Links'
  end

  it 'has a link on the show page to edit a link' do
    expect(page).to have_content 'Edit Link'
  end
end

feature 'Editing a link' do
  before :each do
    sign_up_as_ginger_baker
    make_link('google', 'http://google.com')
    visit links_path
    click_link 'google'
  end

  it 'shows a form to edit the link' do
    click_link 'Edit Link'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'URL'
  end

  it 'has all the data pre-filled' do
    click_link 'Edit Link'
    expect(find_field('Title').value).to eq('google')
    expect(find_field('URL').value).to eq('http://google.com')
  end

  it 'shows errors if editing fails' do
    click_link 'Edit Link'
    fill_in 'URL', with: ''
    click_button 'Update Link'
    expect(page).to have_content 'Edit Link'
    expect(page).to have_content 'Url can\'t be blank'
  end

  context 'on successful update' do
    before :each do
      click_link 'Edit Link'
    end

    it 'redirects to the link show page' do
      fill_in 'Title', with: 'DuckDuckGo'
      click_button 'Update Link'
      expect(current_path).to eq(link_path(Link.find_by_title('DuckDuckGo')))
    end
  end
end
