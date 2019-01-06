# Force option:
# >:force
# >Set to true to drop the table before creating it. Set to :cascade to drop dependent objects as well. Defaults to false.
# https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-create_table

create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
  t.string   "title"
  t.text "content"
  t.integer  "status"
  t.datetime "created_at"
  t.datetime "updated_at"
end

create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
  t.datetime "created_at"
  t.datetime "updated_at"
end
