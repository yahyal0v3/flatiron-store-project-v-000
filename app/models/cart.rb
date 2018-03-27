class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    total = 0
    self.line_items.each do |line_item|
      total += line_item.item.price * line_item.quantity
    end
    total
  end

  def add_item(item_id)
    self.save
    if line_item = LineItem.find_by(:cart_id => self.id, :item_id => item_id)
      line_item.quantity += 1
      line_item
    else
     LineItem.new(:cart_id => self.id, :item_id => item_id)
    end
  end
end
