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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "customers", id: false, force: true do |t|
    t.integer "CustID",            limit: 8,                null: false
    t.string  "Email",             limit: 30,               null: false
    t.string  "Gender",            limit: 1,  default: "M", null: false
    t.string  "password_digest",   limit: 60,               null: false
    t.float   "ShoeSize",          limit: 24
    t.float   "ShoeSizeError",     limit: 24
    t.string  "preferredSizeType", limit: 20,               null: false
  end

  add_index "customers", ["CustID"], name: "CustID_UNIQUE", unique: true, using: :btree
  add_index "customers", ["Email"], name: "Email_UNIQUE", unique: true, using: :btree
  add_index "customers", ["Gender"], name: "fk_CustomerInfo_Genders1_idx", using: :btree
  add_index "customers", ["preferredSizeType"], name: "preferredSizeType_Customers_idx", using: :btree

  create_table "genders", primary_key: "Gender", force: true do |t|
  end

  add_index "genders", ["Gender"], name: "Gender_UNIQUE", unique: true, using: :btree

  create_table "lengthfits", primary_key: "LengthFit", force: true do |t|
  end

  add_index "lengthfits", ["LengthFit"], name: "LengthFit_UNIQUE", unique: true, using: :btree

  create_table "shoebrands", primary_key: "Brand", force: true do |t|
  end

  add_index "shoebrands", ["Brand"], name: "Brand_UNIQUE", unique: true, using: :btree

  create_table "shoematerials", primary_key: "Material", force: true do |t|
  end

  add_index "shoematerials", ["Material"], name: "Material_UNIQUE", unique: true, using: :btree

  create_table "shoes", primary_key: "ShoeID", force: true do |t|
    t.integer "OwnerID",     limit: 8,                      null: false
    t.integer "T2RS_ID",     limit: 8,  default: 0,         null: false
    t.string  "Brand",       limit: 30,                     null: false
    t.string  "Style",       limit: 30,                     null: false
    t.string  "Material",    limit: 30,                     null: false
    t.string  "SizeType",    limit: 20,                     null: false
    t.float   "Size",        limit: 24,                     null: false
    t.string  "LengthFit",   limit: 20, default: "Perfect", null: false
    t.float   "PreRealSize", limit: 24
    t.float   "RealSize",    limit: 24
  end

  add_index "shoes", ["Brand"], name: "fk_Shoes_ShoeBrands1_idx", using: :btree
  add_index "shoes", ["LengthFit"], name: "fk_Shoes_LengthFits1_idx", using: :btree
  add_index "shoes", ["Material"], name: "fk_Shoes_ShoeMaterials1_idx", using: :btree
  add_index "shoes", ["OwnerID"], name: "fk_Shoes_CustomerInfo1_idx", using: :btree
  add_index "shoes", ["ShoeID"], name: "idShoes_UNIQUE", unique: true, using: :btree
  add_index "shoes", ["SizeType"], name: "SizeType_idx", using: :btree
  add_index "shoes", ["Style"], name: "fk_Shoes_ShoeStyles1_idx", using: :btree
  add_index "shoes", ["T2RS_ID"], name: "fk_Shoes_TypeToRealSize1_idx", using: :btree

  create_table "shoestyles", primary_key: "Style", force: true do |t|
  end

  add_index "shoestyles", ["Style"], name: "Type_UNIQUE", unique: true, using: :btree

  create_table "sizetypes", primary_key: "SizeType", force: true do |t|
    t.float "ToMondo1",         limit: 24
    t.float "ToMondo0",         limit: 24
    t.float "SizeTypeInterval", limit: 24
    t.float "MinSize",          limit: 24
    t.float "MaxSize",          limit: 24
  end

  add_index "sizetypes", ["SizeType"], name: "SizeType_UNIQUE", unique: true, using: :btree

  create_table "t2rs_entryinfo", id: false, force: true do |t|
    t.integer "OwnerID",  limit: 8,  null: false
    t.float   "PreSize",  limit: 53, null: false
    t.float   "RealSize", limit: 53, null: false
    t.float   "ShoeSize", limit: 53, null: false
  end

  create_table "typetorealsize", id: false, force: true do |t|
    t.integer "T2RS_ID",            limit: 8,                  null: false
    t.string  "BrandStyleMaterial", limit: 70,                 null: false
    t.float   "ToMondo1",           limit: 53, default: 1.0,   null: false
    t.float   "ToMondo0",           limit: 53, default: 0.0,   null: false
    t.boolean "modified",                      default: false, null: false
    t.float   "Uncertainty",        limit: 24
  end

  add_index "typetorealsize", ["BrandStyleMaterial"], name: "BrandStyleMaterial_UNIQUE", unique: true, using: :btree
  add_index "typetorealsize", ["T2RS_ID"], name: "TypeToRealSizeID_UNIQUE", unique: true, using: :btree

end
