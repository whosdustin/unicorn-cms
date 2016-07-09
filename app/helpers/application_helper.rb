module ApplicationHelper

  # Markdown Helper
  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

	# Clean Dates
	def cleandate(date)
      @mo = date.strftime('%b')
      @day = date.strftime('%d')
      @yr = date.strftime('%Y')
      return "#{@mo} #{@day}, #{@yr}"
    end
end
