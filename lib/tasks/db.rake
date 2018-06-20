namespace :db do
  desc "Apply ridgepole"
  task apply: :environment do
    system "bundle exec ridgepole -c config/database.yml --apply -E #{Rails.env} -f db/Schemafile"
  end
end
