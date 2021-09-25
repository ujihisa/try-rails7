class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  after_commit :upload_sqlite3

  M = Mutex.new
  private_constant :M

  private def upload_sqlite3
    M.synchronize {
      bucket = TryRails7::Application.config.google_cloud_storage_bucket
      bucket.create_file("db/#{Rails.env}.sqlite3", 'production.sqlite3')
    }
  end
end
