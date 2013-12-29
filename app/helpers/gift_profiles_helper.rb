module GiftProfilesHelper
  
  #attr_accessor :tier_3_first_total
  
  def sum(*args)
    args.map.inject(:+)
  end
  
  def subtract(*args)
    result = args.map.inject(:-)
    @families_total = result
  end
  
  def multiply(*args)
    result = args.map.inject(:*)
    @running_total = result
  end
  
  def total(*args)
    result = args.sum
    @cumulative_total = result
  end
  
  def total_for_remainder(*args)
    @tier_3_first_total = total(*args)
  end
  
  def commitments(gifts, amount)
    (0...gifts.count).inject(0) {|r, i| r + gifts[i]*amount[i]}
  end
  
  def times
    lambda {|x| x*@tier_1_total_amount.map}
  end
    
  def percent(gift_amount)
    result = (gift_amount.to_f / @gift_profile.goal.to_f) * 100
    number_to_percentage(result, :precision => 0)
  end
  
  def remainder_total_level
    tier_1_commitments = commitments(@tier_1_gifts, @tier_1_total_amount)
    tier_2_commitments = commitments(@tier_2_gifts, @tier_2_total_amount)
    tier_3_commitments = commitments(@tier_3_gifts, @tier_3_total_amount)
    if (@tier_3_gifts[0] || @tier_3_total_amount[0]) == 0
      0
    else
      (@gift_profile.goal - (tier_1_commitments + tier_2_commitments)) - tier_3_commitments
    end
  end
  
  def remainder_cumulative_total
    gift_multiple = multiply(@gift_profile.t3_gifts_1, @gift_profile.t3_gift_amount_1)
    tier_3_adjusted_commitments = commitments(@tier_3_gifts, @tier_3_total_amount) - gift_multiple
    remainder = remainder_total_level + tier_3_adjusted_commitments
    @tier_3_first_total + remainder
  end
  
  def tier_3_plus_remainder
    tier_3_commitments = commitments(@tier_3_gifts, @tier_3_total_amount)
    remainder = remainder_total_level
    tier_3_commitments + remainder
  end
  
  def final_commitments
    tier_commitments = commitments(@tier_1_gifts, @tier_1_total_amount) + commitments(@tier_2_gifts, @tier_2_total_amount)
    _tier_3_plus_remainder = tier_3_plus_remainder
    tier_commitments + _tier_3_plus_remainder
  end
end
