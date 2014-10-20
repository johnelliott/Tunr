require 'rails_helper'

feature "Manage Albums" do
  scenario "List no Albums" do
    visit albums_path #albums helper
    expect(page.find('h1')).to have_content(/Albums/)
    expect(page).to have_content(/No albums available/i)
  end

  scenario "List all Albums" do
    Album.create!(
      title: 'Astrolounge',
      artist: 'Smash Mouth',
      year: '1999'
    )

    visit albums_path
    expect(page.find('.album')).to have_content(/Astrolounge/)
    expect(page.find('.artist')).to have_content(/Smash Mouth/)
    expect(page.find('.year')).to have_content(/1999/)
    expect(page).not_to have_content(/No albums available/i)
  end

  scenario "Add new Albums" do
    visit new_album_path

    fill_in 'Title', with: 'Astrolounge'
    fill_in 'Artist', with: 'Smash Mouth'
    fill_in 'Year', with: '1999'
    click_on 'Create Album'

    expect(current_path).to eq(album_path(Album.last.id))
    expect(find.('#notice')).to have_content(/success/i)

  # @album = Album.new(title: 'Fancy', artist: 'Iggy Azalia', year:'2014')
  # expect(@album[:title]).to eql('Fancy')
  # expect(@album[:artist]).to eql('Iggy Azalia')
  # expect(@album[:year]).to eql(2014)
  end

  scenario "Update an Album" do
    album = create_astrolounge
    visit edit_album_path(album)

    fill_in :album, with: 'Smash Mouth'
    fill_in :year, with: '2001'
    click_on 'Update Album'

    expect(current_path).to eq(albums_path(album))
    expect('#notice').to have_content(/updated/i)

  end
end
