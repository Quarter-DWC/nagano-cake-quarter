module ApplicationHelper
  #税込価格を返す
  def tax_included_price(price)
    return (price*1.1).floor
  end

end
