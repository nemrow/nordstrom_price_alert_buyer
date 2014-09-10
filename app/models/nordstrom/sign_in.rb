module Nordstrom
  class SignIn
    def initialize(browser)
      @browser = browser
    end

    def run
      go_to_signin_page
    end

    private
      def go_to_signin_page
        signin_link = @browser.link(:text => "Sign In")
        signin_link.click
      end
  end
end
