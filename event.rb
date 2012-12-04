class Event
  attr_accessor :id, :published, :title, :summary, :start, :end, :where, :url

  def initialize(args)
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

end
