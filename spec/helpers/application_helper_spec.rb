require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'formats page specific title' do
    content_for(:title) { 'Page Title'}

    expect("Page Title | #{I18n.t('piazza')}").to eq(title)
  end

  it 'returns app name when page title is missing' do
    expect(I18n.t('piazza')).to eq(title)
  end
end