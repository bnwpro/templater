module CampaignsHelper
  def list_or_init(data)
    collection = data
    collection.any? ? collection : collection.build
    #list_last(collection)
  end
  def show_if_exists(data)
    data unless @campaign.training_sheet.nil?
  end
  def list_last(data)
    collection = data
    collection.build
  end
  
  def multiply(*args)
    args.map.inject(:*)
  end
  
  def sum(*args)
    args.sum
  end
  
  
  
end
