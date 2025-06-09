module ApplicationHelper
  # Allow nested layouts
  def parent_layout(layout)
    @view_flow.set(:layout, output_buffer)
    output = render(template: "layouts/#{layout}")
    self.output_buffer = ActionView::OutputBuffer.new(output)
  end
end

