require 'spec_helper'

describe Nordstrom::SignIn do

  before(:each) do
    @user = User.create(
      :name => "Jordan Nemrow",
      :email => ENV["JORDAN_NORDSTROM_EMAIL"],
      :password => "password",
      :nordstrom_email => ENV["JORDAN_NORDSTROM_EMAIL"],
      :nordstrom_password => ENV["JORDAN_NORDSTROM_PASSWORD"],
      :nordstrom_cc_cvc => ENV["JORDAN_NORDSTROM_CC_CVC_CODE"]
    )
    @browser = Nordstrom.browser
  end

  it "logs the user in" do
    Nordstrom::SignIn.new(@user, @browser).run
    assert_equal "Sign Out", @browser.li(:id => "shopper-status").text
  end
end
