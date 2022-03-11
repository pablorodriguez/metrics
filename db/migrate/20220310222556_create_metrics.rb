# frozen_string_literal: true

class CreateMetrics < ActiveRecord::Migration[6.1]
  def change
    create_table :metrics do |t|
      t.string :key
      t.float :value

      t.timestamps
    end
  end
end
