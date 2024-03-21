class CreateAccounts < ActiveRecord::Migration[6.1]
 def change
    create_table :accounts do |t|
      t.string "first_name"
      t.string "last_name"
      t.string "full_phone_number"
      t.integer "country_code"
      t.bigint "phone_number"
      t.string "email"
      t.boolean "activated", default: false, null: false
      t.string "device_id"
      t.text "unique_auth_id"
      t.string "password_digest"
      t.string "type"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "user_name"
      t.string "platform"
      t.string "user_type"
      t.integer "app_language_id"
      t.datetime "last_visit_at"
      t.boolean "is_blacklisted", default: false
      t.date "suspend_until"
      t.integer "status", default: 0, null: false
      t.string "stripe_id"
      t.string "stripe_subscription_id"
      t.datetime "stripe_subscription_date"
      t.integer "role_id"
    end
 end
end
