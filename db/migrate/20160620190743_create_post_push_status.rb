class CreatePostPushStatus < (Rails::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[4.2] : ActiveRecord::Migration)
  def change
    create_table :post_push_statuses do |t|
      t.string :task_name, null: false, index: true
    end
  end
end
