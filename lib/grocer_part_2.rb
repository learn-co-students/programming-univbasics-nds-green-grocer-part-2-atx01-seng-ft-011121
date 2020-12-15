require_relative './part_1_solution.rb' 
require 'pry'

# Consult README for inputs and outputs
#
# REMEMBER: This method **should** update cart
def apply_coupons(cart, coupons)
  coupons.each do |item_index|
    cart_item=find_item_by_name_in_collection(item_index[:item], cart)
    couponed_item_name="#{item_index[:item]} W/COUPON"
    cart_item_with_coupon=find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count]>=item_index[:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count]+=item_index[:num]
        cart_item[:count]-=item_index[:num]
      else
        cart_item_with_coupon={
          item: couponed_item_name,
          price: item_index[:cost]/item_index[:num],
          clearance: cart_item[:clearance],
          count: item_index[:num]
        }
        cart.push(cart_item_with_coupon)
        cart_item[:count]-=item_index[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item_index|
    if item_index[:clearance]
      item_index[:price]=(item_index[:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart_total=0.0
  consolidated_cart=consolidate_cart(cart)
  couponed_cart=apply_coupons(consolidated_cart, coupons)
  clearanced_cart=apply_clearance(couponed_cart)
  
  clearanced_cart.each do |item_index|
    item_total=(item_index[:count]*item_index[:price]).round(2)
    cart_total+=item_total
  end
  if cart_total>100
    cart_total=(cart_total*0.9).round(2)
  end
  cart_total  
end
