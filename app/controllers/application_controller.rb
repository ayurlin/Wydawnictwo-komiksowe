class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 
  before_action :set_default_meta

  protected
  def set_default_meta
    @meta = { title: "Wydawnictwo komiksowe", keywords: "", description: "" }.add_method_access
  end



end
