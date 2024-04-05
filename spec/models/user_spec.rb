require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(first_name: "Joe", last_name: "Anand")
    expect(user).to be_valid
  end

  it "is not valid without a first name" do
    user = User.new(last_name: "Anand")
    expect(user).not_to be_valid
  end

  it "is not valid without a last name" do
    user = User.new(first_name: "Joe")
    expect(user).not_to be_valid
  end
end
