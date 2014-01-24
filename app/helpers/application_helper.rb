module ApplicationHelper
  def due_date
    strftime('%m %d')
  end
  def formatted_date(d) # Januaury 01, 2013
    d.strftime("%B %d, %Y") unless !d
  end
  def formatted_date_to_tomorrow(d) # Januaury 01 - 02, 2013
    tomorrow = d.tomorrow#.strftime('%B %d, %Y') unless !d
    #d.strftime("%B %d - #{tomorrow}") unless !d
    formatted_date_range(begin_date: d, end_date: tomorrow)
  end
  def formatted_date_range(options = {}) # Removes duplicate Months
    begin_date = options[:begin_date]
    end_date = options[:end_date]
    b = begin_date.strftime('%B %d') unless !begin_date
    e = end_date.strftime('%B %d, %Y') unless !end_date
    result = "#{b} - #{e}".split(" ").uniq
    result.join(" ")
  end
  
  # DEPRECTAED
  #def formatted_date_vari_begin(d) # Use in VARI Date range
  #  d.strftime('%B %d') unless !d
  #end
  #def formatted_date_vari_end(d) # Use in VARI Date range
  #  d.strftime('%d, %Y') unless !d
  #end
  
  def formatted_smalldate(d) # Mon, Januaury 01
    d.strftime('%b, %d') unless !d
  end
  def formatted_time(t) # 1:30 PM
    t.strftime('%-I:%M %p') unless !t
  end
  def formatted_datetime(dt) # January 1 - 1:30 PM
    dt.strftime('%B %-d - %-I:%M %p') unless !dt
    #date.strftime('%c')
  end
  def formatted_datetime_year(dt) # January 1, 2013 1:30 PM
    dt.strftime('%B %-d, %Y %-I:%M %p') unless !dt
  end
  def formatted_date_year(dy) # Monday, Januaury 01, 2013
    dy.strftime('%A, %B %d, %Y') unless !dy
  end
  
  def us_states
      [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
      ]
  end
end
