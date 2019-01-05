namespace :db do
  namespace :ensure do
    task apply: :environment do
      desc "Apply ridgepole"
      system "bundle exec ridgepole -c config/database.yml --apply -E #{Rails.env} -f db/Schemafile.rb"
      system "bundle exec annotate --exclude tests,fixtures,factories,serializers"
    end

    task dry_run: :environment do
      desc "Dry run ridge pole"
      system "bundle exec ridgepole -c config/database.yml --apply -E #{Rails.env} -f db/Schemafile.rb --dry_run"
    end
  end
end
