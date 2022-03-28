class CreateImagens < ActiveRecord::Migration[7.0]
  def change
    create_table :imagens do |t|
      t.integer :usuario_id
      t.string :nome
      t.binary :arquivo
      t.timestamps
    end
  end
end
