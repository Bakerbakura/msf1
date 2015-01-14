# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20140325150420) do

  create_table "customers", :id => false, :force => true do |t|
    t.integer "CustID",        :limit => 8,                   :null => false
    t.string  "Username",      :limit => 30
    t.string  "Email",         :limit => 30,                  :null => false
    t.string  "Pword",         :limit => 45,                  :null => false
    t.string  "Gender",        :limit => 1,  :default => "M", :null => false
    t.float   "ShoeSize"
    t.float   "ShoeSizeError"
  end

  add_index "customers", ["CustID"], :name => "CustID_UNIQUE", :unique => true
  add_index "customers", ["Email"], :name => "Email_UNIQUE", :unique => true
  add_index "customers", ["Gender"], :name => "fk_CustomerInfo_Genders1_idx"
  add_index "customers", ["Username"], :name => "Username_UNIQUE", :unique => true

  create_table "customerss", :force => true do |t|
    t.integer  "CustID"
    t.string   "Username"
    t.string   "Email"
    t.string   "Pword"
    t.string   "Gender"
    t.float    "ShoeSize"
    t.float    "ShoeSizeError"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "genders", :primary_key => "Gender", :force => true do |t|
  end

  add_index "genders", ["Gender"], :name => "Gender_UNIQUE", :unique => true

  create_table "lengthfits", :primary_key => "LengthFit", :force => true do |t|
  end

  add_index "lengthfits", ["LengthFit"], :name => "LengthFit_UNIQUE", :unique => true

  create_table "shoebrands", :primary_key => "Brand", :force => true do |t|
  end

  add_index "shoebrands", ["Brand"], :name => "Brand_UNIQUE", :unique => true

  create_table "shoematerials", :primary_key => "Material", :force => true do |t|
  end

  add_index "shoematerials", ["Material"], :name => "Material_UNIQUE", :unique => true

  create_table "shoes", :primary_key => "ShoeID", :force => true do |t|
    t.integer "OwnerID",     :limit => 8,                         :null => false
    t.integer "T2RS_ID",     :limit => 8,                         :null => false
    t.string  "Brand",       :limit => 30,                        :null => false
    t.string  "Style",       :limit => 30,                        :null => false
    t.string  "Material",    :limit => 30,                        :null => false
    t.string  "SizeType",    :limit => 20,                        :null => false
    t.float   "Size",                                             :null => false
    t.string  "LengthFit",   :limit => 20, :default => "Perfect", :null => false
    t.float   "PreRealSize"
    t.float   "RealSize"
  end

  add_index "shoes", ["Brand"], :name => "fk_Shoes_ShoeBrands1_idx"
  add_index "shoes", ["LengthFit"], :name => "fk_Shoes_LengthFits1_idx"
  add_index "shoes", ["Material"], :name => "fk_Shoes_ShoeMaterials1_idx"
  add_index "shoes", ["OwnerID"], :name => "fk_Shoes_CustomerInfo1_idx"
  add_index "shoes", ["ShoeID"], :name => "idShoes_UNIQUE", :unique => true
  add_index "shoes", ["SizeType"], :name => "SizeType_idx"
  add_index "shoes", ["Style"], :name => "fk_Shoes_ShoeStyles1_idx"
  add_index "shoes", ["T2RS_ID"], :name => "fk_Shoes_TypeToRealSize1_idx"

  create_table "shoestyles", :primary_key => "Style", :force => true do |t|
  end

  add_index "shoestyles", ["Style"], :name => "Type_UNIQUE", :unique => true

  create_table "sizetypes", :primary_key => "SizeType", :force => true do |t|
    t.float "ToMondo1"
    t.float "ToMondo0"
    t.float "SizeTypeInterval"
  end

  add_index "sizetypes", ["SizeType"], :name => "SizeType_UNIQUE", :unique => true

  create_table "t2rs_entryinfo", :id => false, :force => true do |t|
    t.integer "OwnerID",  :limit => 8, :null => false
    t.float   "PreSize",               :null => false
    t.float   "ShoeSize",              :null => false
  end

  create_table "t2rs_initialised", :primary_key => "init", :force => true do |t|
  end

  create_table "typetorealsize", :primary_key => "T2RS_ID", :force => true do |t|
    t.string  "Brand",    :limit => 30,                    :null => false
    t.string  "Style",    :limit => 30,                    :null => false
    t.string  "Material", :limit => 30,                    :null => false
    t.float   "ToMondo1",                                  :null => false
    t.float   "ToMondo0",                                  :null => false
    t.boolean "modified",               :default => false, :null => false
  end

  add_index "typetorealsize", ["Brand"], :name => "Brand_idx"
  add_index "typetorealsize", ["Material"], :name => "Material_idx"
  add_index "typetorealsize", ["Style"], :name => "Style_idx"
  add_index "typetorealsize", ["T2RS_ID"], :name => "TypeToRealSizeID_UNIQUE", :unique => true

end
