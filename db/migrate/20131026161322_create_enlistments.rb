class CreateEnlistments < ActiveRecord::Migration
  def change
    create_table :enlistments do |t|
      t.integer :campaign_id
      t.integer :ac_enlist, default: 0
      t.integer :childs_act_enlist, default: 0
      t.integer :spc_event_enlist, default: 0
      t.integer :contact_enlist, default: 0
      t.integer :contact_each_enlist, default: 0
      t.integer :info_enlist, default: 0
      t.index :campaign_id

      t.timestamps
    end
  end
end
