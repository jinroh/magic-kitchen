# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110512165351) do

  create_table "action_nodes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.string   "action"
    t.integer  "action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.integer  "action_id"
    t.string   "action_type", :default => "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["action_type"], :name => "index_events_on_action_type"

  create_table "favorites", :force => true do |t|
    t.integer  "favorable_id"
    t.string   "favorable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients_recipes", :id => false, :force => true do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
  end

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "recipes_ingredients", :force => true do |t|
    t.string   "recipe_id"
    t.string   "ingredient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "quantity"
  end

  add_index "recipes_ingredients", ["recipe_id", "ingredient_id"], :name => "index_ingredients_on_recipe_id_and_food_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",           :limit => 50
    t.string   "last_name",            :limit => 50
    t.string   "email",                :limit => 100, :default => "",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",   :limit => 128, :default => "",  :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.datetime "date_of_birth"
    t.text     "about"
    t.string   "gender",               :limit => 1,   :default => "N"
    t.string   "homepage",             :limit => 100
    t.string   "country",              :limit => 50
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["first_name"], :name => "index_users_on_firstname"
  add_index "users", ["last_name"], :name => "index_users_on_lastname"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
