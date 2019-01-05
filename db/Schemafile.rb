create_table "articles", force: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
  t.string   "title"
  t.text "content"
  t.integer  "status"
  t.datetime "created_at"
  t.datetime "updated_at"
end
