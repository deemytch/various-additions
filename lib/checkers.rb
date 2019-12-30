require 'date'

module Checkers
  def self.tmout_any?( tlast, *models )
    !! models.select do |item|
      if item.respond_to?( :created_at )
        item.created_at + tlast < Time.now
      else
        case item
        when Date
          item + tlast < Time.now.to_date
        when DateTime
          item + tlast < Time.now.to_datetime        
        when Time, Date, DateTime
          item + tlast < Time.now
        when Numeric
          item + tlast < Time.now.to_i
        else
          raise ArgumentError.new( "Can't measure tmout for #{ item.class.name.to_s }." )
        end
      end
    end.any?
  end

  def self.tmout_all?( tlast, *models )
    !! ( models.select do |item|
      if item.respond_to?( :created_at )
        item.created_at + tlast < Time.now
      else
        case item
        when Date
          item + tlast < Time.now.to_date
        when DateTime
          item + tlast < Time.now.to_datetime        
        when Time, Date, DateTime
          item + tlast < Time.now
        when Numeric
          item + tlast < Time.now.to_i
        else
          raise ArgumentError.new( "Can't measure tmout for #{ item.class.name.to_s }." )
        end
      end
    end.count == models.count )
  end

end
