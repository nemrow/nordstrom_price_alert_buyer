require 'spec_helper'

describe Nordstrom::SignIn do
   it "logs the user in" do
      Nordstrom::SignIn.new(Nordstrom.browser).run
   end
end
