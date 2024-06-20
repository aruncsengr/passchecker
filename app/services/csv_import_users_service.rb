class CsvImportUsersService
  require 'csv'

  def call(file)
    users = []
    valid_users = []
    CSV.foreach(file.path, headers: true) do |row|
      user_attributes = { name: row['name'], password: row['password'] }
      user = User.new(user_attributes)
      valid_users.push(user_attributes) if user.valid?
      users.push user
    end

    User.insert_all!(valid_users, returning: %w[ name ])
    users
  end
end
