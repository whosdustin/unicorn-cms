module ApplicationHelper
	# Clean Dates
	def cleandate(date)
      @mo = date.strftime('%b')
      @day = date.strftime('%d')
      @yr = date.strftime('%Y')
      return "#{@mo} #{@day}, #{@yr}"
    end
end
