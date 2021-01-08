require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = Array.new
  
  cart.each do |i|
    if find_item_by_name_in_collection(i[:item], coupons)
      
      item_coupon = find_item_by_name_in_collection(i[:item], coupons)
      coupon_increments = item_coupon[:num]
      item_per_unit_w_coupon = item_coupon[:cost]/coupon_increments
      
      new_cart.push({
        :item => i[:item],
        :price => i[:price],
        :clearance => i[:clearance],
        :count => i[:count] % coupon_increments
      })
        
      new_cart.push({
        :item => "#{i[:item]} W/COUPON",
        :price => item_per_unit_w_coupon,
        :clearance => i[:clearance],
        :count => i[:count] - (i[:count] % coupon_increments)
      })
    else
      new_cart.push(i)
    end
  end
  
  new_cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = Array.new
  
  cart.each do |i|
    if i[:clearance] == true
      i[:price] = (i[:price] * 0.8).round(2)
    end
    
    new_cart.push(i)
  end
  
  new_cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  cons_cart = consolidate_cart(cart)
  cons_coup_cart = apply_coupons(cons_cart, coupons)
  cons_coup_clear_cart = apply_clearance(cons_coup_cart)
  
  initial_total = 0
  
  cons_coup_clear_cart.each do |i|
    initial_total += i[:count] * i[:price]
  end
  
  final_total =
  
  if initial_total > 100
    final_total = (initial_total * 0.9).round(2)
  else
    final_total = initial_total
  end
  
  final_total
  
end
