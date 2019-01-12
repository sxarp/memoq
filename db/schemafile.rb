# Execute DDL using ridgepole gem: https://github.com/winebarrel/ridgepole
# This file is refered by the rake tasks: db:ensure:*.

require "active_support/inflector"

CREATE_TABLE_METHOD = self.method(:create_table)
ADD_FOREIGN_KEY_METHOD = self.method(:add_foreign_key)
ADD_INDEX_METHOD = self.method(:add_index)
module Tables
  class Table
    DEFAULT_OPTIONS = "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin".freeze

    def initialize(table_name)
      @table_name = table_name.freeze
    end

    def foreign_key_name
      "#{self.to_s.singularize}_id"
    end

    # Create a table which has the refelece keys to *foreign_tables.
    # @params *foreign_tables [Table]
    # @return Table
    #
    def create_table_belonging(*foreign_tables)
      # About force: :cascase
      # >Set to true to drop the table before creating it. Set to :cascade to drop dependent objects as well. Defaults to false.
      # https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-create_table
      CREATE_TABLE_METHOD.call self.to_s, force: :cascade, options: DEFAULT_OPTIONS do |table|
        yield table if block_given?

        table.datetime "created_at", null: false
        table.datetime "updated_at", null: false

        foreign_tables.each do |foreign_table|
          table.bigint foreign_table.foreign_key_name, null: false
        end
      end

      foreign_tables.each do |foreign_table|
        add_foreign_key_to foreign_table
      end

      self
    end

    def create_table(&block)
      create_table_belonging(&block)
    end

    def to_s
      @table_name
    end

    def add_foreign_key_to(table)
      # MySQL requires indexes on foreign keys and referenced keys so that foreign key checks can be fast and not require a table scan.
      add_index([table.foreign_key_name])

      ADD_FOREIGN_KEY_METHOD.call(
        self.to_s,
        table,
        name: "#{self}_to_#{table}_fk", # Foreign key names must be unique in the entire database.
      )

      self
    end

    def add_index(*column_names, unique: false)
      ADD_INDEX_METHOD.call(
        self.to_s,
        column_names,
        name: "#{column_names.join("_and_")}_index",
        using: :btree,
        unique: unique,
      )

      self
    end
  end

  Articles = Table.new("articles")
  Users = Table.new("users")
  Problems = Table.new("problems")
  ProblemRevisions = Table.new("problem_revisions")
  ProblemDescriptions = Table.new("problem_descriptions")
  Questions = Table.new("questions")
  ProblemRevisionQuestions = Table.new("problem_revision_questions")
  Choices = Table.new("choices")
end

Tables::Articles.create_table do |t|
  t.string "title"
  t.text "content"
  t.integer "status"
end

Tables::Users.create_table

Tables::Problems.create_table_belonging(Tables::Users)

Tables::ProblemRevisions.create_table_belonging(Tables::Problems, Tables::ProblemDescriptions)

Tables::ProblemDescriptions.create_table do |t|
  t.string "title"
  t.text "description"
end

Tables::Questions.create_table do |t|
  t.text "description"
  t.text "explanation"
end

Tables::ProblemRevisionQuestions.create_table_belonging(
  Tables::ProblemRevisions,
  Tables::Questions,
) do |t|
  t.integer "order"
end.add_index(Tables::ProblemRevisions.foreign_key_name, Tables::Questions.foreign_key_name, unique: true)

Tables::Choices.create_table_belonging(Tables::Questions) do |t|
  t.integer "order"
  t.boolean "check"
  t.text "description"
end
