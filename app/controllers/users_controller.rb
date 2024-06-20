class UsersController < ApplicationController
  def index
  end

  def import
    return redirect_to users_url, notice: 'No file added.' if params[:file].nil?
    return redirect_to users_url, notice: 'Only CSV files allowed.' unless params[:file].content_type == 'text/csv'

    @users = CsvImportUsersService.new.call(params[:file])

    flash.now[:notice] = "Import processed."
    render template: '/users/index'
  end
end
