class CreateGroupUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :group_users do |t|
    # スペースを消して「.」を入れ、シンボル「:」を前に付けます
    t.references :user, null: false, foreign_key: true
    t.references :group, null: false, foreign_key: true

    t.timestamps
  end
  end
end
