module Nordstrom
  class SignIn
    def initialize(user, vendor)
      @user = user
      @vendor = vendor
    end

    def run
      go_to_signin_page
      fill_in_data
      submit_button.click
      count = 0
      until browser.a(:text => "Sign Out").exists? do
        sleep 1
        raise "Cant find signout button" if count > 10
        count += 1
      end
      browser
    end

    private
      def go_to_signin_page
        signin_link = browser.link(:text => "Sign In")
        signin_link.click
      end

      def fill_in_data
        email_input.set(credentials.username)
        password_input.set(credentials.password)
      end

      def credentials
        @credentials ||= VendorCredential.find_by_user_id_and_vendor_id(@user.id, @vendor.id)
      end

      def email_input
        browser.text_field(:id => "ctl00_mainContentPlaceHolder_signIn_email")
      end

      def submit_button
        browser.link(:id => "ctl00_mainContentPlaceHolder_signIn_enterButton")
      end

      def password_input
        browser.text_field(:id => "ctl00_mainContentPlaceHolder_signIn_password")
      end

      def browser
        @browser ||= begin
          browser = Watir::Browser.new(:phantomjs)
          browser.goto(@vendor.host)
          browser
        end
      end
  end
end
