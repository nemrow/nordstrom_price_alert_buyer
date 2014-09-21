class VendorCredentialsController < ApplicationController
  before_filter :user_required
  before_filter :check_for_existing_users_vendor_crential, :only => :create

  def index
    @vendor_credentials = @user.vendor_credentials.includes(:vendor).all
  end

  def new
    @vendor_credential = VendorCredential.new
    @vendors_for_select = Vendor.all.map{|vendor| [vendor.display_name, vendor.id]}
  end

  def edit
    @vendor_credential = VendorCredential.includes(:vendor).find(params[:id])
  end

  def update
    vc = VendorCredential.find(params[:id])
    browser = VendorCredential.authenticate_credentials(@user, params[:vendor_credential])
    if browser.account.signed_in?
      vc.update_attributes(params[:vendor_credential])
      redirect_to :action => "index", :success => "vendor updated!"
    else
      redirect_to edit_vendor_credential_path(vc, :error => "could not authenticate")
    end
  end

  def create
    browser = VendorCredential.authenticate_credentials(@user, params[:vendor_credential])
    if browser.account.signed_in?
      vc = VendorCredential.create(params[:vendor_credential])
      @user.vendor_credentials << vc
      redirect_to :action => "index", :success => "vendor added!"
    else
      redirect_to :action => "new", :error => "could not authenticate"
    end
  end

  private
    def check_for_existing_users_vendor_crential
      if VendorCredential.find_by_user_id_and_vendor_id(@user.id, params[:vendor_credential][:vendor_id])
        redirect_to new_vendor_credential_path(:error => "You already have that vendor activated!")
        return false
      end
    end
end
