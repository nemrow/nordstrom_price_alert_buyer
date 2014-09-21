module Nordstrom
  class Account
    attr_accessor :browser

    def initialize(vendor, browser, user, options={})
      @user = user
      @vendor = vendor
      @browser = browser
      @options = options
    end

    def sign_in
      go_to_signin_page
      fill_in_data
      submit_button.click
    end

    def signed_in?
      count = 0
      until login_page_complete
        if count > 10
          @browser.mome
          raise "login page cannot be loaded" if count > 10
        end
        count += 1
        sleep(1)
      end
      login_success_detected?
    end

    private
      def login_page_complete
        login_success_detected? || login_fail_detected?
      end

      def login_success_detected?
        @browser.html.match(/Hello, /i) ? true : false
      end

      def login_fail_detected?
        (
          @browser.html.match(/The e-mail address and\/or password could not be found/i) ||
          @browser.html.match(/send you an e-mail with a link to reset your password/i)
        ) ? true : false
      end

      def go_to_signin_page
        signin_link = @browser.link(:text => "Sign In")
        signin_link.click
      end

      def fill_in_data
        email_input.set(credentials.username)
        password_input.set(credentials.password)
      end

      def credentials
        @credentials ||= @options[:credentials] || VendorCredential.find_by_user_id_and_vendor_id(@user.id, @vendor.id)
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
