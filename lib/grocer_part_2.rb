require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  require 'pry'

  if coupons != [] #test if there are any coupons
    
    cart.each do |line_item|

      saving=coupons.find {|coupon| line_item[:item]==coupon[:item]} #find any matching coupons to current item
      
      if saving != nil #if no matching coupons, skip to next item in cart
        
        if line_item[:count] % saving[:num] == 0 #if item in cart exact multiple of coupon number requirement

          coupon_item=line_item.clone
          coupon_item[:item] = coupon_item[:item] + " W/COUPON"
          coupon_item[:price] = saving[:cost]/saving[:num]
          line_item[:count]=0
          cart << coupon_item

          elsif line_item[:count] > saving[:num] #if item in cart > coupon requirement but not exact multiple 

          coupon_item=line_item.clone
          coupon_item[:item] = coupon_item[:item] + " W/COUPON"
          coupon_item[:price] = saving[:cost]/saving[:num]
          coupon_item[:count]=line_item[:count]/saving[:num]*saving[:num]
          line_item[:count]=line_item[:count]-coupon_item[:count]
          cart << coupon_item

        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.each do |line_item|
    if line_item[:clearance]
      #binding.pry
      line_item[:price] = (line_item[:price] * 0.8).round(2)
      #binding.pry
    end
  end
  
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

  consolidated_cart = consolidate_cart(cart)

  coupons_applied = apply_coupons(consolidated_cart,coupons)

  consolidated_with_disscounts_cart = apply_clearance(coupons_applied)

  total = consolidated_with_disscounts_cart.sum { |item| item[:price]*item[:count]}
  
  #check if total is >100, if so apply 10% disscount
  if total > 100
    total=(total*0.9).round(2)
  end
  total
end
