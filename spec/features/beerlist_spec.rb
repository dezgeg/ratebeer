require 'spec_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = "Lager"
    @style2 = "Rauchbier"
    @style3 = "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js: true do
    visit beers_nglist_path
    expect(page).to have_content "Nikolai"
  end

  it "shows beers listed in alpabetical order by default", js: true do
    visit beers_nglist_path
    find('tbody').find('tr:nth-child(1)').should have_content('Fastenbier')
    find('tbody').find('tr:nth-child(2)').should have_content('Lechte Weisse')
    find('tbody').find('tr:nth-child(3)').should have_content('Nikolai')
  end

  it "can sort beers by style", js: true do
    visit beers_nglist_path
    find('a', text: 'style').click

    find('tbody').find('tr:nth-child(1)').should have_content('Nikolai')
    find('tbody').find('tr:nth-child(2)').should have_content('Fastenbier')
    find('tbody').find('tr:nth-child(3)').should have_content('Lechte Weisse')
  end

  it "can sort beers by brewery", js: true do
    visit beers_nglist_path
    find('a', text: 'brewery').click

    find('tbody').find('tr:nth-child(1)').should have_content('Lechte Weisse')
    find('tbody').find('tr:nth-child(2)').should have_content('Nikolai')
    find('tbody').find('tr:nth-child(3)').should have_content('Fastenbier')
  end
end
