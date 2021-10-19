module ApplicationHelper
  #税込価格を返す
  def tax_included_price(price)
    return (price*1.1).floor
  end

    # 商品ごとの合計価格
  def subtotal_price(cart)
    quantities = cart.quantity
    pricies = cart.product.price
    subtotal_price = pricies * quantities
    return subtotal_price
  end

  # 商品全体の合計金額
  def total_price(carts)
    total_price = carts.pluck(:quantity, :price).sum{ |q, p| q * p }
    return total_price
  end
end
