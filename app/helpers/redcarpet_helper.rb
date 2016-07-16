module RedcarpetHelper
	# Markdown Helper
  def markdown(text)
		Redcarpet::Markdown.new(HTMLBlockCode.new(
			:hard_wrap => false,
			:disable_indented_code_blocks => true),
			:filter_html => true,
			:space_after_headers => true,
			:fenced_code_blocks => true,
			:autolink => true,
			:strikethrough => true,
			:prettify => true,
			:superscript => true
		).render(text).html_safe
  end
end


class HTMLBlockCode < Redcarpet::Render::HTML
	include Sprockets::Rails::Helper
  include ActionView::Helpers::UrlHelper

  def image(link, title, alt_text)
		image_tag(link, :class => title, :alt => alt_text)
  end

	def link(link, title, content)
		link_to(content, link, :title => title, :rel => 'nofollow', :target => '_blank')
	end

end
