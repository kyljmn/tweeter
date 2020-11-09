module ImageHelper
  def fetch_images(twit)
    return render_images(twit.original.images) if twit.original.images.attached?
  end

  def render_images(images)
    render partial: "shared/image", collection: images
  end
end
