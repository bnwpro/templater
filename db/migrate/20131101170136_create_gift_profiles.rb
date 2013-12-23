class CreateGiftProfiles < ActiveRecord::Migration
  def change
    create_table :gift_profiles do |t|
      t.integer :campaign_id
      t.decimal :goal, precision: 9, scale: 0, default: 0
      t.integer :t1_gifts_1, default: 0
      t.integer :t1_gifts_2, default: 0
      t.integer :t1_gifts_3, default: 0
      t.integer :t1_gifts_4, default: 0
      t.integer :t1_gifts_5, default: 0
      t.integer :t1_gifts_6, default: 0
      t.decimal :t1_gift_amount_1, precision: 7, scale: 0, default: 0
      t.decimal :t1_gift_amount_2, precision: 7, scale: 0, default: 0
      t.decimal :t1_gift_amount_3, precision: 7, scale: 0, default: 0
      t.decimal :t1_gift_amount_4, precision: 7, scale: 0, default: 0
      t.decimal :t1_gift_amount_5, precision: 7, scale: 0, default: 0
      t.decimal :t1_gift_amount_6, precision: 7, scale: 0, default: 0
      t.integer :t2_gifts_1, default: 0
      t.integer :t2_gifts_2, default: 0
      t.integer :t2_gifts_3, default: 0
      t.integer :t2_gifts_4, default: 0
      t.integer :t2_gifts_5, default: 0
      t.integer :t2_gifts_6, default: 0
      t.integer :t2_gifts_7, default: 0
      t.decimal :t2_gift_amount_1, precision: 7, scale: 0, default: 0
      t.decimal :t2_gift_amount_2, precision: 7, scale: 0, default: 0
      t.decimal :t2_gift_amount_3, precision: 7, scale: 0, default: 0
      t.decimal :t2_gift_amount_4, precision: 7, scale: 0, default: 0
      t.decimal :t2_gift_amount_5, precision: 7, scale: 0, default: 0
      t.decimal :t2_gift_amount_6, precision: 7, scale: 0, default: 0
      t.decimal :t2_gift_amount_7, precision: 7, scale: 0, default: 0
      t.integer :t3_gifts_1, default: 0
      t.integer :t3_gifts_2, default: 0
      t.integer :t3_gifts_3, default: 0
      t.integer :t3_gifts_4, default: 0
      t.integer :t3_gifts_5, default: 0
      t.integer :t3_gifts_6, default: 0
      t.decimal :t3_gift_amount_1, precision: 7, scale: 0, default: 0
      t.decimal :t3_gift_amount_2, precision: 7, scale: 0, default: 0
      t.decimal :t3_gift_amount_3, precision: 7, scale: 0, default: 0
      t.decimal :t3_gift_amount_4, precision: 7, scale: 0, default: 0
      t.decimal :t3_gift_amount_5, precision: 7, scale: 0, default: 0
      t.decimal :t3_gift_amount_6, precision: 7, scale: 0, default: 0
      t.decimal :remainder, precision: 7, scale: 2, default: 0
      
      t.index :campaign_id

      t.timestamps
    end
  end
end
