namespace :db do
  namespace :ensure do
    schema_file_path = "db/schemafile.rb"
    config_file_path = "config/database.yml"

    task apply: :environment do
      desc "Apply ridgepole"
      system "bundle exec ridgepole -c #{config_file_path} --apply -E #{Rails.env} -f #{schema_file_path}"
      system "bundle exec annotate --exclude tests,fixtures,factories,serializers"
    end

    task dry_run: :environment do
      desc "Dry run ridge pole"
      system "bundle exec ridgepole -c #{config_file_path} --apply -E #{Rails.env} -f #{schema_file_path} --dry_run"
    end
  end
end
