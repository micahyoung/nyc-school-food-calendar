class ContentLocation
  attr_reader :right_x, :bottom_y, :content

  def initialize(content, left_x, top_y, right_x, bottom_y)
    @content = content.strip
    @left_x, @top_y, @right_x, @bottom_y = left_x.to_i, top_y.to_i, right_x.to_i, bottom_y.to_i
  end
end
