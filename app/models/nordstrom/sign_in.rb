module Nordstrom
  class SignIn
    def initialize(user, browser)
      @user = user
      @browser = browser
    end

    def run
      go_to_signin_page
      fill_in_data
      submit_button.click
      until @browser.a(:text => "Sign Out").exists? do sleep 1 end
    end

    private
      def go_to_signin_page
        signin_link = @browser.link(:text => "Sign In")
        signin_link.click
      end

      def fill_in_data
        email_input.set(@user.nordstrom_email)
        password_input.set(@user.nordstrom_password)
      end

      def email_input
        @browser.text_field(:id => "ctl00_mainContentPlaceHolder_signIn_email")
      end

      def submit_button
        @browser.link(:id => "ctl00_mainContentPlaceHolder_signIn_enterButton")
      end

      def password_input
        @browser.text_field(:id => "ctl00_mainContentPlaceHolder_signIn_password")
      end
  end
end
