namespace :ideaegg do
  desc "Ideaegg | Reset pk"
  task reset_pk: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
