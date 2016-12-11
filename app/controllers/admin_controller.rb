class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def enqueue_elibri
     ImportProductsJob.perform_later

     flash[:info] = "Import danych zostanie za chwilę przeprowadzony"

     redirect_to admin_path
  end

end
